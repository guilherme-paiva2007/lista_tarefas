import 'package:flutter/material.dart';

class SharedNavigatorScreen {
  final PreferredSizeWidget Function(BuildContext context)? appBar;
  final Widget Function(BuildContext context)? bottomBar;
  final Widget Function(BuildContext context)? floatingActionButton;
  final Widget Function(BuildContext context)? drawer;
  final Widget Function(BuildContext context) builder;

  const SharedNavigatorScreen({
    required this.builder,
    this.appBar,
    this.bottomBar,
    this.floatingActionButton,
    this.drawer,
  });
}

class SharedNavigator {
  final SharedNavigatorController controller;

  final PreferredSizeWidget Function(BuildContext context)? appBar;
  final Widget Function(BuildContext context)? bottomBar;
  final Widget Function(BuildContext context)? floatingActionButton;
  final Widget Function(BuildContext context)? drawer;

  const SharedNavigator({
    required this.controller,
    this.appBar,
    this.bottomBar,
    this.drawer,
    this.floatingActionButton
  });
}

class SharedNavigatorController {
  final List<SharedNavigatorScreen> screens;
  final ValueNotifier<int> _notifier = ValueNotifier<int>(0);

  SharedNavigatorController(this.screens);

  int get currentIndex => _notifier.value;
  SharedNavigatorScreen get currentScreen => screens[_notifier.value];

  void navigate(SharedNavigatorScreen screen) {
    final index = screens.indexOf(screen);
    if (index == -1) {
      throw ArgumentError("Screen not found in navigator: $screen");
    }
    _notifier.value = index;
  }
}

abstract class SharedNavigatorDisplay {
  final SharedNavigator navigator;
  
  SharedNavigatorController get controller => navigator.controller;

  const SharedNavigatorDisplay._({
    required this.navigator,
  });
}

final class SharedNavigatorAppBar extends SharedNavigatorDisplay {
  const SharedNavigatorAppBar({
    required super.navigator,
  }): super._();
  
  PreferredSizeWidget? build(BuildContext context) {
    return (navigator.controller.currentScreen.appBar ?? navigator.appBar)?.call(context);
  }
}

final class SharedNavigatorBottomBar extends SharedNavigatorDisplay {
  const SharedNavigatorBottomBar({
    required super.navigator,
  }): super._();

  Widget? build(BuildContext context) {
    return (navigator.controller.currentScreen.bottomBar ?? navigator.bottomBar)?.call(context);
  }
}

final class SharedNavigatorDrawer extends SharedNavigatorDisplay {
  const SharedNavigatorDrawer({
    required super.navigator,
  }): super._();

  Widget? build(BuildContext context) {
    return (navigator.controller.currentScreen.drawer ?? navigator.drawer)?.call(context);
  }
}

final class SharedNavigatorFloatingActionButton extends SharedNavigatorDisplay {
  const SharedNavigatorFloatingActionButton({
    required super.navigator,
  }): super._();

  Widget? build(BuildContext context) {
    return (navigator.controller.currentScreen.floatingActionButton ?? navigator.floatingActionButton)?.call(context);
  }
}

final class SharedNavigatorBody extends SharedNavigatorDisplay {
  const SharedNavigatorBody({
    required super.navigator,
  }): super._();

  Widget build(BuildContext context) {
    return controller.currentScreen.builder(context);
  }
}

typedef _ScaffoldBuilder = Scaffold Function({
  PreferredSizeWidget? appBar,
  Widget? bottomBar,
  Widget? floatingActionButton,
  Widget? drawer,
  required Widget body,
});

class SharedNavigatorScaffold extends StatelessWidget {
  final SharedNavigator navigator;
  final _ScaffoldBuilder? _builder;

  // ignore: library_private_types_in_public_api
  _ScaffoldBuilder get builder {
    return _builder ?? ({
      PreferredSizeWidget? appBar,
      Widget? bottomBar,
      Widget? floatingActionButton,
      Widget? drawer,
      required Widget body,
    }) {
      return Scaffold(
        appBar: appBar,
        bottomNavigationBar: bottomBar,
        floatingActionButton: floatingActionButton,
        drawer: drawer,
        body: body,
      );
    };
  }

  const SharedNavigatorScaffold({
    // ignore: library_private_types_in_public_api
    _ScaffoldBuilder? builder,
    required this.navigator,
    super.key,
  }): _builder = builder;

  @override
  Widget build(BuildContext context) {
    final currentScreen = navigator.controller.currentScreen;
    return ValueListenableBuilder(
      valueListenable: navigator.controller._notifier,
      builder: (context, _, _) {
        return builder(
          body: currentScreen.builder(context),
          appBar: (currentScreen.appBar ?? navigator.appBar)?.call(context),
          bottomBar: (currentScreen.bottomBar ?? navigator.bottomBar)?.call(context),
          floatingActionButton: (currentScreen.floatingActionButton ?? navigator.floatingActionButton)?.call(context),
          drawer: (currentScreen.drawer ?? navigator.drawer)?.call(context),
        );
      }
    );
  }
}

class I extends SharedNavigatorScreen {
  @override
  Widget Function(BuildContext) get bottomBar => ((context) => const Placeholder());
  
  const I({
    required super.builder,
    super.appBar,
    super.floatingActionButton,
    super.drawer,
  });
}