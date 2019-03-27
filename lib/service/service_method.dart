import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import 'package:tt_flutter/config/service_url.dart';

// 获取首页主题内容

Future getHomePageContent() async {
  try {
    Response response;
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded");
    var formData = {'lon': '115.02932', 'lat': '35.76189'};
    response = await dio.post(servicePath['homePageContent'], data: formData);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw (" 后台出问题了。");
    }
  } catch (e) {
    return print(e);
  }
}
