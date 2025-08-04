import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lista_tarefas/core/constants/rules.dart';
import 'package:lista_tarefas/core/utils/keyboard_observer.dart';
import 'package:lista_tarefas/widgets/date_input.dart';
import 'package:lista_tarefas/widgets/text_input.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> with TickerProviderStateMixin, WidgetsBindingObserver, KeyboardObserver {
  final TextEditingController nameController = TextEditingController();
  final FocusNode nameFocusNode = FocusNode();
  late final TextInputValidatorController nameValidator;
  final TextEditingController emailController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  late final TextInputValidatorController emailValidator;
  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();
  late final TextInputValidatorController passwordValidator;
  final DateInputController birthDateController = DateInputController();
  final FocusNode birthDateFocusNode = FocusNode();
  late final DateInputValidatorController birthDateValidator;

  late AnimationController animationController;
  late Animation animation;

  final ValueNotifier<bool> formValidNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    string() => "";

    nameValidator = TextInputValidatorController(AppRules.name.toValidator(string), nameController);
    emailValidator = TextInputValidatorController(AppRules.email.toValidator(string), emailController);
    passwordValidator = TextInputValidatorController(AppRules.password.toValidator(string), passwordController);
    birthDateValidator = DateInputValidatorController(AppRules.birthDate.toValidator(DateTime.now), birthDateController);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    
    WidgetsBinding.instance.removeObserver(this);
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}