import 'package:flutter/material.dart';
import 'package:github_search_app_study/components/detail_row.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:github_search_app_study/services/github_service.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:github_search_app_study/i18n/translations.g.dart';

import '../components/appbar.dart';
import '../components/loading_shimmer.dart';
import '../components/searchresult.dart';

//例外クラスを作成
class Webview implements Exception {
  final String url;

  Webview(this.url);

  @override
  String toString() => 'Could not launch $url';
}

class SearchScreen extends StatelessWidget {
  final TextEditingController _controller =
      TextEditingController(); //検索フィールドのコントロール用
  final outputFormat = DateFormat('yyyy/MM/dd/ HH:mm'); //日付のフォーマット用

  SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String hello = t.hello;
    String search = t.search;
    String result = t.result;
    String open = t.open;
    String make = t.make;
    String update = t.update;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); //キーボードのフォーカス関連
      },
      child: Scaffold(
        appBar: CustomAppBar(
          controller: _controller,
          search: search,
        ),
        body: Column(
          children: [
            ResultCount(result: result),
            Expanded(
              child: Consumer<SearchProvider>(
                builder: (_, provider, __) {
                  if (provider.isLoading) {
                    return const LoadingShimmer();
                  } else if (provider.errorMessage.isNotEmpty) {
                    return Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                            width: 200,
                            height: 200,
                            child: Image(
                              image: AssetImage('assets/error.gif'),
                              fit: BoxFit.cover,
                            )),
                        const SizedBox(
                          height: 50,
                        ),
                        Text(
                          provider.errorMessage,
                          style: const TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ));
                  } else if (provider.repositories.isEmpty) {
                    return Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                                width: 200,
                                height: 200,
                                child: Image(
                                  image: AssetImage('assets/search.gif'),
                                  fit: BoxFit.cover,
                                )),
                            const SizedBox(
                              height: 50,
                            ),
                            Text(
                              hello,
                              style: const TextStyle(fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return NotificationListener<ScrollNotification>(
                      onNotification: (notification) {
                        if (notification is ScrollEndNotification &&
                            notification.metrics.pixels >=
                                notification.metrics.maxScrollExtent - 200) {
                          provider.fetchMore(_controller.text);
                        }
                        return false;
                      },
                      child: ListView.builder(
                        itemCount: provider.repositories.length +
                            (provider.isLoadingMore ? 1 : 0),
                        itemBuilder: (_, index) {
                          if (index < provider.repositories.length) {
                            final repository = provider.repositories[index];
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 6.0),
                                  child: ExpansionTileCard(
                                    leading: ClipOval(
                                      child: Image.network(
                                        repository.ownerIconUrl,
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    title: Text(
                                      repository.name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? Colors.black
                                              : Colors.white),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.star_border,
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? Colors.black
                                                    : Colors.white),
                                            Text(
                                              '${repository.stars}',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                              .brightness ==
                                                          Brightness.light
                                                      ? Colors.black
                                                      : Colors.white),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Container(
                                              width: 10.0,
                                              height: 10.0,
                                              decoration: const BoxDecoration(
                                                color: Colors.green,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            const SizedBox(width: 5.0),
                                            Text(
                                              repository.language,
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? Colors.black
                                                    : Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    children: <Widget>[
                                      Divider(
                                        height: 1.0,
                                        color: Theme.of(context).brightness ==
                                                Brightness.light
                                            ? Colors.grey[300]
                                            : Colors.grey[800],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            DetailRow(
                                              iconData: Icons.remove_red_eye,
                                              text:
                                                  '${repository.watchers} watchers',
                                            ),
                                            DetailRow(
                                              iconData: Icons.call_split,
                                              text: '${repository.forks} forks',
                                            ),
                                            DetailRow(
                                              iconData: Icons.report_problem,
                                              text:
                                                  '${repository.issues} issues',
                                            ),
                                            DetailRow(
                                              iconData: Icons.book_rounded,
                                              text: repository.license,
                                            ),
                                            DetailRow(
                                              iconData: Icons.access_time,
                                              text:
                                                  '${outputFormat.format(repository.createdAt)}$make',
                                            ),
                                            DetailRow(
                                              iconData: Icons.access_time,
                                              text:
                                                  '${outputFormat.format(repository.updatedAt)}$update',
                                            ),
                                            DetailRow(
                                              iconData: Icons.person,
                                              text: repository.ownerName,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                FloatingActionButton.extended(
                                                  onPressed: () async {
                                                    String url =
                                                        repository.htmlUrl;
                                                    if (await canLaunchUrl(
                                                        Uri.parse(url))) {
                                                      await launchUrl(
                                                        Uri.parse(url),
                                                        mode: LaunchMode
                                                            .externalApplication,
                                                      );
                                                    } else {
                                                      throw Webview(url);
                                                    }
                                                  },
                                                  label: Text(
                                                    open,
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                                  .brightness ==
                                                              Brightness.light
                                                          ? Colors.white
                                                          : Colors.white,
                                                    ),
                                                  ),
                                                  icon: Icon(
                                                    Icons.open_in_new_outlined,
                                                    color: Theme.of(context)
                                                                .brightness ==
                                                            Brightness.light
                                                        ? Colors.white
                                                        : Colors.white,
                                                  ),
                                                  backgroundColor:
                                                      Theme.of(context)
                                                                  .brightness ==
                                                              Brightness.light
                                                          ? Colors.black
                                                          : Colors.grey[700],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          } else if (provider.isLoadingMore) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
