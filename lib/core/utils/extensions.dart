import 'package:flutter/material.dart';

extension OrientationExtension on Orientation {
  Axis get asAxis => this == Orientation.portrait ? Axis.vertical : Axis.horizontal;
}

extension AxisExtension on Axis {
  Axis get reverse => this == Axis.horizontal ? Axis.vertical : Axis.horizontal;
}

extension BoxConstraintsExtension on BoxConstraints {
  double maxOfAxis(Axis axis) => axis == Axis.horizontal ? maxWidth : maxHeight;
  double minOfAxis(Axis axis) => axis == Axis.horizontal ? minWidth : minHeight;
}

extension NumListExtension<N extends num> on List<N> {
  N sum() {
    return fold(0 as N, (previousValue, element) => (previousValue + element) as N);
  }
}