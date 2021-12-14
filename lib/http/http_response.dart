import 'package:uhomebk_flutter/http/http_exception.dart';

class HttpResponse {
  late bool ok;
  dynamic? data;
  HttpException? error;

  HttpResponse._internal({this.ok = false});

  HttpResponse.success(this.data) {
    this.ok = true;
  }

  HttpResponse.failure({String? errorMsg, int? erroCode}) {
    this.error = HttpException(code: erroCode, msg: errorMsg);
    this.ok =false;
  }
}