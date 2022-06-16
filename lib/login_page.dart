// ignore_for_file: prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:uhomebk_flutter/config/http_urls.dart';
import 'package:uhomebk_flutter/config/seg_colors.dart';
import 'package:uhomebk_flutter/http/http_cookie.dart';
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

//登录框框
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

//登录账号和密码控件
  Widget _loginInfoBox() {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('工号/手机号',
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

        Divider(height: 0.5, color: SEGColors.color_l2), //分割线

        SizedBox(height: 10),

        Text('密码', style: TextStyle(color: SEGColors.color_4, fontSize: 13)),
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

        Divider(height: 0.5, color: SEGColors.color_l2), //分割线

        Container(
          padding: EdgeInsets.fromLTRB(50, 40, 50, 0),
          child: InkWell(
            onTap: _loginTap,
            child: Container(
              alignment: Alignment.center,
              height: 44,
              child: Text('登录',
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

//密码绑定
  void _passwordChanged(value) {
    setState(() {
      _password = value;
    });
  }

//账号绑定
  void _usernameChanged(value) {
    setState(() {
      _username = value;
      print(_username);
    });
  }

  //登录请求接口操作
  Future<void> _loginTap() async {
    var params = {
      "username": _username,
      "password": _password,
      "businessCode": "B_APP_LOGIN",
      "loginType": "1"
    };
    Http().dio.interceptors.add(CookieManager((await HttpCookie.cookieJar)));//需要先添加cookie拦截器，否则无法自动管理cookie
    await (await HttpCookie.cookieJar).deleteAll();//删除之前的cookie
    print(Http().dio.interceptors.toList());

    Response response = await HttpUtils.post(kServer_login,params: params);
    if (response.statusCode == 0) {
      requesUserInfo();//请求个人信息
    } 
  }

  void requesUserInfo() async {
    Response response = await HttpUtils.get(kServer_userInfo);
    if (response.statusCode == 0) {
      Map<String, dynamic> result = Map.from(response.data);
      UserInfo.save(result["data"]);//全局保存用户信息
      Http().setHeaders({"communityId" : UserInfo.jobCommunity});//请求头添加组织机构id
      //跳转到打卡页面，如果走菜单页面跳rootpage
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => SignInPage()), (route) => false);
    } 
  }
}
