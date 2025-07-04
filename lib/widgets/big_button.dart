import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lista_tarefas/core/constants/colors.dart';

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
    return SizedBox(
      width: double.infinity,
      child: AnimatedContainer(
        duration: widget.animationDuration ?? Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: _isPressed 
              ? (widget.hoverColor ?? widget.color.withOpacity(0.8))
              : widget.color,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onPressed,
            onTapDown: (_) => setState(() => _isPressed = true),
            onTapUp: (_) => setState(() => _isPressed = false),
            onTapCancel: () => setState(() => _isPressed = false),
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
              child: Center(
                child: Text(
                  widget.text,
                  style: GoogleFonts.montserrat(
                    color: AppPrimaryColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
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