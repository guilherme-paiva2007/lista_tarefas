import 'package:flutter/material.dart';

abstract final class AppCalcs {
  static final Map<({IconData icon, double fontSize}), Size> _iconSizeCache = {};

  static Size getIconSize(IconData icon, double fontSize) {
    final record = (icon: icon, fontSize: fontSize);
    final fromCache = _iconSizeCache[record];
    if (fromCache != null) return fromCache;

    final textPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontSize: fontSize,
          fontFamily: icon.fontFamily,
          package: icon.fontPackage,
        ),
      ),
      textDirection: TextDirection.ltr
    );
    
    textPainter.layout();
    _iconSizeCache[record] = textPainter.size;
    return textPainter.size;
  }

  static double getIconSizeForBiggerSide(IconData icon, double biggerSide) {
    var iconSize = getIconSize(icon, biggerSide);
    if (iconSize.height >= iconSize.width) return biggerSide;
    return (biggerSide * iconSize.height) / iconSize.width;
  }
}