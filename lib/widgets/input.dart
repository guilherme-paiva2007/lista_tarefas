import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lista_tarefas/core/constants/colors.dart';

class AppTextInput extends StatelessWidget {
  final bool autocorrect;
  final bool autofocus;
  final TextEditingController controller;
  final bool enabled;
  final FocusNode focusNode;
  final List<TextInputFormatter> inputFormatters;
  final TextInputType? keyboardType;
  final bool enableSuggestions;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final bool obscureText;
  final void Function(String value)? onChanged;
  final void Function()? onTap;
  final void Function()? onTapPrefixIcon;
  final void Function()? onTapSuffixIcon;
  final String? label;
  final IconData? prefixIcon;
  final IconData? suffixIcon;

  final TextInputValidatorController? validator;
  
  const AppTextInput({
    super.key,
    this.autocorrect = true,
    this.autofocus = false,
    required this.controller,
    this.enableSuggestions = true,
    this.enabled = true,
    required this.focusNode,
    this.inputFormatters = const [],
    this.keyboardType,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.obscureText = false,
    this.onChanged,
    this.onTap,
    this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.onTapPrefixIcon,
    this.onTapSuffixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final validator = this.validator ?? TextInputValidatorController((_) => null, controller);
    return Container(
      decoration: BoxDecoration(
        // color: AppPrimaryColors.lightGrey,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: TextFormField(
          autocorrect: autocorrect,
          autofocus: autofocus,
          controller: controller,
          enabled: enabled,
          focusNode: focusNode,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          enableSuggestions: enableSuggestions,
          maxLength: maxLength,
          maxLines: maxLines,
          minLines: minLines,
          obscureText: obscureText,
          onChanged: (value) {
            onChanged?.call(value);
          },
          onTap: () => onTap?.call(),
          cursorColor: AppPrimaryColors.extraDarkGrey,
          validator: (value) {
            final error = validator._runValidator(value ?? "");
            return error;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            label: label != null ? Text(label!, style: TextStyle(color: AppPrimaryColors.extraDarkGrey),) : null,
            prefixIcon: prefixIcon != null ? GestureDetector(
              onTap: () => onTapPrefixIcon?.call(),
              child: FaIcon(prefixIcon, size: 24, color: AppPrimaryColors.darkGrey,),
            ) : null,
            suffixIcon: suffixIcon != null ? GestureDetector(
              onTap: () => onTapSuffixIcon?.call(),
              child: FaIcon(suffixIcon, size: 24, color: AppPrimaryColors.darkGrey,),
            ) : null,
            suffixIconConstraints: const BoxConstraints(maxHeight: 24, minWidth: 40),
            prefixIconConstraints: const BoxConstraints(maxHeight: 24, minWidth: 40),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            filled: true,
            fillColor: AppPrimaryColors.lightGrey,
            hoverColor: Colors.transparent,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              // borderSide: BorderSide.none,
              borderSide: BorderSide(color: AppPrimaryColors.grey),
            ),
              errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: AppSecondaryColors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: AppSecondaryColors.red),
            ),
            errorStyle: TextStyle(
              color: AppSecondaryColors.red,
              fontSize: 12,
            ),
            errorMaxLines: 1,
          ),
        ),
      ),
    );
  }
}

class TextInputValidatorController {
  final String? Function(String? value) validator;
  final TextEditingController controller;

  late String? _cacheValidatorV;
  bool _cacheValidatorVInited = false;
  String? get _cacheValidator {
    if (!_cacheValidatorVInited) {
      _cacheValidatorVInited = true;
      return _runValidator("");
    } else {
      return _cacheValidatorV;
    }
  }

  String? _runValidator(String _) {
    _cacheValidatorV = validator(controller.text);
    return _cacheValidator;
  }

  bool get valid => _cacheValidator != null ? false : true;
  String? get error => _cacheValidator;

  TextInputValidatorController(this.validator, this.controller);
}

class SecretInputController {
  bool _obscure;
  IconData _icon;

  bool get obscure => _obscure;
  IconData get icon => _icon;

  void toggle() {
    _obscure = !_obscure;
    _icon = _possibleValues[_obscure]!;
  }

  SecretInputController([bool initialValue = true]): _obscure = initialValue, _icon = _possibleValues[initialValue]!;

  static final Map<bool, IconData> _possibleValues = {
    true: FontAwesomeIcons.eyeSlash,
    false: FontAwesomeIcons.eye,
  };
}