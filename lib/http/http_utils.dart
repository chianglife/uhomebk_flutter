
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:uhomebk_flutter/http/http.dart';
import 'package:uhomebk_flutter/http/http_cookie.dart';
import 'package:uhomebk_flutter/http/http_exception.dart';
import 'http_exception.dart';

class HttpUtils {
  static void setHeaders(Map<String, dynamic> map) {
    Http().setHeaders(map);
  }

  static Future get(
    String path, {
    Map<String, dynamic>? params,
    Options? options,
  }) async {
     try {
    Response response = await Http().get(
      path,
      params: params,
      options: options,
    );
    print(response);
    return handleResponse(response);
    } on DioError catch (err) {
      throw HttpException.create(err);
    }
    
  }

  static Future post(
    String path, {
    data,
    Map<String, dynamic>? params,
    Options? options,
  }) async {
    try {
      Response response = await Http().post(
        path,
        data: data,
        params: params,
        options: options,
      );
      print(response);
      return handleResponse(response);
    } on DioError catch (err) {
      throw HttpException.create(err);
    }
  }

  static Future postJson(
    String path, {
    data,
    Map<String, dynamic>? params,
    Options? options,
  }) async {
    try {
      var jsonData = jsonEncode(params);
      Response response = await Http().post(
        path,
        data: jsonData,
        options: options,
      );
      print(response);
      return handleResponse(response);
    } on DioError catch (err) {
      throw HttpException.create(err);
    }
  }

  static Future postForm(
    String path, {
    data,
    Map<String, dynamic>? params,
    Options? options,
  }) async {
    try {
      Response response = await Http().postForm(
        path,
        data: data,
        params: params,
        options: options,
      );
      print(response);
      return handleResponse(response);
    } on DioError catch (err) {
      throw HttpException.create(err);
    }
  }

 static Future<Response> handleResponse(Response response) async {
    //??????cookie
    List<Cookie> cookies =  await (await HttpCookie.cookieJar).loadForRequest(Uri.parse(response.realUri.toString()));
    //??????cookie
    await (await HttpCookie.cookieJar).saveFromResponse(Uri.parse(response.realUri.toString()), cookies);

    print(cookies);

    response.statusCode = 0;//????????????
      response.statusMessage = response.data['message'];

      if (response.data['code'] == '0000002') {
        response.statusCode = -1;
        await (await HttpCookie.cookieJar).delete(response.realUri);//????????????uri???cookie
      }
      if (response.data['code'] == '-1') {
        response.statusCode = -1;
      }
      return response;
  }
}
