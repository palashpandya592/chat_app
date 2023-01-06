import 'package:chatting_app/utilities/app_colors.dart';
import 'package:flutter/material.dart';

final appTheme = ThemeData(
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.white,
  appBarTheme: AppBarTheme(backgroundColor: AppColors.primary),
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppColors.teal),
);
