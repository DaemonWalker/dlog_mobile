import 'dart:collection';
import 'dart:convert';

import 'dart:developer';

class ApiResponseModel {
  ServerResponseModel serverResponse;
  List<ArticleSummaryModel> articleSummaries;
  ArticleInfoModel article;
  ApiResponseModel({this.articleSummaries, this.article});
  factory ApiResponseModel.fromJson(Map<String, dynamic> json) {
    List<ArticleSummaryModel> articleSummaries = List.empty();
    if (json['articleSummaries'] != null) {
      articleSummaries = (json['articleSummaries'] as List)
          .map((e) => ArticleSummaryModel.fromDynamic(e))
          .toList();
    }
    return ApiResponseModel(
        articleSummaries: articleSummaries,
        article: ArticleInfoModel.fromMap(json['article']));
  }
}

class ServerResponseModel {
  int statusCode;
}

class ArticleSummaryModel {
  String title;
  String summary;
  String url;
  List<String> tags;
  int seen;
  String cover;

  ArticleSummaryModel(
      {this.title, this.summary, this.url, this.tags, this.seen, this.cover});

  factory ArticleSummaryModel.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }
    return ArticleSummaryModel(
        title: json['title'],
        summary: json['summary'],
        url: json['url'],
        tags: (json['tags'] as List).map((e) => e.toString()),
        seen: json['seen'],
        cover: json['cover']);
  }
  factory ArticleSummaryModel.fromDynamic(dynamic obj) {
    if (obj == null) {
      return null;
    }
    return ArticleSummaryModel(
        title: obj["title"],
        summary: obj["summary"],
        url: obj["url"],
        tags: (obj["tags"] as List).cast<String>(),
        seen: obj["seen"],
        cover: obj["cover"]);
  }
}

class ArticleInfoModel {
  String title;
  String content;
  List<String> tags;
  ArticleInfoModel({this.title, this.content, this.tags});
  factory ArticleInfoModel.fromMap(Map<String, dynamic> map) {
    if (map != null) {
      return ArticleInfoModel(
          title: map["title"],
          content: map["content"],
          tags: (map["tags"] as List).cast<String>());
    } else {
      return null;
    }
  }
}
