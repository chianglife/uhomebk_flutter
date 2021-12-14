
import 'package:flutter/material.dart';
import 'package:uhomebk_flutter/config/seg_colors.dart';

final ThemeData themeData = ThemeData(  
  primaryColor: Colors.yellow,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    color: SEGColors.color_t,
    titleTextStyle: TextStyle(fontSize: 18, color: Colors.white),
    shadowColor: Colors.white,
    elevation: 0
    // Image.asset('assets/images/icons/navBackNor_White.png') 
  ),
  splashColor: Colors.transparent 
);