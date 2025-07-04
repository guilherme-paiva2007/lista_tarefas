import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lista_tarefas/core/constants/colors.dart';

class AppInput extends StatefulWidget {
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
  final void Function(String value, AppInputState state)? onChanged;
  final void Function(AppInputState state)? onTap;
  final void Function(AppInputState state)? onTapPrefixIcon;
  final void Function(AppInputState state)? onTapSuffixIcon;
  final String? label;
  final IconData? prefixIcon;
  final IconData? suffixIcon;

  final InputValidatorController? validator;
  
  const AppInput({
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
  State<AppInput> createState() => AppInputState();
}

class AppInputState extends State<AppInput> {
  late bool autocorrect;
  late bool autofocus;
  late final TextEditingController controller;
  late bool enabled;
  late final FocusNode focusNode;
  late List<TextInputFormatter> inputFormatters;
  late TextInputType? keyboardType;
  late bool enableSuggestions;
  late int? maxLength;
  late int? maxLines;
  late int? minLines;
  late bool obscureText;
  late final void Function(String value, AppInputState state)? onChanged;
  late final void Function(AppInputState state)? onTap;
  late final void Function(AppInputState state)? onTapPrefixIcon;
  late final void Function(AppInputState state)? onTapSuffixIcon;
  late String? label;
  late IconData? prefixIcon;
  late IconData? suffixIcon;
  late final InputValidatorController validator;

  @override
  void initState() {
    super.initState();

    autocorrect = widget.autocorrect;
    autofocus = widget.autofocus;
    controller = widget.controller;
    enabled = widget.enabled;
    focusNode = widget.focusNode;
    inputFormatters = widget.inputFormatters;
    keyboardType = widget.keyboardType;
    enableSuggestions = widget.enableSuggestions;
    maxLength = widget.maxLength;
    maxLines = widget.maxLines;
    minLines = widget.minLines;
    obscureText = widget.obscureText;
    onChanged = widget.onChanged;
    onTapPrefixIcon = widget.onTapPrefixIcon;
    onTapSuffixIcon = widget.onTapSuffixIcon;
    onTap = widget.onTap;
    label = widget.label;
    prefixIcon = widget.prefixIcon;
    suffixIcon = widget.suffixIcon;
    validator = widget.validator ?? InputValidatorController((_) => null, controller);
  }

  @override
  Widget build(BuildContext context) {
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
            onChanged?.call(value, this);
            setState(() {});
          },
          onTap: () => onTap?.call(this),
          cursorColor: AppPrimaryColors.extraDarkGrey,
          validator: (value) {
            final error = validator._runValidator(value ?? "");
            return error;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            label: label != null ? Text(label!, style: TextStyle(color: AppPrimaryColors.extraDarkGrey),) : null,
            prefixIcon: prefixIcon != null ? GestureDetector(
              onTap: () => onTapPrefixIcon?.call(this),
              child: FaIcon(prefixIcon, size: 24, color: AppPrimaryColors.darkGrey,),
            ) : null,
            suffixIcon: suffixIcon != null ? GestureDetector(
              onTap: () => onTapSuffixIcon?.call(this),
              child: FaIcon(suffixIcon, size: 24, color: AppPrimaryColors.darkGrey,),
            ) : null,
            suffixIconConstraints: BoxConstraints(maxHeight: 24, minWidth: 40),
            prefixIconConstraints: BoxConstraints(maxHeight: 24, minWidth: 40),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
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

class InputValidatorController {
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

  InputValidatorController(this.validator, this.controller);
}