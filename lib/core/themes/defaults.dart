import 'package:flutter/material.dart';

final ThemeData themeDefaults = ThemeData(
  useMaterial3: true,
  fontFamily: 'Montserrat',
  textTheme: ThemeData().textTheme.apply(
    fontFamily: 'Montserrat',
  ),
  // scaffoldBackgroundColor: AppColors.white,
);