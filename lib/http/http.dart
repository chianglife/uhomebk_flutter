import 'dart:convert';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:uhomebk_flutter/config/http_options.dart';
import 'package:uhomebk_flutter/http/http_cookie.dart';
import 'package:uhomebk_flutter/http/http_interceptor.dart';
import 'package:uhomebk_flutter/http/proxy.dart';

class Http {
  static final Http _instance = Http._internal();
  factory Http() => _instance;

  late Dio dio;

  //命名构造函数
 Http._internal() {
      // BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
      BaseOptions options = BaseOptions(
          connectTimeout: HttpOptions.CONNECT_TIMEOUT, 
          receiveTimeout: HttpOptions.RECEIVE_TIMEOUT,
          baseUrl: HttpOptions.kRootServer,
          contentType: 'application/json; charset=utf-8',
          headers: HttpOptions.headers);
          
      dio = Dio(options);
      
      //添加拦截器
      dio.interceptors.add(HttpInterceptor());

      // 在调试模式下需要抓包调试，所以我们使用代理，并禁用HTTPS证书校验
      if (PROXY_ENABLE) {
        (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
            (client) {
          client.findProxy = (uri) {
            return "PROXY $PROXY_IP:$PROXY_PORT";
          };
          //代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
          client.badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
        };
      }
  }

  // 设置headers
  void setHeaders(Map<String, dynamic> map) {
    dio.options.headers.addAll(map);
  }

  void clearHeaders() {
    dio.options.headers.clear();
  }

  Future get(
    String path, 
    {Map<String, dynamic>? params,
    Options? options}) async {
      Options requestOptions = options ?? Options();
      Response response = await dio.get(path, queryParameters: params, options: requestOptions);
    return response;
  }

  Future post(
    String path, 
    {Map<String, dynamic>? params,
    data,
    Options? options}) async {
      Options requestOptions = options ?? Options();
      Response response = await dio.post(path, data: data, queryParameters: params, options: requestOptions);
    return response;
  }

  // Future postJson(
  //   String path, 
  //   {Map<String, dynamic>? params,
  //   data,
  //   Options? options}) async {
  //     Options requestOptions = options ?? Options();
  //     Response response = await dio.post(path,data: data, queryParameters: params, options: requestOptions);
  //   return response;
  // }

//文件传输
    Future postForm(
    String path, 
    {Map<String, dynamic>? params,
    data,
    Options? options}) async {
      Options requestOptions = options ?? Options();
      Response response = await dio.post(path,data: FormData.fromMap(params!), options: requestOptions);
    return response;
  }
    
}
