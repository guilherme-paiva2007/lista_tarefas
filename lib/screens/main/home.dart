import 'package:flutter/material.dart';
import 'package:lista_tarefas/core/constants/colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        final width = constraints.maxWidth - (2 * kFloatingActionButtonMargin);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: kFloatingActionButtonMargin),
          child: SizedBox(
            height: height,
            width: width,
            child: Column(
              children: [
                Container(
                  height: height * 0.4,
                  color: AppColors.gold,
                ),
                Container(
                  height: height * 0.3,
                  color: AppColors.purple,
                ),
                Container(
                  height: height * 0.3,
                  color: AppColors.blue,
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}