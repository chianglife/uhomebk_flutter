import 'package:flutter/material.dart';
import 'package:uhomebk_flutter/config/http_options.dart';
import 'package:uhomebk_flutter/models/menu.dart';
import 'package:uhomebk_flutter/pages/store_list.dart';
import 'package:uhomebk_flutter/widgets/image_default.dart';

class SecondMenuPage extends StatefulWidget {
  final Menu menu; //页面跳转传值
  SecondMenuPage({Key? key, required this.menu}) : super(key: key);

  @override
  State<SecondMenuPage> createState() => _SecondMenuPageState();
}

class _SecondMenuPageState extends State<SecondMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.menu.resName)),//使用widget可以获取页面传值
      body: _gridViewBuilder(),
      );
  }

  Widget _gridViewBuilder() {
    //每个ListItem里面的网格
    return GridView.builder(
      shrinkWrap: true, //解决无限高度问题
      physics: const NeverScrollableScrollPhysics(), //禁用滑动事件
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(//横向
        crossAxisCount: 4,
      ),
      itemCount:widget.menu.child.length,
      itemBuilder: (BuildContext context, int index) {
        return _gridItemBuilder(
            context, index, widget.menu.child[index]);
      },
    );
  }

  Widget _gridItemBuilder(BuildContext context, int index, Menu menu) {
    //网格item布局
    return InkWell(
      onTap: () {_clickGridItem(index, menu);},
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        ImageDefault(url: HttpOptions.kPicServer + menu.icon, w: 35, h: 35),//自定义图片控件，显示缺省图
        const SizedBox(height: 10),
        Text(menu.resName, maxLines: 1, overflow: TextOverflow.ellipsis)
      ]),
    );
  }

  void _clickGridItem(int itemIndex, Menu menu) {
    print("$itemIndex");
    print(menu.url);

    if(menu.url == '/order/warehouse/activity/material_apply') {//物料申请
      Navigator.push(context, MaterialPageRoute(builder: (context) => StoreList(menu: menu)));
    }
  }
}