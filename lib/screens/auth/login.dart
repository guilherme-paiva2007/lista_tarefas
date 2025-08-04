import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lista_tarefas/core/constants/colors.dart';
import 'package:lista_tarefas/core/constants/rules.dart';
import 'package:lista_tarefas/core/utils/extensions.dart';
import 'package:lista_tarefas/core/utils/keyboard_observer.dart';
import 'package:lista_tarefas/screens/auth/forgot_password.dart';
import 'package:lista_tarefas/widgets/big_button.dart';
import 'package:lista_tarefas/widgets/text_input.dart';

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

  final ValueNotifier<bool> validFormNotifier = ValueNotifier(false);

  void checkFormValidity() {
    WidgetsBinding.instance.addPostFrameCallback((context) {
      validFormNotifier.value = emailValidator.valid && passwordValidator.valid;
    });
  }

  void _updateSizes(Orientation orientation, BoxConstraints constraints) {
    sizePart = (constraints.maxHeight) / (26 + keyboardSizeScaleAnimation.value);
    crossAxisSize = constraints.maxWidth - kFloatingActionButtonMargin * 2;

    size1 = (height: sizePart * 8, width: crossAxisSize);
    size2 = (height: sizePart * 16, width: crossAxisSize);
    size3 = (height: sizePart * 2, width: crossAxisSize);
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
      end: 2,
    ).animate(CurvedAnimation(
      parent: keyboardSizeAnimationController,
      curve: Curves.easeInOut,
    ));

    keyboardSizeAnimationController.addStatusListener((status) {
      if (status.isCompleted || status.isDismissed) {
        setState(() {});
      }
    });

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    emailController.addListener(checkFormValidity);
    passwordController.addListener(checkFormValidity);
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
    keyboardSizeAnimationController.dispose();
    super.dispose();
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

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: kFloatingActionButtonMargin),
              child: Flex(
                direction: orientation.asAxis,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Entre agora", style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          height: 1.0,
                        ),),
                        Row(
                          children: [
                            Text("no ", style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),),
                            Text("DoIT", style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: AppColors.blue,
                            ),),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size2.height,
                    width: size2.width,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20,),
                          AppTextInput(
                            controller: emailController,
                            focusNode: emailFocusNode,
                            label: "E-mail",
                            suffixIcon: FontAwesomeIcons.envelope,
                            validator: emailValidator,
                            maxLines: 1,
                          ),
                          SizedBox(height: 20,),
                          AppTextInput(
                            controller: passwordController,
                            focusNode: passwordFocusNode,
                            label: "Senha",
                            suffixIcon: passwordSecret.icon,
                            suffixIconPadding: passwordSecret.obscure ? 12 : 14,
                            validator: passwordValidator,
                            autocorrect: false,
                            enableSuggestions: false,
                            obscureText: passwordSecret.obscure,
                            onTapSuffixIcon: () {
                              setState(() {
                                passwordSecret.toggle();
                              });
                            },
                            maxLines: 1,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, top: 4),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ForgotPassword()));
                              },
                              child: Text("Esqueceu a senha?",),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Column(
                            children: [
                              ValueListenableBuilder(
                                valueListenable: validFormNotifier,
                                builder: (context, isValid, _) {
                                  return AppBigButton(
                                    onPressed: () {},
                                    text: "Entrar",
                                    color: isValid ? AppColors.blue : ColorScheme.of(context).surfaceContainer
                                  );
                                }
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size3.height,
                    width: size3.width,
                  ),
                ],
              ),
            );
          }
        )
      )
    );
  }
}

typedef _ContainerSizeValues = ({double height, double width});