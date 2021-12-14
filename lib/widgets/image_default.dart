import 'package:flutter/material.dart';

class ImageDefault extends StatefulWidget {
  ImageDefault({Key? key, required this.url, required this.w, required this.h, this.defImagePath="assets/images/icons/default_image.png"}) : super(key: key);

  final String url;
  final double w;
  final double h;
  final String defImagePath;

  @override
  _ImageDefaultState createState() => _ImageDefaultState();
}

class _ImageDefaultState extends State<ImageDefault> {
  late Image _image;

  @override
  void initState() {
    super.initState();
    _image = Image.network(widget.url, width: widget.w, height: widget.h);
    var stream = _image.image.resolve(ImageConfiguration.empty);
    stream.addListener(ImageStreamListener((_, __){
      //加载成功
    }, onError: (dynamic exception, StackTrace? stackTrace){
      //加载失败
      setState(() {
        _image = Image.asset(
          widget.defImagePath,
          width: widget.w,
          height: widget.h,
        );
      });
    }));
  }

  @override
  Widget build(BuildContext context) {
    return _image;
  }
}