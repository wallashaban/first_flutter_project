//https://newsapi.org/v2/everything?q=tesla&from=2022-05-11&sortBy=publishedAt&apiKey=62a2fa11cbb24d14bf7b7e134d963cab    search

//https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=62a2fa11cbb24d14bf7b7e134d963cab      buisness

import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
     Map<String, dynamic>? query,
     String lang='en',
    String? token,
  }) async {
     dio!.options.headers = {
      'lang':lang,
      'Content-Type':'application/json',
      'Authorization':token,
    };
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang='en',
    String? token,
  }) async {
    dio!.options.headers = {
      'lang':lang,
      'Content-Type':'application/json',
      'Authorization':token,
    };
    return await dio!.post(url, queryParameters: query, data: data);
  }
}
