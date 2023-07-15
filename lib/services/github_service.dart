import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:github_search_app_study/models/repository.dart';
import 'package:flutter/foundation.dart';
import 'package:github_search_app_study/i18n/translations.g.dart';

class GithubService {
  Future<SearchResult> searchRepositories(String keyword,
      {int page = 1}) async {
    final response = await http.get(
      Uri.parse(
          'https://api.github.com/search/repositories?q=$keyword&page=$page'),
    );

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      int totalCount = json['total_count'];
      List<dynamic> items = json['items'];
      List<Repository> repositories =
          items.map((item) => Repository.fromJson(item)).toList();
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

  //多言語化用
  String error = t.error;
  String none = t.none;

  void clear() {
    _repositories = [];
    _isLoading = false;
    _isLoadingMore = false; // <- added this line
    _hasSearched = false;
    _errorMessage = '';
    _totalCount = 0;
    notifyListeners();
  }

  Future<void> search(String keyword) async {
    _isLoading = true;
    _hasSearched = true;
    _errorMessage = '';
    notifyListeners();
    try {
      var result = await _githubService.searchRepositories(keyword);
      _repositories = result.items;
      _totalCount = result.totalCount;
      if (_repositories.isEmpty) {
        _errorMessage = none;
      }
    } catch (e) {
      _errorMessage = error;
    }
    _isLoading = false;
    notifyListeners();
  }

  // fetchMore method
  Future<void> fetchMore(String keyword) async {
    _isLoadingMore = true; // Set loading more to true
    notifyListeners();
    try {
      // Fetch next page of results based on the current list length
      final result = await _githubService.searchRepositories(keyword,
          page: _repositories.length ~/ 10 + 1);
      // Add new items to our list
      _repositories.addAll(result.items);
      _totalCount = result.totalCount;
      if (_repositories.isEmpty) {
        _errorMessage = none;
      }
    } catch (e) {
      _errorMessage = error;
    }
    _isLoadingMore = false; // Set loading more to false
    notifyListeners();
  }
}

class SearchResult {
  final int totalCount;
  final List<Repository> items;

  SearchResult({required this.totalCount, required this.items});
}
