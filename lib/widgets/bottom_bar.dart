import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lista_tarefas/core/constants/colors.dart';
import 'package:lista_tarefas/core/theme.dart';

class AppBottomBar extends StatefulWidget {
  final List<AppBottomBarItem> items;

  const AppBottomBar({
    required this.items,
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

  @override
  Widget build(BuildContext context) {
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
              maxItemWidth = constraints.maxWidth / widget.items.length;
              return Row(
                children: widget.items,
              );
            }
          ),
        ),
      ),
    );
  }
}

class AppBottomBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;

  const AppBottomBarItem({
    required this.icon,
    required this.label,
    this.selected = false,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    final selectedColor = selected ? AppColors.blue : null;
    return SizedBox(
      width: AppBottomBar._of(context).maxItemWidth,
      child: GestureDetector(
        onTap: () {
          print("Nav button pressed");
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
                  size: 20,
                  color: selectedColor ?? ColorScheme.of(context).onSurface,
                ),
              ),
            ),
            Text(
              label,
              style: TextTheme.of(context).labelSmall?.copyWith(
                color: selectedColor,
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