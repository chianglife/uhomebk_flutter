import 'package:uhomebk_flutter/user_info.dart';

class HttpOptions {
  static const int CONNECT_TIMEOUT = 5000;
  static const int RECEIVE_TIMEOUT = 5000;

  static final int communityId = UserInfo.jobCommunity;

  static const Map<String, dynamic> headers = {"source" : "2",
                              "version" : "86",
                              "platform" : "SEGI",
                              "clientType" : "SEGIBK",
                              };
  
  static const String kRootServer = "https://www.uhomecp.com";
  static const String kPicServer = "https://pic.uhomecp.com";
  static const String kPicServerSmall = "https://pic.uhomecp.com/small";

}
