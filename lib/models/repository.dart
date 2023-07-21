import 'package:intl/intl.dart';

class Repository {
  final String name;
  final String ownerIconUrl;
  final String description;
  final String language;
  final int stars;
  final int watchers;
  final int forks;
  final int issues;
  final String htmlUrl;  // html_url -> htmlUrl
  final String license;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String ownerName;  // ower_name -> ownerName

  Repository({
    required this.name,
    required this.ownerIconUrl,
    required this.description,
    required this.language,
    required this.stars,
    required this.watchers,
    required this.forks,
    required this.issues,
    required this.htmlUrl,  // html_url -> htmlUrl
    required this.license,
    required this.createdAt,
    required this.updatedAt,
    required this.ownerName,  // ower_name -> ownerName
  });

  // データのパース用
  factory Repository.fromJson(Map<String, dynamic> json) {
    var inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
    var createdAt = inputFormat.parse(json['created_at']);
    var updatedAt = inputFormat.parse(json['updated_at']);
    String license = json['license'] != null ? json['license']['name'] : 'N/A';
    String ownerName = json['owner'] != null ? json['owner']['login'] : 'N/A';

    return Repository(
      name: json['name'],
      ownerIconUrl: json['owner']['avatar_url'],
      description: json['description'] ?? "N/A",
      language: json['language'] ?? "N/A",
      stars: json['stargazers_count'],
      watchers: json['watchers_count'],
      forks: json['forks_count'],
      issues: json['open_issues_count'],
      htmlUrl: json['html_url'],  // html_url -> htmlUrl
      ownerName: ownerName,  // ower_name -> ownerName
      license: license,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}