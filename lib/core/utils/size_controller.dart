import 'dart:collection';

import 'package:flutter/material.dart';

final class SizeController {
  final Set<SizeControllerBuilderState> _builders = {};

  double _sum = 0;

  final List<SizeControllerPart> _parts = [];
  late final UnmodifiableListView parts;

  SizeController() {
    parts = UnmodifiableListView(_parts);
  }

  void add(SizeControllerPart part) {
    _parts.add(part);
    _sum += part._area;
    _notifyUpdate();
  }

  void remove(SizeControllerPart part) {
    if (_parts.remove(part)) {
      _sum -= part._area;
    }
    _notifyUpdate();
  }

  _notifyUpdate() {
    for (final builder in _builders) {
      builder._reload();
    }
  }

  double _getPartSize(double fullSize) {
    if (_sum == 0) return 0;
    return fullSize / _sum;
  }
}

final class SizeControllerPart {
  final Set<SizeController> _controllers = {};

  double _area;
  double get area => _area;
  set area(double v) {
    if (v <= 0) throw RangeError("Area must be positive");
    _area = v;
    for (final controller in _controllers) {
      controller._notifyUpdate();
    }
  }

  SizeControllerPart(this._area) {
    if (_area <= 0) throw RangeError("Area must be positive");
  }
}


class SizeControllerBuilder extends StatefulWidget {
  final List<SizeControllerBox> children;
  final Axis axis;
  final SizeController controller;

  const SizeControllerBuilder({
    required this.children,
    required this.axis,
    required this.controller,
    super.key
  });

  @override
  State<SizeControllerBuilder> createState() => SizeControllerBuilderState();

  static SizeControllerBuilderState of(BuildContext context) {
    final state = context.findAncestorStateOfType<SizeControllerBuilderState>();
    if (state == null) {
      throw StateError("No SizeControllerBuilder found in context");
    }
    return state;
  }
}

class SizeControllerBuilderState extends State<SizeControllerBuilder> {
  late BoxConstraints _constraints;
  BoxConstraints get constraints => _constraints;
  late double _partSize;

  @override
  void initState() {
    super.initState();
    widget.controller._builders.add(this);
  }

  @override
  void didUpdateWidget(covariant SizeControllerBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller) {
      oldWidget.controller._builders.remove(this);
      widget.controller._builders.add(this);
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller._builders.remove(this);
  }

  void _reload() {
    if (mounted) {
      setState(() {
        
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _constraints = constraints;
        _partSize = widget.controller._getPartSize(constraints.maxHeight);
        return Flex(
          direction: widget.axis,
          children: widget.children,
        );
      }
    );
  }
}

sealed class SizeControllerBox extends StatelessWidget {
  final SizeControllerPart part;

  const SizeControllerBox(this.part, {
    super.key
  });

  SizeControllerBuilderState getParent(BuildContext context) => SizeControllerBuilder.of(context);
}

class SizeControllerSimpleBox extends SizeControllerBox {
  final Widget? child;

  const SizeControllerSimpleBox(super.part, {
    super.key,
    this.child
  });

  @override
  Widget build(BuildContext context) {
    final parent = getParent(context);
    return SizedBox(
      height: parent.widget.axis == Axis.vertical
        ? parent._partSize * part.area
        : parent.constraints.maxHeight,
      width: parent.widget.axis == Axis.horizontal
        ? parent._partSize * part.area
        : parent.constraints.maxWidth,
      child: child,
    );
  }
}

class SizeControllerBuilderBox extends SizeControllerBox {
  final Widget Function(BuildContext context, BoxConstraints constraints) builder;

  const SizeControllerBuilderBox(super.part, {
    required this.builder,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    final parent = getParent(context);
    return SizedBox(
      height: parent.widget.axis == Axis.vertical
        ? parent._partSize * part.area
        : parent.constraints.maxHeight,
      width: parent.widget.axis == Axis.horizontal
        ? parent._partSize * part.area
        : parent.constraints.maxWidth,
      child: builder(context, parent.constraints),
    );
  }
}