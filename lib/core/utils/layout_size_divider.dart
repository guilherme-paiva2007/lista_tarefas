final class LayoutSizeDivider {
  final List<double> _areas;
  late double _sum;

  late double _size;
  late double _partSize;

  set size(double v) {
    if (_size == v) return;
    _size = v;
    _partSize = _size / _sum;
  }
  double get size => _size;

  LayoutSizeDivider(this._areas) {
    for (var area in _areas) {
      if (area < 0) throw RangeError("Area size must be non-negative");
    }
    _sum = _areas.fold<double>(0, _sumFold);
  }

  operator []=(int index, double value) {
    if (value < 0) throw RangeError("Area size must be non-negative");
    final last = _areas[index];
    _areas[index] = value;
    _sum += (value - last);
  }

  operator [](int index) => DividerPart._(index, this);
}

final class DividerPart {
  final int index;
  final LayoutSizeDivider layoutSizeDivider;

  DividerPart._(this.index, this.layoutSizeDivider);

  double get _areaSize {
    try {
      return layoutSizeDivider._areas[index];
    } catch (_) {}
    return 0;
  }

  double get size => layoutSizeDivider._partSize * _areaSize;
}

double _sumFold(double last, double current) => last + current;