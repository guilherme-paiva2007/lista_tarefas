import 'package:lista_tarefas/core/utils/map_verifier.dart';

sealed class DateDuration {
  final int? year;
  final int? month;
  final int? day;
  final int? hour;
  final int? minute;
  final int? second;
  final int? millisecond;
  final int? microsecond;

  const DateDuration._({
    this.year,
    this.month,
    this.day,
    this.hour,
    this.minute,
    this.second,
    this.millisecond,
    this.microsecond,
  });

  DateTime copy(DateTime date);

  static final MapVerifierSubMap<DateDuration> mapVerifierType = MapVerifierSubMap(
    (map) => switch (map['type'] as Type) {
      // ignore: type_literal_in_constant_pattern
      DateDurationStatic => DateDurationStatic(
        year: map['year'],
        month: map['month'],
        day: map['day'],
        hour: map['hour'],
        minute: map['minute'],
        second: map['second'],
        millisecond: map['millisecond'],
        microsecond: map['microsecond'],
      ),
      // ignore: type_literal_in_constant_pattern
      DateDurationRelative => DateDurationRelative(
        duration: Duration(
          days: map['day'],
          hours: map['hour'],
          minutes: map['minute'],
          seconds: map['second'],
          milliseconds: map['millisecond'],
          microseconds: map['microsecond'],
        ),
      ),
      _ => throw Exception("Invalid DateDuration type: ${map['type']}"),
    },
    {
      "type": enumVerifierType,
      "year": MapVerifierNumericTypes.integerNullable,
      "month": MapVerifierNumericTypes.integerNullable,
      "day": MapVerifierNumericTypes.integerNullable,
      "hour": MapVerifierNumericTypes.integerNullable,
      "minute": MapVerifierNumericTypes.integerNullable,
      "second": MapVerifierNumericTypes.integerNullable,
      "millisecond": MapVerifierNumericTypes.integerNullable,
      "microsecond": MapVerifierNumericTypes.integerNullable,
    }
  );

  static final MapVerifierStringAssociated<Type> enumVerifierType = MapVerifierStringAssociated({
    "static": DateDurationStatic,
    "relative": DateDurationRelative,
  });

  Map<String, dynamic> toMap() => {
    "type": switch (this) {
      DateDurationStatic _ => "static",
      DateDurationRelative _ => "relative",
    },
    "year": year,
    "month": month,
    "day": day,
    "hour": hour,
    "minute": minute,
    "second": second,
    "millisecond": millisecond,
    "microsecond": microsecond,
  };
}

final class DateDurationStatic extends DateDuration {
  const DateDurationStatic({
    super.year,
    super.month,
    super.day,
    super.hour,
    super.minute,
    super.second,
    super.millisecond,
    super.microsecond,
  }): super._();

  @override
  copy(DateTime date) => date.copyWith(
    year: year,
    month: month,
    day: day,
    hour: hour,
    minute: minute,
    second: second,
    millisecond: millisecond,
    microsecond: microsecond,
  );
}

final class DateDurationRelative extends DateDuration {
  @override
  int? get day => duration.inDays.remainder(365);
  @override
  int? get hour => duration.inHours.remainder(24);
  @override
  int? get minute => duration.inMinutes.remainder(60);
  @override
  int? get second => duration.inSeconds.remainder(60);
  @override
  int? get millisecond => duration.inMilliseconds.remainder(1000);
  @override
  int? get microsecond => duration.inMicroseconds.remainder(1000);

  final Duration duration;
  
  const DateDurationRelative({
    required this.duration,
  }): super._();

  @override
  DateTime copy(DateTime date) => date.add(duration);
}