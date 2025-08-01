import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lista_tarefas/core/constants/colors.dart';
import 'package:lista_tarefas/core/constants/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:lista_tarefas/core/themes/dark.dart';
// import 'package:lista_tarefas/core/themes/light.dart';

extension ReverseBrightness on Brightness {
  Brightness get reverse => switch (this) {
    Brightness.light => Brightness.dark,
    Brightness.dark => Brightness.light,
  };

  ThemeMode get asThemeMode => switch (this) {
    Brightness.light => ThemeMode.light,
    Brightness.dark => ThemeMode.dark,
  };
}

abstract final class AppTheme {
  static final Map<String, ThemeMode> _asMap = Map.fromEntries(ThemeMode.values.map((b) {
    return MapEntry(b.name, b);
  }));
  static ThemeMode? fromString(String string) => _asMap[string];

  static final ThemeData light = _generateTheme(Brightness.light);
  static final ThemeData dark = _generateTheme(Brightness.dark);

  static ThemeMode _current = ThemeMode.system;

  static ValueNotifier<ThemeMode> notifier = ValueNotifier<ThemeMode>(_current);

  static set mode(ThemeMode v) {
    _current = v;
    notifier.value = v;
  }
  static ThemeMode get mode => _current;

  static Future<void> saveMode([ThemeMode? mode]) async {
    if (mode != null) AppTheme.mode = mode;
    (await SharedPreferences.getInstance()).setString(AppPreferences.localTheme, AppTheme.mode.name);
  }

  static ThemeData get theme => switch (_current) {
    ThemeMode.light => light,
    ThemeMode.dark => dark,
    ThemeMode.system => PlatformDispatcher.instance.platformBrightness == Brightness.light
      ? light : dark,
  };

  static Brightness get brightness => switch (_current) {
    ThemeMode.light => Brightness.light,
    ThemeMode.dark => Brightness.dark,
    ThemeMode.system => PlatformDispatcher.instance.platformBrightness,
  };
}

abstract final class AppThemeColors {
  static Color get main => AppTheme.brightness == Brightness.light ? AppColors.white : AppColors.black;
  static Color get extraLight => AppTheme.brightness == Brightness.light ? AppColors.extraLightGrey : AppColors.extraDarkGrey;
  static Color get light => AppTheme.brightness == Brightness.light ? AppColors.lightGrey : AppColors.darkGrey;
  static Color get medium => AppColors.grey;
  static Color get dark => AppTheme.brightness == Brightness.light ? AppColors.darkGrey : AppColors.lightGrey;
  static Color get extraDark => AppTheme.brightness == Brightness.light ? AppColors.extraDarkGrey : AppColors.extraLightGrey;
  static Color get reverse => AppTheme.brightness == Brightness.light ? AppColors.black : AppColors.white;

  
  static Color _main(Brightness? brightness) {
    brightness ??= AppTheme.brightness;
    return brightness == Brightness.light ? AppColors.white : AppColors.black;
  }
  // ignore: unused_element
  static Color _extraLight(Brightness? brightness) {
    brightness ??= AppTheme.brightness;
    return brightness == Brightness.light ? AppColors.extraLightGrey : AppColors.extraDarkGrey;
  }

  static Color _light(Brightness? brightness) {
    brightness ??= AppTheme.brightness;
    return brightness == Brightness.light ? AppColors.lightGrey : AppColors.darkGrey;
  }

  // ignore: unused_element
  static Color _medium(Brightness? brightness) => AppColors.grey;

  // ignore: unused_element
  static Color _dark(Brightness? brightness) {
    brightness ??= AppTheme.brightness;
    return brightness == Brightness.light ? AppColors.darkGrey : AppColors.lightGrey;
  }

  // ignore: unused_element
  static Color _extraDark(Brightness? brightness) {
    brightness ??= AppTheme.brightness;
    return brightness == Brightness.light ? AppColors.extraDarkGrey : AppColors.extraLightGrey;
  }

  static Color _reverse(Brightness? brightness) {
    brightness ??= AppTheme.brightness;
    return brightness == Brightness.light ? AppColors.black : AppColors.white;
  }
}

ThemeData _generateTheme(Brightness brightness) {
  return ThemeData(
    fontFamily: 'Montserrat',
    brightness: brightness,

    colorScheme: ColorScheme(
      brightness: brightness,
      primary: AppColors.blue,
      onPrimary: AppColors.white,
      secondary: AppColors.purple,
      onSecondary: AppColors.white,
      error: AppColors.red,
      onError: AppColors.white,
      surface: AppThemeColors._main(brightness),
      onSurface: AppThemeColors._reverse(brightness),
      outline: AppThemeColors._light(brightness),
      surfaceContainer: AppColors.grey,
    ),

    scaffoldBackgroundColor: AppThemeColors._main(brightness),

    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppThemeColors._reverse(brightness), fontFamily: "Montserrat"),
      bodyMedium: TextStyle(color: AppThemeColors._reverse(brightness), fontFamily: "Montserrat"),
      bodySmall: TextStyle(color: AppThemeColors._reverse(brightness), fontFamily: "Montserrat"),
      labelLarge: TextStyle(color: AppThemeColors._reverse(brightness), fontFamily: "Montserrat"),
      labelMedium: TextStyle(color: AppThemeColors._reverse(brightness), fontFamily: "Montserrat"),
      labelSmall: TextStyle(color: AppThemeColors._reverse(brightness), fontFamily: "Montserrat"),
      displayLarge: TextStyle(color: AppThemeColors._reverse(brightness), fontFamily: "Montserrat"),
      displayMedium: TextStyle(color: AppThemeColors._reverse(brightness), fontFamily: "Montserrat"),
      displaySmall: TextStyle(color: AppThemeColors._reverse(brightness), fontFamily: "Montserrat"),
      headlineLarge: TextStyle(color: AppThemeColors._reverse(brightness), fontFamily: "Montserrat"),
      headlineMedium: TextStyle(color: AppThemeColors._reverse(brightness), fontFamily: "Montserrat"),
      headlineSmall: TextStyle(color: AppThemeColors._reverse(brightness), fontFamily: "Montserrat"),
      titleLarge: TextStyle(color: AppThemeColors._reverse(brightness), fontFamily: "Montserrat"),
      titleMedium: TextStyle(color: AppThemeColors._reverse(brightness), fontFamily: "Montserrat"),
      titleSmall: TextStyle(color: AppThemeColors._reverse(brightness), fontFamily: "Montserrat"),
    ),

    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: AppThemeColors._reverse(brightness)),
      floatingLabelStyle: TextStyle(color: AppThemeColors._reverse(brightness)),
      hintStyle: TextStyle(color: AppColors.grey),
      helperStyle: TextStyle(color: AppColors.grey),
      errorStyle: TextStyle(color: AppColors.red),
    ),

    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppThemeColors._reverse(brightness),
      selectionColor: AppColors.blue,
    ),

    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: brightness.reverse,
        systemNavigationBarColor: AppThemeColors._main(brightness),
        systemNavigationBarIconBrightness: brightness.reverse
      )
    ),
  );
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