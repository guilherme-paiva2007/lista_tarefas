import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lista_tarefas/core/constants/colors.dart';
import 'package:lista_tarefas/core/utils/set_system_style.dart';
import 'package:lista_tarefas/screens/main/home.dart';
import 'package:lista_tarefas/widgets/bottom_bar.dart';

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  late final AppBottomBarController bottomBarController;

  @override
  void initState() {
    super.initState();

    bottomBarController = AppBottomBarController(
      screens: [
        AppBottomBarItem(
          icon: FontAwesomeIcons.house,
          label: "Início",
          builder: (context) {
            return Home();
          },
        ),
        AppBottomBarItem(
          icon: FontAwesomeIcons.b,
          label: "BBBBBBB",
          builder: (context) {
            return Placeholder();
          },
        ),
        AppBottomBarItem(
          icon: FontAwesomeIcons.c,
          label: "CCCCCCCccccasdadasdasdasd",
          builder: (context) {
            return Placeholder();
          },
        ),
        AppBottomBarItem(
          icon: FontAwesomeIcons.d,
          label: "d",
          builder: (context) {
            return Placeholder();
          },
        ),
      ]
    );
  }

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
      body: AppBottomBarDisplay(controller: bottomBarController),
      bottomNavigationBar: AppBottomBar(
        controller: bottomBarController,
      ),
    );
  }
}