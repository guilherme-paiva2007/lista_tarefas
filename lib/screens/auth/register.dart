import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lista_tarefas/core/constants/colors.dart';
import 'package:lista_tarefas/widgets/big_button.dart';
import 'package:lista_tarefas/widgets/date_input.dart';
import 'package:lista_tarefas/widgets/input.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> with TickerProviderStateMixin, WidgetsBindingObserver {
  final TextEditingController nameController = TextEditingController();
  final FocusNode nameFocusNode = FocusNode();
  late final TextInputValidatorController nameValidator;
  bool nameFirstTyped = false;
  final TextEditingController emailController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  late final TextInputValidatorController emailValidator;
  bool emailFirstTyped = false;
  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();
  late final TextInputValidatorController passwordValidator;
  final SecretInputController passwordSecret = SecretInputController();
  bool passwordFirstTyped = false;
  final DateInputController birthDateController = DateInputController();
  final FocusNode birthDateFocusNode = FocusNode();
  late final DateInputValidatorController birthDateValidator;
  bool birthDateFirstTyped = false;

  late AnimationController _animationController;
  late Animation<double> _sizeAnimation;

  double _lastBottomInset = 0;
  _KeyboardState _keyboardState = _KeyboardState.closed;

  final ValueNotifier<bool> _formValidNotifier = ValueNotifier<bool>(false);

  void _checkFormValidity() {
    WidgetsBinding.instance.addPostFrameCallback((context) {
      final isValid =
        emailValidator.valid
        && passwordValidator.valid
        && nameValidator.valid
        && birthDateValidator.valid;
      print(isValid);
      _formValidNotifier.value = isValid;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    
    final RegExp nameRegExp = RegExp(r"^[a-zA-ZÀ-ÿ\s]+$");
    nameValidator = TextInputValidatorController((value) {
      if ((value ?? "").isEmpty) return "O nome não pode estar vazio";
      if (!nameRegExp.hasMatch(value ?? "")) return "O nome só pode conter letras e espaços.";
      return null;
    }, nameController);

    RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );
    emailValidator = TextInputValidatorController((value) {
      if ((value ?? "").isEmpty) return "E-mail não pode estar vazio.";
      if (!emailRegExp.hasMatch(value ?? "")) return "Estrutura de e-mail inválida.";
      return null;
    }, emailController);

    passwordValidator = TextInputValidatorController((value) {
      value ??= "";
      if (value.isEmpty) return "A senha não pode estar vazia.";
      if (value.length < 8 || value.length > 64) return "A senha precisa ter entre 8 e 64 caracteres.";
      return null;
    }, passwordController);

    birthDateValidator = DateInputValidatorController((date) {
      print(date);
      if (date == null) return "A data não pode estar vazia.";
      return null;
    }, birthDateController);

    _animationController = AnimationController(
      duration: Duration(milliseconds: 350),
      vsync: this,
    );

    _sizeAnimation = Tween<double>(
      begin: 64.0,
      end: 0.0
    ).animate(_animationController);

    emailController.addListener(_checkFormValidity);
    passwordController.addListener(_checkFormValidity);
    nameController.addListener(_checkFormValidity);
    birthDateController.addListener(_checkFormValidity);
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
      backgroundColor: AppPrimaryColors.white,
      appBar: AppBar(
        backgroundColor: AppPrimaryColors.white,
        surfaceTintColor: AppPrimaryColors.white,
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
            Expanded(
              flex: 1,
              child: Center(),
            ),
            Expanded(
              flex: 8,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      spacing: 24,
                      children: [
                        AppTextInput(
                          controller: nameController,
                          focusNode: nameFocusNode,
                          validator: nameValidator,
                          label: "Nome",
                          maxLines: 1,
                          suffixIcon: FontAwesomeIcons.signature,
                        ),
                        AppTextInput(
                          controller: emailController,
                          focusNode: emailFocusNode,
                          validator: emailValidator,
                          label: "E-mail",
                          maxLines: 1,
                          suffixIcon: FontAwesomeIcons.envelope,
                        ),
                        AppTextInput(
                          controller: passwordController,
                          focusNode: passwordFocusNode,
                          validator: passwordValidator,
                          label: "Senha",
                          autocorrect: false,
                          enableSuggestions: false,
                          obscureText: passwordSecret.obscure,
                          suffixIcon: passwordSecret.icon,
                          maxLines: 1,
                          onTapSuffixIcon: () {
                            setState(() {
                              passwordSecret.toggle();
                            });
                          },
                        ),
                        AppDateInput(
                          controller: birthDateController,
                          focusNode: birthDateFocusNode,
                          validator: birthDateValidator,
                          label: "Data de nascimento",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _sizeAnimation,
              builder: (context, _) {
                return Expanded(
                  flex: (5 - _animationController.value * 2).ceil(),
                  child: ValueListenableBuilder(
                    valueListenable: _formValidNotifier,
                    builder: (context, isValidForm, child) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: AppBigButton(
                              onPressed: () {
                                print(birthDateValidator.valid);
                              },
                              text: "Cadastrar-se",
                              color: isValidForm ? AppPrimaryColors.indigo : AppPrimaryColors.darkGrey,
                            ),
                          ),
                        ],
                      );
                    }
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