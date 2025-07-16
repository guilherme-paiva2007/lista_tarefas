import 'dart:ui';

import 'package:flutter/material.dart';
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