import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lista_tarefas/core/constants/colors.dart';
import 'package:lista_tarefas/core/themes/dark.dart';
import 'package:lista_tarefas/core/themes/light.dart';

extension ReverseBrightness on Brightness {
  Brightness get reverse => switch (this) {
    Brightness.light => Brightness.dark,
    Brightness.dark => Brightness.light,
  };
}

abstract final class AppTheme {
  static final ThemeData light = lightTheme;
  static final ThemeData dark = darkTheme;

  static ThemeMode _current = ThemeMode.system;

  static ValueNotifier<ThemeMode> notifier = ValueNotifier<ThemeMode>(_current);

  static set mode(ThemeMode v) {
    _current = v;
    notifier.value = v;
  }
  static ThemeMode get mode => _current;

  static ThemeData get theme => switch (_current) {
    ThemeMode.light => lightTheme,
    ThemeMode.dark => darkTheme,
    ThemeMode.system => PlatformDispatcher.instance.platformBrightness == Brightness.light
      ? lightTheme : darkTheme,
  };

  static Brightness get brightness => switch (_current) {
    ThemeMode.light => Brightness.light,
    ThemeMode.dark => Brightness.dark,
    ThemeMode.system => PlatformDispatcher.instance.platformBrightness,
  };
}

abstract final class AppThemeColors {
  static Color get main => AppTheme.brightness == Brightness.light ? AppColors.white : AppColors.black ;
  static Color get extraLight => AppTheme.brightness == Brightness.light ? AppColors.extraLightGrey : AppColors.extraDarkGrey ;
  static Color get light => AppTheme.brightness == Brightness.light ? AppColors.lightGrey : AppColors.darkGrey ;
  static Color get medium => AppColors.grey;
  static Color get dark => AppTheme.brightness == Brightness.light ? AppColors.darkGrey : AppColors.lightGrey ;
  static Color get extraDark => AppTheme.brightness == Brightness.light ? AppColors.extraDarkGrey : AppColors.extraLightGrey ;
  static Color get reverse => AppTheme.brightness == Brightness.light ? AppColors.black : AppColors.white ;
}

mixin ThemeListener<T extends StatefulWidget> on State<T> {
  late VoidCallback _themeListener;

  @override
  void initState() {
    super.initState();
    _themeListener = () {
      if (mounted) setState(() {});
    };
    AppTheme.notifier.addListener(_themeListener);
  }

  @override
  void dispose() {
    super.dispose();
    AppTheme.notifier.removeListener(_themeListener);
  }
}