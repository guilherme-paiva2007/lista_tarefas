import 'package:flutter/material.dart';
import 'package:color_palette_plus/color_palette_plus.dart';

abstract final class AppPrimaryColors {
  static final MaterialColor purple = ColorPalette.generateSwatch(const Color(0xFF9527F5));
  static final MaterialColor indigo = ColorPalette.generateSwatch(const Color(0xFF5227F5));
  static final MaterialColor darkBlue = ColorPalette.generateSwatch(const Color(0xFF273FF5));
  static final MaterialColor blue = ColorPalette.generateSwatch(const Color(0xFF2780F5));
  static final MaterialColor aqua = ColorPalette.generateSwatch(const Color(0xFF27C1F5));

  static final Color lightGrey = const Color(0xFFEEEEEE);
  static final Color grey = const Color(0xFFC4C4C4);
  static final Color darkGrey = const Color(0xFF6E6E6E);
  static final Color extraDarkGrey = const Color(0xFF353535);

  static final Color black = const Color(0xFF05091F);
  static final Color white = const Color(0xFFffffff);
}

abstract final class AppSecondaryColors {
  static final MaterialColor green = ColorPalette.generateSwatch(const Color(0xFF69f100));
  static final MaterialColor lime = ColorPalette.generateSwatch(const Color(0xFFc8f527));
  static final MaterialColor gold = ColorPalette.generateSwatch(const Color(0xFFf5dd27));
  static final MaterialColor orange = ColorPalette.generateSwatch(const Color(0xFFf59c27));
  static final MaterialColor red = ColorPalette.generateSwatch(const Color(0xFFf55b27));
}