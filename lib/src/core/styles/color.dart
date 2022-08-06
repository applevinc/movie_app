import 'package:flutter/cupertino.dart';

class AppColors {
  AppColors._();

  static const primary = Color(0xff070818);
  static const blue = Color(0xff007CFF);
  static const textGray = Color(0xffCDCED1);
  static const yellow = Color(0xffFFB825);
   static const darkGrey = Color(0xff525464);
  static const darkText = Color(0xff151522);
  static const black = Color(0xff010211);
  static const red = Color(0xffAD2401);
  static final shadowColor = const Color(0xff323247).withOpacity(.08);
  static final boxShadow = [
    BoxShadow(
      color: shadowColor,
      offset: const Offset(0, 24),
      blurRadius: 32,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: shadowColor,
      offset: const Offset(0, 16),
      blurRadius: 16,
      spreadRadius: 0,
    ),
  ];
}
