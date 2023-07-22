import 'package:flutter_test/flutter_test.dart';
import 'package:github_search_app_study/services/github_service.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {
  void main() {
    group('GithubService', () {
      test('returns SearchResult if the http call completes successfully',
          () async {
        final client = MockClient();

        // Use Mockito to return a successful response when it calls the
        // provided http.Client.
        when(client.get(any)).thenAnswer((_) async =>
            http.Response('{"total_count": 10, "items": []}', 200));

        expect(await GithubService(client).searchRepositories('flutter'),
            isA<SearchResult>());
      });

      test('throws an exception if the http call completes with an error', () {
        final client = MockClient();

        // Use Mockito to return an unsuccessful response when it calls the
        // provided http.Client.
        when(client.get(any))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        expect(
            GithubService(client).searchRepositories('test'), throwsException);
      });
    });
  }
}
