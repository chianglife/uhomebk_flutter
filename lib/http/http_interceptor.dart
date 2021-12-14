
import 'package:dio/dio.dart';
import 'package:uhomebk_flutter/http/http_exception.dart';

class HttpInterceptor extends Interceptor{
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    HttpException httpException = HttpException.create(err);
    err.error = httpException;
    super.onError(err, handler);
  }
}