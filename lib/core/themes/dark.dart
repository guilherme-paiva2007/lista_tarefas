import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lista_tarefas/core/constants/colors.dart';
import 'package:lista_tarefas/core/themes/defaults.dart';

final ThemeData darkTheme = themeDefaults.copyWith(
  brightness: Brightness.dark,

  colorScheme: ColorScheme.dark(
    primary: AppColors.blue,
    onPrimary: AppColors.black,
    secondary: AppColors.purple,
    onSecondary: AppColors.black,
    error: AppColors.red,
    onError: AppColors.black,
    surface: AppColors.black,
    onSurface: AppColors.white,
    outline: AppColors.extraDarkGrey,
    surfaceContainer: AppColors.darkGrey,
  ),

  scaffoldBackgroundColor: AppColors.black,
  
  textTheme: TextTheme(
    bodyLarge: const TextStyle(color: AppColors.white, fontFamily: "Montserrat"),
    bodyMedium: const TextStyle(color: AppColors.white, fontFamily: "Montserrat"),
    bodySmall: const TextStyle(color: AppColors.white, fontFamily: "Montserrat"),
    labelLarge: const TextStyle(color: AppColors.white, fontFamily: "Montserrat"),
    labelMedium: const TextStyle(color: AppColors.white, fontFamily: "Montserrat"),
    labelSmall: const TextStyle(color: AppColors.white, fontFamily: "Montserrat"),
    displayLarge: const TextStyle(color: AppColors.white, fontFamily: "Montserrat"),
    displayMedium: const TextStyle(color: AppColors.white, fontFamily: "Montserrat"),
    displaySmall: const TextStyle(color: AppColors.white, fontFamily: "Montserrat"),
    headlineLarge: const TextStyle(color: AppColors.white, fontFamily: "Montserrat"),
    headlineMedium: const TextStyle(color: AppColors.white, fontFamily: "Montserrat"),
    headlineSmall: const TextStyle(color: AppColors.white, fontFamily: "Montserrat"),
    titleLarge: const TextStyle(color: AppColors.white, fontFamily: "Montserrat"),
    titleMedium: const TextStyle(color: AppColors.white, fontFamily: "Montserrat"),
    titleSmall: const TextStyle(color: AppColors.white, fontFamily: "Montserrat"),
  ),

  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(color: AppColors.white),
    floatingLabelStyle: TextStyle(color: AppColors.white),
    hintStyle: TextStyle(color: AppColors.grey),
    helperStyle: TextStyle(color: AppColors.grey),
    errorStyle: TextStyle(color: AppColors.red),
  ),

  textSelectionTheme: TextSelectionThemeData(
    cursorColor: AppColors.white,
    selectionColor: AppColors.blue,
  ),

  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.black,
      systemNavigationBarIconBrightness: Brightness.light
    )
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.black,
    selectedItemColor: AppColors.blue,
    selectedIconTheme: IconThemeData(color: AppColors.blue),
    unselectedItemColor: AppColors.white,
    unselectedIconTheme: IconThemeData(color: AppColors.white),
  ),
);