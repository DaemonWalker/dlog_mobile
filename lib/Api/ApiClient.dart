import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dlog_mobile/Api/ApiModels.dart';
import 'package:dlog_mobile/Api/ApiUrls.dart';
import 'package:flutter/cupertino.dart';

class ApiClient {
  static Future<T> get<T>(String url, T Function(ApiResponseModel) handler,
      [Map<String, String> parms]) async {
    var httpClient = new HttpClient();
    var uri = new Uri.https(ApiUrls.DOMAIN, url, parms);
    var request = await httpClient.getUrl(uri);
    var body = await (await request.close()).transform(Utf8Decoder()).join();
    // log(body);
    var apiResponse = ApiResponseModel.fromJson(jsonDecode(body));
    return handler(apiResponse);
  }

  static Future<T> post<T>(String url, Directory params) async {
    var httpClient = new HttpClient();
    var uri = new Uri.https(ApiUrls.DOMAIN, url);
    return null;
  }
}
