import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lista_tarefas/core/constants/colors.dart';
import 'package:lista_tarefas/core/constants/dimensions.dart';

class AppBarLeadingIcon extends StatelessWidget {
  final IconData icon;

  const AppBarLeadingIcon(this.icon, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05 - 6),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          splashColor: AppColors.white,
          borderRadius: AppBorderRadius.circular,
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle
            ),
            child: Center(
              child: FaIcon(
                icon,
                size: 24,
              ),
            ),
          ),
        ),
      )
    );
  }
}