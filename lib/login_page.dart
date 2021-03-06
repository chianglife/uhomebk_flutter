// ignore_for_file: prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:toast/toast.dart';
import 'package:uhomebk_flutter/config/http_urls.dart';
import 'package:uhomebk_flutter/config/seg_colors.dart';
import 'package:uhomebk_flutter/http/http_cookie.dart';
import 'package:uhomebk_flutter/http/http_exception.dart';
import 'package:uhomebk_flutter/http/http_utils.dart';
import 'package:uhomebk_flutter/root_page.dart';
import 'package:uhomebk_flutter/http/http.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:uhomebk_flutter/sign_in_page.dart';
import 'package:uhomebk_flutter/user_info.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _username = '15019419141';
  // var _password = '5uYYGQmk';
    var _password = 'Lxq123456';
  late TextEditingController _usernameController;
  late TextEditingController _passwordcontroller;
  var dio = Dio();

  @override
  void initState() {
    super.initState();
    _usernameController =  TextEditingController(text: _username);
    _passwordcontroller =  TextEditingController(text: _password);
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          body: Stack(
        children: [
          Positioned(
            height: 211,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'assets/images/icons/bg_login_head.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
              left: 15,
              top: MediaQuery.of(context).padding.top + 80,
              width: MediaQuery.of(context).size.width - 30,
              height: MediaQuery.of(context).size.height - 182,
              child: _loginBox())
        ],
      )),
    );
  }

//????????????
  Widget _loginBox() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                  )
                ]),
          ),
        ),
        Positioned(
            top: 35,
            width: 75,
            height: 75,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(37.5),
                  border: Border.all(width: 0.5, color: SEGColors.color_l2)),
            )),
        Positioned(
            top: 39.5,
            child: Container(
              child: CircleAvatar(
                backgroundColor: Colors.black,
                radius: 33,
              ),
            )),
        Positioned(top: 160, left: 40, right: 40, child: _loginInfoBox())
      ],
    );
  }

//???????????????????????????
  Widget _loginInfoBox() {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('??????/?????????',
            style: TextStyle(color: SEGColors.color_4, fontSize: 13)),
        TextField(
          controller: _usernameController,
          onChanged: _usernameChanged,
          style: TextStyle(color: SEGColors.color_1, fontSize: 15),
          keyboardType: TextInputType.number,          
          decoration: const InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: InputBorder.none,
          ),
        ),

        Divider(height: 0.5, color: SEGColors.color_l2), //?????????

        SizedBox(height: 10),

        Text('??????', style: TextStyle(color: SEGColors.color_4, fontSize: 13)),
        TextField(
          controller: _passwordcontroller,
          onChanged: _passwordChanged,
          style: TextStyle(color: SEGColors.color_1, fontSize: 15),
          obscureText: true,
          decoration: const InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: InputBorder.none,
            ),
        ),

        Divider(height: 0.5, color: SEGColors.color_l2), //?????????

        Container(
          padding: EdgeInsets.fromLTRB(50, 40, 50, 0),
          child: InkWell(
            onTap: _loginTap,
            child: Container(
              alignment: Alignment.center,
              height: 44,
              child: Text('??????',
                  style: TextStyle(fontSize: 16, color: Colors.white)),
              decoration: BoxDecoration(
                color: Color(0xff3E5DE1),
                borderRadius: BorderRadius.circular(22),
              ),
            ),
          ),
        )
      ]),
    );
  }

//????????????
  void _passwordChanged(value) {
    setState(() {
      _password = value;
    });
  }

//????????????
  void _usernameChanged(value) {
    setState(() {
      _username = value;
      print(_username);
    });
  }

  //????????????????????????
  Future<void> _loginTap() async {
    var params = {
      "username": _username,
      "password": _password,
      "businessCode": "B_APP_LOGIN",
      "loginType": "1"
    };
    Http().dio.interceptors.add(CookieManager((await HttpCookie.cookieJar)));//???????????????cookie????????????????????????????????????cookie
    await (await HttpCookie.cookieJar).deleteAll();//???????????????cookie
    print(Http().dio.interceptors.toList());

    EasyLoading.show(status: "????????????");
    try {
      Response response = await HttpUtils.post(kServer_login,params: params);
      if (response.statusCode == 0) {
        requesUserInfo();//??????????????????
      } 
    } on HttpException catch(e) {
      Toast.show(e.msg!, duration: Toast.lengthLong, gravity: Toast.bottom);
    } finally {
      EasyLoading.dismiss();
    }
  }

  void requesUserInfo() async {
    Response response = await HttpUtils.get(kServer_userInfo);
    if (response.statusCode == 0) {
      Map<String, dynamic> result = Map.from(response.data);
      UserInfo.save(result["data"]);//????????????????????????
      Http().setHeaders({"communityId" : UserInfo.jobCommunity});//???????????????????????????id
      //????????????????????????????????????????????????rootpage
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => SignInPage()), (route) => false);
    } 
  }
}
