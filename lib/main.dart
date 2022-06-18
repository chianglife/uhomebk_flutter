import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:uhomebk_flutter/config/seg_theme.dart';
import 'package:uhomebk_flutter/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '企云助手',
      debugShowCheckedModeBanner: false,
      theme: themeData,      
      home: LoginPage(),
      builder: EasyLoading.init(),
    );
  }
}