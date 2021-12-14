import 'package:flutter/material.dart';
import 'package:uhomebk_flutter/config/http_options.dart';
import 'package:uhomebk_flutter/config/seg_colors.dart';
import 'package:uhomebk_flutter/models/menu.dart';
import 'package:uhomebk_flutter/widgets/image_default.dart';

class FirstPage extends StatefulWidget {
  final Menu menu; //页面跳转传值
  FirstPage({Key? key, required this.menu})
      : super(key: key);
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _listViewBuilder());
  }

  Widget _gridViewBuilder(int listIndex) {
    //每个ListItem里面的网格
    return GridView.builder(
      shrinkWrap: true, //解决无限高度问题
      physics: const NeverScrollableScrollPhysics(), //禁用滑动事件
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
      itemCount:widget.menu.child[listIndex].child.length,
      itemBuilder: (BuildContext context, int index) {
        return _gridItemBuilder(
            context, index, widget.menu.child[listIndex].child[index]);
      },
    );
  }

  Widget _gridItemBuilder(BuildContext context, int index, Menu menu) {
    //网格item布局
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      // SizedBox(
      //     width: 35,
      //     height: 35,
      //     child:  Image.network(HttpOptions.kPicServer + menu.icon)),
      ImageDefault(url: HttpOptions.kPicServer + menu.icon, w: 35, h: 35),//自定义图片控件，显示缺省图
      const SizedBox(height: 10),
      Text(menu.resName, maxLines: 1, overflow: TextOverflow.ellipsis)
    ]);
  }

  Widget _listViewBuilder() {
    return ListView.builder(
      itemCount: widget.menu.child.length,
      itemBuilder: (BuildContext context, int index) {
        return _listItemBuilder(context, index);
      },
    );
  }

  Widget _listItemBuilder(BuildContext context, int index) {
    //列表行布局
    return Column(crossAxisAlignment: CrossAxisAlignment.start, //从上往下布局
        children: [
          Container(
            padding:
                const EdgeInsets.fromLTRB(10, 15, 0, 15), //创建container来设置间距
            child: Row(children: [
              Container(
                  height: 15, width: 3, color: SEGColors.color_t), //头部蓝色分隔方块
              const SizedBox(width: 15), //间距
              Text(
                (widget.menu.child[index]).resName,
                style: const TextStyle(fontSize: 15, color: SEGColors.color_1),
              )
            ]), //section 标题
          ),
          _gridViewBuilder(index) //嵌套GridView
        ]);
  }
}
