import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quotes/core/utils/app_colors.dart';
import 'package:quotes/core/utils/app_strings.dart';

ThemeData appTheme() => ThemeData(
      primaryColor: AppColors.primary,
      hintColor: AppColors.hint,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      fontFamily: AppStrings.fontFamily,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        color: Colors.transparent,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
      ),
      textTheme: TextTheme(
        bodyLarge: const TextStyle(
          color: Colors.white,
          fontSize: 22,
          height: 1.5,
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: TextStyle(
          color: AppColors.hint,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
