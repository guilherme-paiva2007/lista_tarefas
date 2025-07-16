import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lista_tarefas/core/constants/colors.dart';
import 'package:lista_tarefas/widgets/home/bottom_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
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
                    color: Colors.red,
                  ),
                  Container(
                    height: height * 0.3,
                    color: Colors.amber,
                  ),
                  Container(
                    height: height * 0.3,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
          );
        }
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: FaIcon(FontAwesomeIcons.a),
      //       label: "A"          
      //     ),
      //     BottomNavigationBarItem(
      //       icon: FaIcon(FontAwesomeIcons.b),
      //       label: "B"
      //     ),
      //     BottomNavigationBarItem(
      //       icon: FaIcon(FontAwesomeIcons.c),
      //       label: "C",
      //     )
      //   ]
      // ),
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