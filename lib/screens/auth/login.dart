import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lista_tarefas/core/constants/colors.dart';
import 'package:lista_tarefas/screens/auth/forgot_password.dart';
import 'package:lista_tarefas/screens/auth/register.dart';
import 'package:lista_tarefas/screens/main/home.dart';
import 'package:lista_tarefas/widgets/big_button.dart';
import 'package:lista_tarefas/widgets/input.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin, WidgetsBindingObserver {
  final TextEditingController emailController = TextEditingController(text: "");
  final FocusNode emailFocusNode = FocusNode();
  late final TextInputValidatorController emailValidator;
  final TextEditingController passwordController = TextEditingController(text: "");
  final FocusNode passwordFocusNode = FocusNode();
  late final TextInputValidatorController passwordValidator;
  final SecretInputController passwordSecret = SecretInputController();

  late AnimationController _animationController;
  late Animation<double> _flexAnimation;

  double _lastBottomInset = 0;
  _KeyboardState _keyboardState = _KeyboardState.closed;
  
  final ValueNotifier<bool> _formValidNotifier = ValueNotifier<bool>(false);

  void _checkFormValidity() {
    WidgetsBinding.instance.addPostFrameCallback((context) {
      final isValid = emailValidator.valid && passwordValidator.valid;
      _formValidNotifier.value = isValid;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    RegExp emailRegexp = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );
    emailValidator = TextInputValidatorController((value) {
      if ((value ?? "").isEmpty) return "E-mail não pode estar vazio.";
      if (!emailRegexp.hasMatch(value ?? "")) return "Estrutura de e-mail inválida.";
      return null;
    }, emailController);

    passwordValidator = TextInputValidatorController((value) {
      if ((value ?? "").isEmpty) return "A senha não pode estar vazia.";
      return null;
    }, passwordController);

    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    _flexAnimation = Tween<double>(
      begin: 16.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    emailController.addListener(_checkFormValidity);
    passwordController.addListener(_checkFormValidity);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _animationController.dispose();
    super.dispose();
    emailController.dispose();
    emailFocusNode.dispose();
    passwordController.dispose();
    passwordFocusNode.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomInset = View.of(context).viewInsets.bottom;

    if (bottomInset != _lastBottomInset) {
      if (bottomInset > _lastBottomInset) {
        if (_keyboardState != _KeyboardState.open) {
          _animationController.forward();
          _keyboardState = _KeyboardState.open;
        }
      } else {
        if (_keyboardState != _KeyboardState.closed) {
          _animationController.reverse();
          _keyboardState = _KeyboardState.closed;
        }
      }
    }

    _lastBottomInset = bottomInset;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPrimaryColors.white,
      body: SafeArea(
        child: Column(
          children: [
            AnimatedBuilder(
              animation: _flexAnimation,
              builder: (context, _) {
                return Expanded(
                  flex: _flexAnimation.value.round(),
                  child: Center(
                    
                  ),
                );
              }
            ),
            Expanded(
              flex: 8,
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Entre agora", style: GoogleFonts.montserrat(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        height: 1.0,
                        color: AppPrimaryColors.extraDarkGrey
                      ),),
                      Row(
                        children: [
                          Text("no ", style: GoogleFonts.montserrat(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: AppPrimaryColors.extraDarkGrey,
                            // height: 1.0,
                          ),),
                          Text("DoIT", style: GoogleFonts.montserrat(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: AppPrimaryColors.blue,
                            // height: 1.0,
                          ),),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 12,
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20,),
                      AppTextInput(
                        controller: emailController,
                        focusNode: emailFocusNode,
                        label: "Email",
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
                          child: Text("Esqueceu a senha?"),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 12,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _flexAnimation,
                    builder: (context, _) {
                      return SizedBox(height: _flexAnimation.value * 5,);
                    }
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ValueListenableBuilder<bool>(
                      valueListenable: _formValidNotifier,
                      builder: (context, isFormValid, child) {
                        return AppBigButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (context) {
                                return Home();
                              }
                            ));
                          },
                          text: "Entrar",
                          color: isFormValid ? AppPrimaryColors.blue : AppPrimaryColors.grey,
                        );
                      }
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                          return Register();
                        }));
                      },
                      child: Text("Não tem uma conta?")
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum _KeyboardState {
  open,
  closed,
}