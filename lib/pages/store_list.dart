import 'package:flutter/material.dart';
import 'package:uhomebk_flutter/models/menu.dart';

class StoreList extends StatefulWidget {
  final Menu menu; //页面跳转传值
  StoreList({Key? key, required this.menu}) : super(key: key);

  @override
  State<StoreList> createState() => _StoreListState();
}

class _StoreListState extends State<StoreList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.menu.resName)),
      body: Container(),);
  }
}