import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lista_tarefas/core/constants/colors.dart';
import 'package:lista_tarefas/core/themes/defaults.dart';

final ThemeData lightTheme = themeDefaults.copyWith(
  brightness: Brightness.light,

  colorScheme: ColorScheme.light(
    primary: AppColors.blue,
    onPrimary: AppColors.white,
    secondary: AppColors.purple,
    onSecondary: AppColors.white,
    error: AppColors.red,
    onError: AppColors.white,
    surface: AppColors.white,
    onSurface: AppColors.black,
    outline: AppColors.lightGrey,
    surfaceContainer: AppColors.grey,
  ),

  scaffoldBackgroundColor: AppColors.white,

  textTheme: TextTheme(
    bodyLarge: const TextStyle(color: AppColors.black, fontFamily: "Montserrat"),
    bodyMedium: const TextStyle(color: AppColors.black, fontFamily: "Montserrat"),
    bodySmall: const TextStyle(color: AppColors.black, fontFamily: "Montserrat"),
    labelLarge: const TextStyle(color: AppColors.black, fontFamily: "Montserrat"),
    labelMedium: const TextStyle(color: AppColors.black, fontFamily: "Montserrat"),
    labelSmall: const TextStyle(color: AppColors.black, fontFamily: "Montserrat"),
    displayLarge: const TextStyle(color: AppColors.black, fontFamily: "Montserrat"),
    displayMedium: const TextStyle(color: AppColors.black, fontFamily: "Montserrat"),
    displaySmall: const TextStyle(color: AppColors.black, fontFamily: "Montserrat"),
    headlineLarge: const TextStyle(color: AppColors.black, fontFamily: "Montserrat"),
    headlineMedium: const TextStyle(color: AppColors.black, fontFamily: "Montserrat"),
    headlineSmall: const TextStyle(color: AppColors.black, fontFamily: "Montserrat"),
    titleLarge: const TextStyle(color: AppColors.black, fontFamily: "Montserrat"),
    titleMedium: const TextStyle(color: AppColors.black, fontFamily: "Montserrat"),
    titleSmall: const TextStyle(color: AppColors.black, fontFamily: "Montserrat"),
  ),

  inputDecorationTheme: InputDecorationTheme(
    labelStyle: const TextStyle(color: AppColors.black),
    floatingLabelStyle: const TextStyle(color: AppColors.black),
    hintStyle: const TextStyle(color: AppColors.grey),
    helperStyle: const TextStyle(color: AppColors.grey),
    errorStyle: TextStyle(color: AppColors.red),
  ),

  textSelectionTheme: TextSelectionThemeData(
    cursorColor: AppColors.black,
    selectionColor: AppColors.blue,
  ),

  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: AppColors.white,
      systemNavigationBarIconBrightness: Brightness.dark
    )
  ),
);