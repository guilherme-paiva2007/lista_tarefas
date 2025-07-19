import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lista_tarefas/core/constants/colors.dart';
import 'package:lista_tarefas/core/theme.dart';

class AppBottomBar extends StatefulWidget {
  final AppBottomBarController controller;

  const AppBottomBar({
    required this.controller,
    super.key
  });

  @override
  State<AppBottomBar> createState() => _AppBottomBarState();

  static _AppBottomBarState _of(BuildContext context) {
    final state = context.findAncestorStateOfType<_AppBottomBarState>();
    if (state == null) throw StateError("No AppBottomBar found in context");
    return state;
  }
}

class _AppBottomBarState extends State<AppBottomBar> {
  late double maxItemWidth;

  AppBottomBarController get controller => widget.controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller._selectedIndexNotifier,
      builder: (context, value, child) {
        return SafeArea(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              border: Border(
                top: BorderSide(
                  color: AppThemeColors.extraLight,
                )
              )
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  maxItemWidth = constraints.maxWidth / widget.controller.screens.length;
                  return Row(
                    children: widget.controller.screens.map((s) => _AppBottomBarItem(
                      builder: s.builder,
                      icon: s.icon,
                      label: s.label,
                      selected: controller._selectedIndexNotifier.value == controller.screens.indexOf(s),
                      item: s,
                    )).toList(),
                  );
                }
              ),
            ),
          ),
        );
      }
    );
  }
}

class AppBottomBarItem {
  final IconData icon;
  final String label;
  final Widget Function(BuildContext context) builder;

  const AppBottomBarItem({
    required this.builder,
    required this.icon,
    required this.label
  });
}

class _AppBottomBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget Function(BuildContext context) builder;
  final bool selected;
  final AppBottomBarItem item;

  const _AppBottomBarItem({
    required this.builder,
    required this.icon,
    required this.label,
    required this.item,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    final state = AppBottomBar._of(context);
    final controller = state.controller;
    final thisIndex = controller.screens.indexOf(item);
    final selectedColor = selected
      ? AppColors.blue
      : null;
    return SizedBox(
      width: state.maxItemWidth,
      child: GestureDetector(
        onTap: () {
          controller.selectIndex(thisIndex);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 32,
              width: 32,
              child: Center(
                child: FaIcon(
                  icon,
                  size: 24,
                  color: selectedColor ?? ColorScheme.of(context).onSurface,
                ),
              ),
            ),
            Text(
              label,
              style: TextTheme.of(context).labelSmall?.copyWith(
                color: selectedColor
              ) ?? TextStyle(color: selectedColor),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}

class AppBottomBarDisplay extends StatefulWidget {
  final AppBottomBarController controller;

  const AppBottomBarDisplay({ required this.controller, super.key });

  @override
  State<AppBottomBarDisplay> createState() => _AppBottomBarDisplayState();
}

class _AppBottomBarDisplayState extends State<AppBottomBarDisplay> {
  AppBottomBarController get controller => widget.controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller._selectedIndexNotifier,
      builder: (context, index, _) {
        return IndexedStack(
          index: index,
          children: controller.screens.map((s) => s.builder(context)).toList(),
        );
      }
    );
  }
}

class AppBottomBarController {
  final List<AppBottomBarItem> screens;
  final ValueNotifier<int> _selectedIndexNotifier = ValueNotifier<int>(0);

  AppBottomBarController({required this.screens}):
    assert(screens.isNotEmpty, "At least one screen must be provided");

  void selectIndex(int index) {
    if (index < 0 || index >= screens.length) {
      throw RangeError("Index out of range: $index");
    }
    _selectedIndexNotifier.value = index;
  }
}