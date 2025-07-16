import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lista_tarefas/core/theme.dart';

void setSystemStyle() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: AppTheme.brightness.reverse,
      systemNavigationBarColor: AppTheme.theme.colorScheme.surface,
      systemNavigationBarIconBrightness: AppTheme.brightness.reverse
    )
  );
}