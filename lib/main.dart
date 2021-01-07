import 'dart:developer';

import 'package:dlog_mobile/Api/ApiClient.dart';
import 'package:dlog_mobile/Api/ApiModels.dart';
import 'package:dlog_mobile/Api/ApiUrls.dart';
import 'package:dlog_mobile/artile.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daemon\'s blog',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.grey,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:  ArticleDetail(),
      // MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  ApiResponseModel apiResponse;

  Widget articleList(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.hasData == false) {
      return Text('这玩意挂了好像？');
    }
    if (snapshot.connectionState == ConnectionState.none) {
      return Text('还没发呢');
    } else if (snapshot.connectionState == ConnectionState.active) {
      return Text('active');
    } else if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      }
      return createSummaryView(context, snapshot);
    }
  }

  Widget createSummaryView(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
      //数据处理
      var data = snapshot.data;
      List<ArticleSummaryModel> listData = (data as List);

      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          ArticleSummaryModel item = listData[index];
          return _listItemBuilder(item);
        },
        itemCount: listData.length,
      );
    }
  }

  Widget _listItemBuilder(ArticleSummaryModel item) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(
          top: 10,
        ),
        height: 60,
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 100,
              child: Text(
                '${item.title}',
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Image.network(ApiUrls.IMAGE + item.cover)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: FutureBuilder(
                  future: getSummaryData(), builder: articleList)),
        ),
      ),
    );
  }

  Future<List<ArticleSummaryModel>> getSummaryData() async {
    log("start get data");
    var list =
        await ApiClient.get(ApiUrls.API_INDEX, (res) => res.articleSummaries);
    return list;
  }
}
