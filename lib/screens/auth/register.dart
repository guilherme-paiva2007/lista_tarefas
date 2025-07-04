import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lista_tarefas/core/constants/colors.dart';
import 'package:lista_tarefas/widgets/big_button.dart';
import 'package:lista_tarefas/widgets/input.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> with TickerProviderStateMixin, WidgetsBindingObserver {
  final TextEditingController nameController = TextEditingController();
  final FocusNode nameFocusNode = FocusNode();
  late final InputValidatorController nameValidator;
  bool nameFirstTyped = false;
  final TextEditingController emailController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  late final InputValidatorController emailValidator;
  bool emailFirstTyped = false;
  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();
  late final InputValidatorController passwordValidator;
  bool passwordFirstTyped = false;

  late AnimationController _animationController;
  late Animation<double> _sizeAnimation;

  double _lastBottomInset = 0;
  _KeyboardState _keyboardState = _KeyboardState.closed;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    
    final RegExp nameRegExp = RegExp(r"^[a-zA-ZÀ-ÿ\s]+$");
    nameValidator = InputValidatorController((value) {
      if ((value ?? "").isEmpty) return "O nome não pode estar vazio";
      if (!nameRegExp.hasMatch(value ?? "")) return "O nome só pode conter letras e espaços.";
      return null;
    }, nameController);

    RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );
    emailValidator = InputValidatorController((value) {
      if ((value ?? "").isEmpty) return "E-mail não pode estar vazio.";
      if (!emailRegExp.hasMatch(value ?? "")) return "Estrutura de e-mail inválida.";
      return null;
    }, emailController);

    passwordValidator = InputValidatorController((value) {
      value ??= "";
      if (value.isEmpty) return "A senha não pode estar vazia.";
      if (value.length < 8 || value.length > 64) return "A senha precisa ter entre 8 e 64 caracteres.";
      return null;
    }, passwordController);

    _animationController = AnimationController(
      duration: Duration(milliseconds: 350),
      vsync: this,
    );

    _sizeAnimation = Tween<double>(
      begin: 64.0,
      end: 0.0
    ).animate(_animationController);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _animationController.dispose();
    super.dispose();
    emailController.dispose();
    emailFocusNode.dispose();
    nameController.dispose();
    nameFocusNode.dispose();
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
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
              child: FaIcon(FontAwesomeIcons.chevronLeft, size: 24, color: AppPrimaryColors.extraDarkGrey,),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            AnimatedBuilder(
              animation: _sizeAnimation,
              builder: (context, _) {
                return Expanded(
                  flex: (1 - _animationController.value).ceil(),
                  child: Container(),
                );
              }
            ),
            Expanded(
              flex: 3,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Cadastre-se no", style: GoogleFonts.montserrat(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      height: 1.0,
                      color: AppPrimaryColors.extraDarkGrey
                    ),),
                    Row(
                      children: [
                        Text("DoIT ", style: GoogleFonts.montserrat(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: AppPrimaryColors.blue,
                          // height: 1.0,
                        ),),
                        Text("agora", style: GoogleFonts.montserrat(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: AppPrimaryColors.extraDarkGrey,
                          // height: 1.0,
                        ),),
                      ],
                    )
                  ],
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _sizeAnimation,
              builder: (context, _) {
                return Expanded(
                  flex: (8 - _animationController.value * 8).round(),
                  child: SizedBox(
                    height: _animationController.value,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(46.0),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppPrimaryColors.darkGrey
                            ),
                            height: _sizeAnimation.value,
                            width: _sizeAnimation.value,
                            constraints: BoxConstraints(
                              maxHeight: _sizeAnimation.value
                            ),
                            child: Center(
                              child: FaIcon(FontAwesomeIcons.images, size: 48 * (1 - _animationController.value), color: AppPrimaryColors.lightGrey,)
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                );
              }
            ),
            Expanded(
              flex: 8,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 24
                    - (nameValidator.valid || !nameFirstTyped ? 0 : 6)
                    - (emailValidator.valid || !emailFirstTyped ? 0 : 6)
                    - (passwordValidator.valid || !passwordFirstTyped ? 0 : 6),
                  children: [
                    AppInput(
                      controller: nameController,
                      focusNode: nameFocusNode,
                      validator: nameValidator,
                      label: "Nome",
                      maxLines: 1,
                      suffixIcon: FontAwesomeIcons.signature,
                      onChanged: (value, state) => WidgetsBinding.instance.addPostFrameCallback((_) {
                        nameFirstTyped = true;
                        setState(() {});
                      }),
                    ),
                    AppInput(
                      controller: emailController,
                      focusNode: emailFocusNode,
                      validator: emailValidator,
                      label: "E-mail",
                      maxLines: 1,
                      suffixIcon: FontAwesomeIcons.envelope,
                      onChanged: (value, state) => WidgetsBinding.instance.addPostFrameCallback((_) {
                        emailFirstTyped = true;
                        setState(() {});
                      }),
                    ),
                    AppInput(
                      controller: passwordController,
                      focusNode: passwordFocusNode,
                      validator: passwordValidator,
                      label: "Senha",
                      autocorrect: false,
                      enableSuggestions: false,
                      obscureText: true,
                      suffixIcon: FontAwesomeIcons.eyeSlash,
                      maxLines: 1,
                      onChanged: (value, state) => WidgetsBinding.instance.addPostFrameCallback((_) {
                        passwordFirstTyped = true;
                        setState(() {});
                      }),
                      onTapSuffixIcon: (state) {
                        state.setState(() {
                          if (state.obscureText) {
                            state.suffixIcon = FontAwesomeIcons.eye;
                            state.obscureText = false;
                          } else {
                            state.suffixIcon = FontAwesomeIcons.eyeSlash;
                            state.obscureText = true;
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _sizeAnimation,
              builder: (context, _) {
                return Expanded(
                  flex: (5 - _animationController.value * 3).ceil(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: AppBigButton(
                          onPressed: () {},
                          text: "Cadastrar-se",
                          color: (
                            emailValidator.valid &&
                            passwordValidator.valid &&
                            nameValidator.valid
                          ) ? AppPrimaryColors.indigo : AppPrimaryColors.darkGrey,
                        ),
                      ),
                    ],
                  ),
                );
              }
            )
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