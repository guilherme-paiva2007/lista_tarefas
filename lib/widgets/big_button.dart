import 'package:flutter/material.dart';
import 'package:lista_tarefas/core/constants/colors.dart';
import 'package:lista_tarefas/core/constants/dimensions.dart';

class AppBigButton extends StatefulWidget {
  final String text;
  final void Function() onPressed;
  final Color color;
  final Color? hoverColor; // Optional hover color
  final Duration? animationDuration; // Optional animation duration

  const AppBigButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.color,
    this.hoverColor,
    this.animationDuration,
  });

  @override
  State<AppBigButton> createState() => _AppBigButtonState();
}

class _AppBigButtonState extends State<AppBigButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: double.infinity,
      child: AnimatedContainer(
        duration: widget.animationDuration ?? Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: _isPressed 
              ? (widget.hoverColor ?? Color.lerp(widget.color, colorScheme.surface, 0.4))
              : widget.color,
          borderRadius: AppBorderRadius.small,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Color.lerp(widget.color, colorScheme.surface, 0.4),
            onTap: widget.onPressed,
            onTapDown: (_) => setState(() => _isPressed = true),
            onTapUp: (_) => setState(() => _isPressed = false),
            onTapCancel: () => setState(() => _isPressed = false),
            borderRadius: AppBorderRadius.small,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
              child: Center(
                child: Text(
                  widget.text,
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: "Montserrat",
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}