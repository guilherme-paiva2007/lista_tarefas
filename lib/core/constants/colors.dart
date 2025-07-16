import 'package:flutter/material.dart';
import 'package:color_palette_plus/color_palette_plus.dart';

abstract final class AppColors {
  static final MaterialColor purple = ColorPalette.generateSwatch(const Color(0xFF9527F5));
  static final MaterialColor indigo = ColorPalette.generateSwatch(const Color(0xFF5227F5));
  static final MaterialColor darkBlue = ColorPalette.generateSwatch(const Color(0xFF273FF5));
  static final MaterialColor blue = ColorPalette.generateSwatch(const Color(0xFF2780F5));
  static final MaterialColor aqua = ColorPalette.generateSwatch(const Color(0xFF27C1F5));

  static const Color lightGrey = Color(0xFFEEEEEE);
  static const Color grey = Color(0xFFC4C4C4);
  static const Color darkGrey = Color(0xFF6E6E6E);
  static const Color extraDarkGrey = Color(0xFF4A4A4A);

  static const Color black = Color(0xFF353535);
  static const Color white = Color(0xFFffffff);

  static final MaterialColor green = ColorPalette.generateSwatch(const Color(0xFF69f100));
  static final MaterialColor lime = ColorPalette.generateSwatch(const Color(0xFFc8f527));
  static final MaterialColor gold = ColorPalette.generateSwatch(const Color(0xFFf5dd27));
  static final MaterialColor orange = ColorPalette.generateSwatch(const Color(0xFFf59c27));
  static final MaterialColor red = ColorPalette.generateSwatch(const Color(0xFFf55b27));
}