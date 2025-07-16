part of 'model.dart';

enum WarningCodes {
  // Tasks
  unknownTaskIcon,
  unknownTaskColor,
  startDateAfterEndDate,
  invalidHabitFrequencyRange,
  invalidRecurringInterval,
  invalidGoalTargetRange,
}

final class Warning {
  final String warn;
  final WarningCodes code;

  const Warning(this.warn, this.code);
}

mixin WarningListener<W extends StatefulWidget> on State<W> {
  // TODO: warning listener mixin
}

class ModelWarningCollection<T extends Model> with Iterable<WarningList<T>> {
  final Map<T, WarningList<T>> _map = {};

  ModelWarningCollection._() {
    _instances[T] = this;
  }

  factory ModelWarningCollection() {
    final instance = _instances[T];
    if (instance != null) {
      return instance as ModelWarningCollection<T>;
    }
    return ModelWarningCollection<T>._();
  }

  WarningList<T> operator [](T model) {
    final list = _map[model];
    if (list != null) {
      return list;
    } else {
      final WarningList<T> newList = WarningList<T>();
      _map[model] = newList;
      return newList;
    }
  }

  @override
  Iterator<WarningList<T>> get iterator => _map.values.iterator;

  @override
  bool operator ==(Object other) => other is ModelWarningCollection<T>;
  
  @override
  int get hashCode => T.hashCode;

  static final Map<Type, ModelWarningCollection> _instances = {};
}

final class WarningList<T extends Model> extends Iterable<Warning> {
  final Set<Warning> _set = {};

  WarningList();

  @override
  get iterator => _set.iterator;

  void add(Warning warning) {
    // TODO: juntar ao listener
    _set.add(warning);
  }

  void remove(Warning warning) {
    // TODO: juntar ao listener
    _set.remove(warning);
  }

  void clear() {
    for (var warning in this) {
      remove(warning);
    }
  }
}