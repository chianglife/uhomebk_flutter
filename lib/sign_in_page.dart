import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:uhomebk_flutter/config/http_urls.dart';
import 'package:uhomebk_flutter/config/seg_colors.dart';
import 'package:uhomebk_flutter/http/http.dart';
import 'package:uhomebk_flutter/http/http_utils.dart';
import 'package:uhomebk_flutter/user_info.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
        appBar: AppBar(title: const Text("打卡")),
        body: 
          Container(
            margin: const EdgeInsets.all(0),
            child: Center(
              child: InkWell(child: _clipButton(), onTap: _signin),
            ),
          )
      );
  }


  Widget _clipButton() {
      return ClipRRect(
        borderRadius: BorderRadius.circular(75),
        child: Container(
          width: 150,
          height: 150,
          color: SEGColors.color_t,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('打卡', style: TextStyle(color: Colors.white, fontSize: 24)),
            ],
          ),
        ),
      );
    }

  void _signin() {
    sumbitCheckingin();
  }

  void sumbitCheckingin() async {
    var params = {  
      "userId": UserInfo.userId,
      "deviceid": "1-3A87B52D-6CD9-4455-B987-809BCB54EF49",
      "phoneName": "M2104K10AC",
      "equipmentType": "5",
      "address": "中国广东省深圳市南山区粤海街道海天二路",
      "longitude": 113.946857,
      "latitude": 22.528235
    };
    Response response = await HttpUtils.postJson(kServer_sumbitCheckingin, params: params);
      Map<String, dynamic> result = Map.from(response.data);
      if (response.statusCode == 0) {
         Toast.show(result.toString(), duration: Toast.lengthLong, gravity: Toast.bottom);
      } else {
         Toast.show(result.toString(), duration: 5, gravity: Toast.bottom);
      }
  }

}