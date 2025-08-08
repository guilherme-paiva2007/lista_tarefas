import 'package:flutter/material.dart';

mixin ScreenObserver<T extends StatefulWidget> on State<T>, WidgetsBindingObserver {
  void onKeyboardOpen() {}
  void onKeyboardClose() {}

  void onKeyboardHeightChanged(double height) {}

  double _lastBottomInset = 0;
  KeyboardState _keyboardState = KeyboardState.closed;

  KeyboardState get keyboardState => _keyboardState;

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final bottomInset = View.of(context).viewInsets.bottom;

    if (bottomInset != _lastBottomInset) {
      onKeyboardHeightChanged(bottomInset);

      if (bottomInset > _lastBottomInset) {
        if (_keyboardState != KeyboardState.open) {
          // _animationController.forward();
          _keyboardState = KeyboardState.open;
          onKeyboardOpen();
        }
      } else {
        if (_keyboardState != KeyboardState.closed) {
          // _animationController.reverse();
          _keyboardState = KeyboardState.closed;
          onKeyboardClose();
        }
      }
    }

    _lastBottomInset = bottomInset;
  }
}

enum KeyboardState {
  open,
  closed;
}