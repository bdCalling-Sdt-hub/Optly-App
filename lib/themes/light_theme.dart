import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

ThemeData light({Color color = const Color(0xFF70c2d1)}) => ThemeData(
      fontFamily: 'Roboto',
      iconTheme: IconThemeData(color: AppColors.primaryColor),
      primaryColor: color,
      secondaryHeaderColor: Color(0xFF7c7c7c),
      disabledColor: Color(0xFFBABFC4),
      brightness: Brightness.light,
      hintColor: Color(0xFF9F9F9F),
      cardColor: Colors.white,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.backgroundColor,
        elevation: 5,
      ),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: color)),
      colorScheme: ColorScheme.light(primary: color, secondary: color)
          .copyWith(background: const Color(0xFF7c7c7c))
          .copyWith(error: Color(0xFFE84D4F)),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        iconTheme: const IconThemeData(
            color: Colors.black), // Set app bar icons color to black
      ),
    );
