import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:uhomebk_flutter/config/http_options.dart';
import 'package:uhomebk_flutter/config/http_urls.dart';
import 'package:uhomebk_flutter/config/seg_colors.dart';
import 'package:uhomebk_flutter/http/http_utils.dart';
import 'package:uhomebk_flutter/models/menu.dart';
import 'package:uhomebk_flutter/pages/first_page.dart';

class RootPage extends StatefulWidget {
  RootPage({Key? key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _currentIndex = 0;
  List<Widget> _pageList = [Container()];
  final List<String> _titles = [""];
  List<BottomNavigationBarItem> _barItems = [
    BottomNavigationBarItem(icon: Container(), label: ""),
    BottomNavigationBarItem(icon: Container(), label: "")
  ]; //默认两个占位，label不能为null

  void _onTabClick(int index) {
    setState(() {
      _currentIndex = index;      
    });
  }

  @override
  void initState() {
    requesMenu();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(//标题需要在这里设置，不能在tabbar页面设置，否则点击切换无效
        title: Text(_titles[_currentIndex]),//如果resName没有初始值，经过测试这里需要用内嵌表达式才会不报错"${}"
      ),
      body: _pageList[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: SEGColors.color_t,
        unselectedItemColor: SEGColors.color_1,
        selectedLabelStyle:
            const TextStyle(fontSize: 11, color: SEGColors.color_t),//选中颜色通过selectedItemColor来设置，这里无效
        unselectedLabelStyle:
            const TextStyle(fontSize: 11, color: SEGColors.color_1),
        iconSize: 22,
        // elevation: 0, //这里如果设置数值，顶部会有阴影线条
        backgroundColor: Colors.white,
        items: _barItems, //必须要大于等于两个items
        currentIndex: _currentIndex,
        onTap: _onTabClick,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

// activeIcon: FadeInImage.memoryNetwork(placeholder: Image.asset("assets/images/icons/default_image.png") as Uint8List,
//         image: "image",),
  List<BottomNavigationBarItem> _bottomNavigationBarItems(
      List<String> titles, List<String> icons, List<String> icons2) {
    List<BottomNavigationBarItem> items = [];
    for (var i = 0; i < titles.length; i++) {
      BottomNavigationBarItem item = BottomNavigationBarItem(
        icon: SizedBox(
            width: 21,
            height: 21,
            child: Image.network(HttpOptions.kPicServer + icons[i])),
        activeIcon: SizedBox(
            width: 21,
            height: 21,
            child: Image.network(HttpOptions.kPicServer + icons2[i])),
        label: titles[i],        
      );
      items.add(item);
    }
    return items;
  }

  List<Widget> _pageListGenerate(List<String> titles, Menu menu) {
    List<Widget> pages = [];
    for (var i = 0; i < titles.length; i++) {
      pages.add(FirstPage(menu: menu));
    }
    return pages;
  }

  //请求app菜单
  void requesMenu() async {
    Response response =
        await HttpUtils.postJson(kServer_menu, params: {"resAppShowType": "8"});
    if (response.statusCode == 0) {
      Map<String, dynamic> result = Map.from(response.data);
      Menu menu = Menu.fromMap(result['data']['child'][0]);

      List<String> titles = [];
      List<String> icons = [];
      List<String> icons2 = [];
      Menu appMenu = Menu("");

      for (Menu child in menu.child) {
        titles.add(child.resName);
        icons.add(child.icon);
        icons2.add(child.icon2);
        if (child.resCode == 'YINGYONG') {
          //获取应用九宫格数据
          appMenu = child;
        }
      }
      print(titles);
      setState(() {
        _titles.remove("");
        _titles.addAll(titles);
        _barItems = _bottomNavigationBarItems(titles, icons, icons2);
        _pageList = _pageListGenerate(titles, appMenu);
      });
    }
  }
}
