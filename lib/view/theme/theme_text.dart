import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live_tv/view/theme/theme_color.dart';

class ThemeText {
  static TextStyle display4 = TextStyle(
      fontFamily: 'Nunito', fontSize: 38.sp, fontWeight: FontWeight.bold);
  static TextStyle display3 = TextStyle(
      fontFamily: 'Nunito', fontSize: 32.sp, fontWeight: FontWeight.normal);
  static TextStyle display2 = TextStyle(
      fontFamily: 'Nunito', fontSize: 26.sp, fontWeight: FontWeight.normal);
  static TextStyle display1 = TextStyle(
      fontFamily: 'Nunito', fontSize: 22.sp, fontWeight: FontWeight.normal);
  static TextStyle headline = TextStyle(
      fontFamily: 'Nunito', fontSize: 20.0.sp, fontWeight: FontWeight.normal);
  static TextStyle title = TextStyle(
      fontFamily: 'Nunito', fontSize: 19.sp, fontWeight: FontWeight.normal);
  static TextStyle body1 = TextStyle(
      fontFamily: 'Nunito', fontSize: 18.sp, fontWeight: FontWeight.normal);
  static TextStyle body2 = TextStyle(
      fontFamily: 'Nunito', fontSize: 18.sp, fontWeight: FontWeight.w600);
  static TextStyle subhead = TextStyle(
      fontFamily: 'Nunito', fontSize: 17.sp, fontWeight: FontWeight.normal);
  static TextStyle caption = TextStyle(
      fontFamily: 'Nunito', fontSize: 15.sp, fontWeight: FontWeight.normal);
  static TextStyle overline = TextStyle(
      fontFamily: 'Nunito',
      fontSize: 14.sp,
      fontWeight: FontWeight.normal,
      letterSpacing: 0.4);
  static TextStyle button = TextStyle(
      fontFamily: 'Nunito',
      fontSize: 18.sp,
      color: AppColor.secondColor,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal);
}
