import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lista_tarefas/core/constants/rules.dart';
import 'package:lista_tarefas/core/utils/extensions.dart';
import 'package:lista_tarefas/core/utils/keyboard_observer.dart';
import 'package:lista_tarefas/widgets/text_input.dart';

/// Responde a mudança de tamanho do teclado com animação
/// Mudança de orientação rotaciona a direção do flex

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin, WidgetsBindingObserver, KeyboardObserver {
  final TextEditingController emailController = TextEditingController(text: "");
  final FocusNode emailFocusNode = FocusNode();
  late final TextInputValidatorController emailValidator;
  final TextEditingController passwordController = TextEditingController(text: "");
  final FocusNode passwordFocusNode = FocusNode();
  late final TextInputValidatorController passwordValidator;
  final SecretInputController passwordSecret = SecretInputController();

  late AnimationController keyboardSizeAnimationController;
  late Animation<double> keyboardSizeScaleAnimation;

  late double sizePart;
  late double crossAxisSize;

  late _ContainerSizeValues size1;
  late _ContainerSizeValues size2;
  late _ContainerSizeValues size3;

  void _updateSizes(Orientation orientation, BoxConstraints constraints) {
    sizePart = (constraints.maxOfAxis(orientation.asAxis)) / (32 + keyboardSizeScaleAnimation.value);
    crossAxisSize = constraints.maxOfAxis(orientation.asAxis.reverse);

    if (orientation == Orientation.portrait) {
      size1 = (height: sizePart * 12, width: crossAxisSize);
      size2 = (height: sizePart * 12, width: crossAxisSize);
      size3 = (height: sizePart * 8, width: crossAxisSize);
    } else {
      size1 = (height: crossAxisSize, width: sizePart * 12);
      size2 = (height: crossAxisSize, width: sizePart * 12);
      size3 = (height: crossAxisSize, width: sizePart * 8);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    
    emailValidator = TextInputValidatorController((v) => AppRules.email.firstError(v ?? ""), emailController);
    passwordValidator = TextInputValidatorController((v) => AppRules.password.firstError(v ?? ""), passwordController);

    keyboardSizeAnimationController = AnimationController(
      duration: kThemeAnimationDuration,
      vsync: this,
    );

    keyboardSizeScaleAnimation = Tween<double>(
      begin: 16,
      end: 0,
    ).animate(CurvedAnimation(
      parent: keyboardSizeAnimationController,
      curve: Curves.easeInOut,
    ));

    keyboardSizeAnimationController.addStatusListener((status) {
      if (status.isCompleted || status.isDismissed) {
        setState(() {
          // _updateSizes(MediaQuery.of(context).orientation, constraints)
        });
      }
    });
  }

  @override
  void onKeyboardOpen() => keyboardSizeAnimationController.forward();

  @override
  void onKeyboardClose() => keyboardSizeAnimationController.reverse();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final orientation = MediaQuery.of(context).orientation;

            _updateSizes(orientation, constraints);

            return Flex(
              direction: MediaQuery.of(context).orientation.asAxis,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: keyboardSizeAnimationController,
                  builder: (context, _) {
                    final _ContainerSizeValues size = orientation == Orientation.portrait
                      ? (height: sizePart * keyboardSizeScaleAnimation.value, width: crossAxisSize)
                      : (height: crossAxisSize, width: sizePart * keyboardSizeScaleAnimation.value);
                    _updateSizes(orientation, constraints);
                    return SizedBox(
                      height: size.height,
                      width: size.width,
                    );
                  }
                ),
                SizedBox(
                  height: size1.height,
                  width: size1.width,
                  child: Text("data"),
                ),
                Container(
                  color: Colors.blue,
                  height: size2.height,
                  width: size2.width,
                  // child: AppTextInput(
                  //   controller: passwordController,
                  //   focusNode: passwordFocusNode,
                  //   validator: passwordValidator,
                  //   label: "Senha",
                  //   prefixIcon: Icons.lock_outline,
                  //   obscureText: true,
                  //   maxLines: 1,
                  // ),
                ),
                Container(
                  // color: Colors.amber,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.amber,
                      Colors.white,
                    ], transform: GradientRotation(pi / 2 ))
                  ),
                  height: size3.height,
                  width: size3.width,
                ),
              ],
            );
          }
        )
      )
    );
  }
}

typedef _ContainerSizeValues = ({double height, double width});