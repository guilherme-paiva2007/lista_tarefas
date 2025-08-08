import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lista_tarefas/core/constants/rules.dart';
import 'package:lista_tarefas/core/utils/layout_size_divider.dart';
import 'package:lista_tarefas/core/utils/screen_observer.dart';
import 'package:lista_tarefas/widgets/date_input.dart';
import 'package:lista_tarefas/widgets/text_input.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> with TickerProviderStateMixin, WidgetsBindingObserver, ScreenObserver {
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

  late final LayoutSizeDivider layoutDivider;
  
  late final DividerPart blankPart1;
  late final DividerPart textPart;
  late final DividerPart blankPart2;
  late final DividerPart formPart;
  late final DividerPart blankPart3;
  late final DividerPart submitPart;
  late final DividerPart blankPart4;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    string() => "";

    nameValidator = TextInputValidatorController(AppRules.name.toValidator(string), nameController);
    emailValidator = TextInputValidatorController(AppRules.email.toValidator(string), emailController);
    passwordValidator = TextInputValidatorController(AppRules.password.toValidator(string), passwordController);
    birthDateValidator = DateInputValidatorController(AppRules.birthDate.toValidator(DateTime.now), birthDateController);

    animationController = AnimationController(
      vsync: this,
      duration: kThemeAnimationDuration,
    );

    animation = Tween<double>(
      begin: 14,
      end: 2,
    ).animate(animationController,);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    layoutDivider = LayoutSizeDivider([
      4,
      3,
      4,
      8,
      2,
      2,
      2,
    ]);

    blankPart1 = layoutDivider[0];
    textPart = layoutDivider[1];
    blankPart2 = layoutDivider[2];
    formPart = layoutDivider[3];
    blankPart3 = layoutDivider[4];
    submitPart = layoutDivider[5];
    blankPart4 = layoutDivider[6];
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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kFloatingActionButtonMargin),
          child: LayoutBuilder(
            builder: (context, constraints) {
              layoutDivider.size = constraints.maxHeight;
              return Column(
                children: [
                  SizedBox(
                    height: blankPart1.size,
                    width: constraints.maxWidth,
                  ),
                  SizedBox(
                    height: textPart.size,
                    width: constraints.maxWidth,
                  ),
                  SizedBox(
                    height: blankPart2.size,
                    width: constraints.maxWidth,
                  ),
                  SizedBox(
                    height: formPart.size,
                    width: constraints.maxWidth,
                  ),
                  SizedBox(
                    height: blankPart3.size,
                    width: constraints.maxWidth,
                  ),
                  SizedBox(
                    height: submitPart.size,
                    width: constraints.maxWidth,
                  ),
                  SizedBox(
                    height: blankPart4.size,
                    width: constraints.maxWidth,
                  ),
                ],
              );
            }
          ),
        )
      ),
    );
  }
}