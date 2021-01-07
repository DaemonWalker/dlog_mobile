import 'dart:developer';

import 'package:dlog_mobile/Api/ApiClient.dart';
import 'package:dlog_mobile/Api/ApiModels.dart';
import 'package:dlog_mobile/widgets/loading.dart';
import 'package:dlog_mobile/widgets/tags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'Api/ApiUrls.dart';

class ArticleDetail extends StatefulWidget {
  ArticleDetail({Key key}) : super(key: key) {}
  @override
  State<StatefulWidget> createState() => ArticleDetailState();
}

class ArticleDetailState extends State<ArticleDetail> {
  Future<ArticleInfoModel> fetchArticle() async {
    var article = await ApiClient.get(
        ApiUrls.API_ARTICLE, (res) => res.article, {"id": "aspect-demo"});
    return article;
  }

  Widget articleFutureBuilder(BuildContext context, AsyncSnapshot snapshot) {
    return loading(context, snapshot, buildArticle);
  }

  Widget buildArticle(BuildContext context, AsyncSnapshot snapshot) {
    var article = snapshot.data as ArticleInfoModel;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              article.title,
              style: TextStyle(fontSize: 30),
            ),
            tagList(article.tags),
            Expanded(
              child: Markdown(
                data: article.content,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder(
            future: this.fetchArticle(),
            builder: articleFutureBuilder,
          ),
        ),
      ],
    );
  }
}
