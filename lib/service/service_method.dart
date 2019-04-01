import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import 'package:tt_flutter/config/service_url.dart';

// 获取首页主题内容

Future request(path, {formdata}) async {
  try {
    print('开始获取${path}接口数据');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded");
    response = await dio.post(servicePath[path], data: formdata);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw ('获取数据出错:状态码为 + ${response.statusCode}');
    }
  } catch (e) {
    return print(e);
  }
}



//Future getHomePageContent() async {
//  try {
//    print('开始获取首页主体数据...');
//    Response response;
//    Dio dio = new Dio();
//    dio.options.contentType =
//        ContentType.parse("application/x-www-form-urlencoded");
//    var formData = {'lon': '115.02932', 'lat': '35.76189'};
//    response = await dio.post(servicePath['homePageContent'], data: formData);
//    if (response.statusCode == 200) {
//      return response.data;
//    } else {
//      throw (" 后台出问题了。");
//    }
//  } catch (e) {
//    return print(e);
//  }
//}
//
//// 获取首页主题内容
//Future getHomePageBelowContent() async {
//  try {
//    print('开始获取火爆专区数据...');
//    Response response;
//    Dio dio = new Dio();
//    dio.options.contentType =
//        ContentType.parse("application/x-www-form-urlencoded");
//    int page = 1;
//    response = await dio.post(servicePath['homePageBelowConten'], data: page);
//    if (response.statusCode == 200) {
//      return response.data;
//    } else {
//      throw (" 后台出问题了。");
//    }
//  } catch (e) {
//    return print(e);
//  }
//}
