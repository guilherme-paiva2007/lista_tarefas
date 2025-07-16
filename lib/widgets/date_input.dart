import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lista_tarefas/core/constants/colors.dart';
import 'package:lista_tarefas/core/constants/dimensions.dart';

class AppDateInput extends StatefulWidget {
  final DateInputController controller;
  final bool enabled;
  final FocusNode focusNode;
  final String? label;
  final DateInputValidatorController validator;

  const AppDateInput({
    super.key,
    required this.controller,
    this.enabled = true,
    required this.focusNode,
    this.label,
    required this.validator,
  });

  @override
  State<AppDateInput> createState() => _AppDateInputState();
}

class _AppDateInputState extends State<AppDateInput> {
  final TextEditingController _invisibleTextController = TextEditingController(text: "dd/mm/yyyy");

  @override
  void initState() {
    super.initState();
  }

  Future<void> showDatePickerModal() async {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          // backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: AppBorderRadius.big,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Theme(
              data: Theme.of(context),
              child: CalendarDatePicker(
                initialDate: widget.controller.date ?? DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                onDateChanged: (date) {
                  widget.controller.date = date;
                  widget.validator._runValidator(date);
                  setState(() {
                    _invisibleTextController.text = "${date.day.toString().padLeft(2, "0")}/${date.month.toString().padLeft(2, "0")}/${date.year.toString().padLeft(4, "0")}";
                  });
                }
              ),
            ),
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {
        showDatePickerModal();
      },
      child: Container(
        decoration: BoxDecoration(
          // color: AppColors.lightGrey,
          borderRadius: AppBorderRadius.big,
        ),
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: TextFormField(
            controller: _invisibleTextController,
            focusNode: widget.focusNode,
            enabled: false,
            keyboardType: TextInputType.datetime,
            style: TextStyle(
              color: colorScheme.onSurface,
            ),
            decoration: InputDecoration(
              label: widget.label != null ? Text(widget.label!) : null,
              suffixIcon: FaIcon(FontAwesomeIcons.calendar, size: 24, color: colorScheme.outline,),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIconConstraints: const BoxConstraints(maxHeight: 24, minWidth: 40),
              prefixIconConstraints: const BoxConstraints(maxHeight: 24, minWidth: 40),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              filled: true,
              fillColor: colorScheme.outline,
              hoverColor: Colors.transparent,
              border: OutlineInputBorder(
                borderRadius: AppBorderRadius.medium,
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: AppBorderRadius.medium,
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: AppBorderRadius.medium,
                // borderSide: BorderSide.none,
                borderSide: BorderSide(color: colorScheme.surfaceContainer),
              ),
                errorBorder: OutlineInputBorder(
                borderRadius: AppBorderRadius.medium,
                borderSide: BorderSide(color: AppColors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: AppBorderRadius.medium,
                borderSide: BorderSide(color: AppColors.red),
              ),
              errorStyle: TextStyle(
                color: AppColors.red,
                fontSize: 12,
              ),
              errorMaxLines: 1,
            ),
          ),
        ),
      ),
    );
  }
}

class DateInputController {
  DateTime? _date;
  DateTime? get date => _date;
  set date(DateTime? value) {
    _date = value;
    for (var listener in _listeners) {
      listener();
    }
  }

  final List<void Function()> _listeners = [];

  void addListener(void Function() callback) => _listeners.add(callback);
}

class DateInputValidatorController {
  final String? Function(DateTime? value) validator;
  final DateInputController controller;

  late String? _cacheValidatorV;
  bool _cacheValidatorVInited = false;
  String? get _cacheValidator {
    if (!_cacheValidatorVInited) {
      _cacheValidatorVInited = true;
      return _runValidator(DateTime.now());
    } else {
      return _cacheValidatorV;
    }
  }

  String? _runValidator(DateTime _) {
    _cacheValidatorV = validator(controller.date);
    return _cacheValidator;
  }

  bool get valid => _cacheValidator == null;
  String? get error => _cacheValidator;

  DateInputValidatorController(this.validator, this.controller);
}