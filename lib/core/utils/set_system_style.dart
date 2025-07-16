import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lista_tarefas/core/theme.dart';

void setSystemStyle([ bool hasBottomBar = false ]) {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: AppTheme.brightness.reverse,
      systemNavigationBarColor: hasBottomBar ? AppThemeColors.extraLight : AppThemeColors.main,
      systemNavigationBarIconBrightness: AppTheme.brightness.reverse
    )
  );
}