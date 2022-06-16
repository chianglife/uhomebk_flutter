import 'package:uhomebk_flutter/user_info.dart';

class HttpOptions {
  static const int CONNECT_TIMEOUT = 5000;
  static const int RECEIVE_TIMEOUT = 5000;

  static final int communityId = UserInfo.jobCommunity;

  static const Map<String, dynamic> headers = {"source" : "4",
                              "version" : "97",
                              "platform" : "SEGI",
                              "clientType" : "SEGIBK",
                              "systemVersionCode" : "30",
                              "phoneModel" : "M2104K10AC",
                              "deviceId" : "1-3A87B52D-6CD9-4455-B987-809BCB54EF49",
                              };
  
  static const String kRootServer = "https://www.uhomecp.com";
  static const String kPicServer = "https://pic.uhomecp.com";
  static const String kPicServerSmall = "https://pic.uhomecp.com/small";

  // static const String kRootServer = "http://beta.uhomecp.com";
  // static const String kPicServer = "https://betapic.uhomecp.com";
  // static const String kPicServerSmall = "https://betapic.uhomecp.com/small";


}
