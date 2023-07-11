import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:github_search_app_study/models/repository.dart';
class GithubService {
  Future<SearchResult> searchRepositories(String keyword, {int page = 1}) async {
    final response = await http.get(
      Uri.parse('https://api.github.com/search/repositories?q=$keyword&page=$page'),
    );

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      int totalCount = json['total_count'];
      List<dynamic> items = json['items'];
      List<Repository> repositories = items.map((item) => Repository.fromJson(item)).toList();
      return SearchResult(totalCount: totalCount, items: repositories);
    } else {
      throw Exception('Failed to load repositories');
    }
  }
}

class SearchProvider extends ChangeNotifier {
  final GithubService _githubService = GithubService();
  List<Repository> _repositories = [];
  bool _isLoading = false;
  bool _isLoadingMore = false; // <- added this line
  bool _hasSearched = false;
  String _errorMessage = '';
  int _totalCount = 0;

  List<Repository> get repositories => _repositories;
  bool get isLoading => _isLoading;
  bool get isLoadingMore => _isLoadingMore; // <- added this line
  bool get hasSearched => _hasSearched;
  String get errorMessage => _errorMessage;
  int get totalCount => _totalCount;



  void clear() {
    _repositories = [];
    _isLoading = false;
    _isLoadingMore = false; // <- added this line
    _hasSearched = false;
    _errorMessage = '';
    _totalCount = 0;
    notifyListeners();
  }




}


class SearchResult {
  final int totalCount;
  final List<Repository> items;

  SearchResult({required this.totalCount, required this.items});
}