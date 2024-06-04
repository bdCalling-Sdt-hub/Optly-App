import 'package:flutter/material.dart';

class AppColors {
  static Color primaryColor = const Color(0xFF70c2d1);
  static Color backgroundColor = const Color(0xFFEEEEEE);
  static Color greyColor = const Color(0xFF767676);
  static Color fieldColor = const Color(0xFFe8f0fe);
  static const Color white = Color(0xffFFFFFF);
  static Color iconColor = const Color(0xFF757575);
  static Color textColor = const Color(0xFFFFFFFF);
  static Color subTextColor = const Color(0xFFE8E8E8);
  static Color hintColor = const Color(0xFF757575);
  static Color fillColor = const Color(0xFFe8f0fe).withOpacity(0.3);
  static Color dividerColor = const Color(0xFFC6C6C8);
  static Color shadowColor = const Color(0xFF2B2A2A);
  static Color bottomBarColor = const Color(0xFF6c7d80);

  static BoxShadow shadow = BoxShadow(
    blurRadius: 4,
    spreadRadius: 0,
    color: shadowColor,
    offset: const Offset(0, 2),
  );
}
