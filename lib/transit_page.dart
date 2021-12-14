// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uhomebk_flutter/root_page.dart';

class TransitPage extends StatefulWidget {
  TransitPage({Key? key}) : super(key: key);

  @override
  _TransitPageState createState() => _TransitPageState();
}

class _TransitPageState extends State<TransitPage> {
  late Timer _timer;
  int _currentTime = 6;
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        _currentTime--;
      });
      if (_currentTime <= 0) {
        _jumpRootPage();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Image.asset(
          'assets/images/icons/uhome_default_screen.png',
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top + 10,
          right: 10,
          child: InkWell(child: _clipButton(), onTap: _jumpRootPage,),
        )
      ],
    ));
  }

  Widget _clipButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 50,
        height: 50,
        color: Colors.black.withOpacity(0.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('跳过', style: TextStyle(color: Colors.white, fontSize: 12)),
            Text('${_currentTime}s', style: TextStyle(color: Colors.white, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  void _jumpRootPage() {
    _timer.cancel();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => RootPage()), (route) => false);
  }
}
