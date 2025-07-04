import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lista_tarefas/screens/auth/login.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      home: Login(),
    );
  }
}