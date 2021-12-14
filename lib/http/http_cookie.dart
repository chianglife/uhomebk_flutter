import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';

class HttpCookie {
  static late  PersistCookieJar _cookieJar;
  static Future<PersistCookieJar> get cookieJar async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    _cookieJar =
        PersistCookieJar(storage: FileStorage(appDocPath + "/.cookies/"));
    return _cookieJar;
  }
}
