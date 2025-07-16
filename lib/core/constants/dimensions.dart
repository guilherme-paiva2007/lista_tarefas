import 'package:flutter/material.dart';

abstract final class AppDimensions {
  static const BorderRadius borderRadiusSmall = BorderRadius.all(Radius.circular(8));
  static const BorderRadius borderRadiusMedium = BorderRadius.all(Radius.circular(12));
  static const BorderRadius borderRadiusBig = BorderRadius.all(Radius.circular(16));
  static const BorderRadius borderRadiusLarge = BorderRadius.all(Radius.circular(24));
  static const BorderRadius borderRadiusCircular = BorderRadius.all(Radius.circular(4000));
}

abstract final class AppBorderRadius {
  /// ```
  /// BorderRadius.circular(8)
  /// ```
  static const BorderRadius small = AppDimensions.borderRadiusSmall;
  /// ```
  /// BorderRadius.circular(12)
  /// ```
  static const BorderRadius medium = AppDimensions.borderRadiusMedium;
  /// ```
  /// BorderRadius.circular(16)
  /// ```
  static const BorderRadius big = AppDimensions.borderRadiusBig;
  /// ```
  /// BorderRadius.circular(24)
  /// ```
  static const BorderRadius large = AppDimensions.borderRadiusLarge;
  /// ```
  /// BorderRadius.circular(4000)
  /// ```
  static const BorderRadius circular = AppDimensions.borderRadiusCircular;
}