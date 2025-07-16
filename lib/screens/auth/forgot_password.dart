import 'package:flutter/material.dart';
import 'package:lista_tarefas/core/constants/colors.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Não implementado!!!", style: TextStyle(
              fontFamily: "Montserrat",
              color: AppColors.red,
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),),
            ElevatedButton(onPressed: () {
              Navigator.of(context).pop();
            }, child: Text("Voltar"))
          ],
        ),
      ),
    );
  }
}