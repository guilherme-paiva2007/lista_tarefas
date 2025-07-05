import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lista_tarefas/core/constants/colors.dart';

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
          backgroundColor: AppPrimaryColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Theme(
              data: Theme.of(context).copyWith(
                colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: AppPrimaryColors.blue,
                  onPrimary: AppPrimaryColors.white,
                  onSurface: AppPrimaryColors.extraDarkGrey
                ),
              ),
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
    return GestureDetector(
      onTap: () {
        showDatePickerModal();
      },
      child: Container(
        decoration: BoxDecoration(
          // color: AppPrimaryColors.lightGrey,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: TextFormField(
            controller: _invisibleTextController,
            focusNode: widget.focusNode,
            enabled: false,
            keyboardType: TextInputType.datetime,
            style: TextStyle(
              color: AppPrimaryColors.extraDarkGrey,
            ),
            decoration: InputDecoration(
              label: widget.label != null ? Text(widget.label!, style: TextStyle(color: AppPrimaryColors.extraDarkGrey),) : null,
              suffixIcon: FaIcon(FontAwesomeIcons.calendar, size: 24, color: AppPrimaryColors.darkGrey,),
              floatingLabelBehavior: FloatingLabelBehavior.always,
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