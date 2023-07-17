import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:github_search_app_study/services/github_service.dart';
import 'package:github_search_app_study/i18n/translations.g.dart';
import '../components/appbar.dart';
import '../components/list.dart';
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
                      child: RepositoryList(
                        open: open,
                        outputFormat: outputFormat,
                        make: make,
                        update: update,
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
