import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/github_service.dart';

class ResultCount extends StatelessWidget {
  final String result;

  const ResultCount({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(
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
                  '${provider.totalCount}$result',
                  textAlign: TextAlign.start,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
