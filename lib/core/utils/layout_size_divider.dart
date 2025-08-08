import 'package:flutter/widgets.dart';

final class LayoutSizeDivider {
  late final ValueNotifier<double> sumNotifier;

  final List<double> _areas;
  late double _sum;

  double? _lastSize;
  late double _size;
  late double _partSize;

  set size(double v) {
    if (_lastSize == v) return;
    _size = v;
    _partSize = _size / _sum;
    _lastSize = _size;
  }
  double get size => _size;

  LayoutSizeDivider(this._areas) {
    for (var area in _areas) {
      if (area < 0) throw RangeError("Area size must be non-negative");
    }
    _sum = _areas.fold<double>(0, _sumFold);
    sumNotifier = ValueNotifier(_sum);
  }

  operator []=(int index, double value) {
    if (value < 0) throw RangeError("Area size must be non-negative");
    final last = _areas[index];
    _areas[index] = value;
    _sum += (value - last);
    _partSize = _size / _sum;
    sumNotifier.value = _sum;
  }

  operator [](int index) => DividerPart._(index, this);

  double getPartArea(int index) => _areas[index];
}

final class DividerPart {
  final int index;
  final LayoutSizeDivider layoutSizeDivider;

  const DividerPart._(this.index, this.layoutSizeDivider);

  double get _areaSize {
    try {
      return layoutSizeDivider._areas[index];
    } catch (_) {}
    return 0;
  }

  double get size => layoutSizeDivider._partSize * _areaSize;
}

double _sumFold(double last, double current) => last + current;