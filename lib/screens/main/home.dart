import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lista_tarefas/core/constants/colors.dart';
import 'package:lista_tarefas/core/utils/set_system_style.dart';
import 'package:lista_tarefas/widgets/bottom_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    setSystemStyle(true);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("Olá, ", style: const TextStyle(
              fontWeight: FontWeight.bold
            ),),
            Text("Roberto", style: TextStyle(
              color: AppColors.blue,
              fontWeight: FontWeight.bold
            ),)
          ],
        ),
      ),
      body: LayoutBuilder(
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
      ),
      bottomNavigationBar: AppBottomBar(
        items: [
          AppBottomBarItem(
            icon: FontAwesomeIcons.a,
            label: "AAAAAAA"
          ),
          AppBottomBarItem(
            icon: FontAwesomeIcons.b,
            label: "BBBBBBB"
          ),
          AppBottomBarItem(
            icon: FontAwesomeIcons.c,
            label: "CCCCCCCccccasdadasdasdasd"
          ),
          AppBottomBarItem(
            icon: FontAwesomeIcons.d,
            label: "d",
          ),
        ]
      ),
    );
  }
}