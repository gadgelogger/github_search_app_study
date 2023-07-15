import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:github_search_app_study/services/github_service.dart';
import 'package:shimmer/shimmer.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController _controller =
      TextEditingController(); //検索フィールドのコントロール用
  final outputFormat = DateFormat('yyyy/MM/dd/ HH:mm'); //日付のフォーマット用

  SearchScreen({Key? key}) : super(key: key);

  //読み込み時に表示するWidget
  Widget _buildShimmer(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (_, __) => Shimmer.fromColors(
        baseColor: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
        highlightColor: isDarkMode ? Colors.grey[600]! : Colors.grey[200]!,
        child: ListTile(
          leading: ClipOval(
            child: Container(
              width: 50,
              height: 50,
              color: Colors.white,
            ),
          ),
          title: const SizedBox(
            height: 20,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10.0,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  const Icon(Icons.star_border, color: Colors.white),
                  const SizedBox(
                    width: 50.0,
                    height: 10.0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 10.0,
                    height: 10.0,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 5.0),
                  const SizedBox(
                    width: 100.0,
                    height: 10.0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); //キーボードのフォーカス関連
      },
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: PreferredSize(
            preferredSize: const Size.fromHeight(60.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      //検索フィールド
                      controller: _controller,
                      onSubmitted: (value) {
                        context.read<SearchProvider>().search(value);
                      },
                      decoration: InputDecoration(
                        hintText: 'search',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            _controller.clear();
                            context.read<SearchProvider>().clear();
                          },
                        ),
                        filled: true,
                        fillColor:
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.grey[300]
                                : Colors.grey[800],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20.0),
                      ),
                    ), //検索フォールド（ここまで）
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Consumer<SearchProvider>(
              builder: (_, provider, __) {
                if (provider.hasSearched &&
                    !provider.isLoading &&
                    provider.errorMessage.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '${provider.totalCount}',
                          textAlign: TextAlign.start,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
            Expanded(
              child: Consumer<SearchProvider>(
                builder: (_, provider, __) {
                  if (provider.isLoading) {
                    return _buildShimmer(context);
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
                    return const Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                width: 200,
                                height: 200,
                                child: Image(
                                  image: AssetImage('assets/search.gif'),
                                  fit: BoxFit.cover,
                                )),
                            SizedBox(
                              height: 50,
                            ),
                            Text(
                              'hello',
                              style: TextStyle(fontSize: 18),
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
                                              CrossAxisAlignment.start, // 追加
                                          children: <Widget>[
                                            Row(
                                              children: [
                                                const SizedBox(width: 8.0),
                                                Expanded(
                                                  child: Text(
                                                    repository.description,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                    Icons.remove_red_eye),
                                                const SizedBox(width: 8.0),
                                                Text('${repository.watchers}'),
                                                const Text('Watchers',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w200))
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Icon(Icons.call_split),
                                                const SizedBox(width: 8.0),
                                                Text('${repository.forks}'),
                                                const Text('Forks',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w200))
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                    Icons.report_problem),
                                                const SizedBox(width: 8.0),
                                                Text('${repository.issues}'),
                                                const Text('Issues',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w200))
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Icon(Icons.book_rounded),
                                                const SizedBox(width: 8.0),
                                                Text(
                                                  repository.license,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Icon(Icons.access_time),
                                                const SizedBox(width: 8.0),
                                                Text(
                                                  outputFormat.format(
                                                      repository.createdAt),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Icon(Icons.access_time),
                                                const SizedBox(width: 8.0),
                                                Text(
                                                  outputFormat.format(
                                                      repository.updatedAt),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Icon(Icons.person),
                                                const SizedBox(width: 8.0),
                                                Text(repository.ownerName),
                                              ],
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
                                                          Uri.parse(url));
                                                    } else {
                                                      throw 'Could not launch $url';
                                                    }
                                                  },

                                                  label: Text(
                                                    'open',
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                                  .brightness ==
                                                              Brightness.light
                                                          ? Colors.white
                                                          : Colors.white,
                                                    ),
                                                  ),
                                                  //テキスト
                                                  icon: Icon(
                                                    Icons.open_in_new_outlined,
                                                    color: Theme.of(context)
                                                                .brightness ==
                                                            Brightness.light
                                                        ? Colors.white
                                                        : Colors.white,
                                                  ),
                                                  //アイコン
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
