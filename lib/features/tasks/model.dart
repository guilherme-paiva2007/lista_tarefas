// ignore_for_file: prefer_final_fields

part of '../tasks.dart';

typedef TaskResult<T extends Task> = Result<T, List<StructureWarning>>;

enum TaskPriority with TitledEnum {
  low(FontAwesomeIcons.caretDown),
  medium(FontAwesomeIcons.circle),
  high(FontAwesomeIcons.caretUp),
  urgent(FontAwesomeIcons.exclamation);

  @override
  String get title => name;

  final IconData icon;

  const TaskPriority(this.icon);
}

abstract class Task with Model {
  DocumentSnapshot _snapshot;

  @override
  DocumentSnapshot get $snapshot => _snapshot;
  
  String _title;
  String? _description;
  Timestamp _createdAt;
  MaterialColor _color;
  IconData _icon;
  TaskPriority _priority;
  bool _favorite = false;

  String get title => _title;
  String? get description => _description;
  Timestamp get createdAt => _createdAt;
  MaterialColor get color => _color;
  IconData get icon => _icon;
  TaskPriority get priority => _priority;
  bool get favorite => _favorite;

  EventTypes get type;

  Task({
    required DocumentSnapshot snapshot,
    required String title,
    String? description,
    required Timestamp createdAt,
    required MaterialColor color,
    required IconData icon,
    required TaskPriority priority,
    required bool favorite,
  }): _title = title, _description = description, _createdAt = createdAt,
    _color = color, _icon = icon, _priority = priority, _favorite = favorite,
    _snapshot = snapshot
  {
    init();
    validate();
  }

  @mustCallSuper
  void validate() {}

  @override
  ModelWarningCollection<Task> get $warningCollection => _warningCollection;
  static final ModelWarningCollection<Task> _warningCollection = ModelWarningCollection<Task>();

  @override
  ModelInstanceCollection<Task> get $instanceCollection => _instanceCollection;
  static final ModelInstanceCollection<Task> _instanceCollection = ModelInstanceCollection<Task>();

  @override
  WarningList<Task> get $warnings => super.$warnings as WarningList<Task>;

  static TaskResult fromMap(DocumentSnapshot snap, Map<String, dynamic> map) {
    final type = EventTypes.fromTitle(map['type'] ?? "");
    
    switch (type) {
      case EventTypes.event:
        return EventTask._fromMap(snap, map);
      case EventTypes.toDoList:
        return ToDoListTask._fromMap(snap, map);
      case EventTypes.habit:
        return HabitTask._fromMap(snap, map);
      case EventTypes.recurring:
        return RecurringTask._fromMap(snap, map);
      case EventTypes.goal:
        return GoalTask._fromMap(snap, map);
      case EventTypes.reminder:
        return ReminderTask._fromMap(snap, map);
    }
  }
  
  Map<String, dynamic> toBaseMap() => {
    "title": _title,
    if (_description != null) "description": _description,
    "createdAt": _createdAt,
    "color": _colorsAssociation.fromAssociated(_color),
    "icon": _iconsAssociation.fromAssociated(_icon),
    "priority": _priorityAssociation.fromAssociated(_priority),
    "favorite": _favorite,
    "type": type.title,
  };

  static final _defaultMapVerifier = MapVerifier({
    "title": MapVerifierSimpleTypes.string,
    "description": MapVerifierSimpleTypes.stringNullable,
    "createdAt": MapVerifierSimpleTypes.timestamp,
    "color": _colorsAssociation,
    "icon": _iconsAssociation,
    "priority": _priorityAssociation,
    "favorite": MapVerifierSimpleTypes.boolean,
    "type": MapVerifierSimpleTypes.string,
  });

  static final Map<String, MaterialColor> colorsMap = Map.unmodifiable(<String, MaterialColor>{
    "purple": AppColors.purple,
    "indigo": AppColors.indigo,
    "blue": AppColors.blue,
    "aqua": AppColors.aqua,
    "green": AppColors.green,
    "lime": AppColors.lime,
    "gold": AppColors.gold,
    "orange": AppColors.orange,
    "red": AppColors.red,
  });

  static final Map<String, IconData> iconsMap = Map.unmodifiable(<String, IconData>{
    "social": FontAwesomeIcons.userGroup,
    "personal": FontAwesomeIcons.solidUser,
    "house": FontAwesomeIcons.house,
    "work": FontAwesomeIcons.briefcase,
    "meeting": FontAwesomeIcons.handshake,
    "project": FontAwesomeIcons.folderOpen,
    "clock": FontAwesomeIcons.solidClock,
    "study": FontAwesomeIcons.graduationCap,
    "reading": FontAwesomeIcons.book,
    "health": FontAwesomeIcons.stethoscope,
    "exercise": FontAwesomeIcons.dumbbell,
    "sport": FontAwesomeIcons.volleyball,
    "nature": FontAwesomeIcons.seedling,
    "money": FontAwesomeIcons.dollarSign,
    "shopping": FontAwesomeIcons.cartShopping,
    "investment": FontAwesomeIcons.chartLine,
    "cube": FontAwesomeIcons.cube,
    "home": FontAwesomeIcons.house,
    "cleaning": FontAwesomeIcons.broom,
    "cooking": FontAwesomeIcons.utensils,
    "paint": FontAwesomeIcons.paintbrush,
    "repair": FontAwesomeIcons.hammer,
    "travel": FontAwesomeIcons.plane,
    "suitcase": FontAwesomeIcons.suitcaseRolling,
    "car": FontAwesomeIcons.car,
    "flask": FontAwesomeIcons.flask,
    "tech": FontAwesomeIcons.laptop,
    "code": FontAwesomeIcons.code,
    "password": FontAwesomeIcons.lock,
    "cloud": FontAwesomeIcons.cloud,
    "fire": FontAwesomeIcons.fire,
    "droplet": FontAwesomeIcons.droplet,
    "weather": FontAwesomeIcons.cloudSun,
    "outdoors": FontAwesomeIcons.tree,
    "sun": FontAwesomeIcons.solidSun,
    "moon": FontAwesomeIcons.solidMoon,
    "entertainment": FontAwesomeIcons.film,
    "music": FontAwesomeIcons.music,
    "games": FontAwesomeIcons.gamepad,
    "photography": FontAwesomeIcons.camera,
    "email": FontAwesomeIcons.solidEnvelope,
    "call": FontAwesomeIcons.mobile,
    "message": FontAwesomeIcons.solidComment,
    "newsletter": FontAwesomeIcons.solidNewspaper,
    "birthday": FontAwesomeIcons.cakeCandles,
    "anniversary": FontAwesomeIcons.solidHeart,
    "calendar": FontAwesomeIcons.solidCalendar,
    "urgent": FontAwesomeIcons.triangleExclamation,
    "important": FontAwesomeIcons.solidStar,
    "reminder": FontAwesomeIcons.solidBell,
    "note": FontAwesomeIcons.solidNoteSticky,
  });

  static final _colorsAssociation = MapVerifierStringAssociated<MaterialColor>(colorsMap);
  static final _iconsAssociation = MapVerifierStringAssociated<IconData>(iconsMap);
  static final _priorityAssociation = MapVerifierStringAssociated<TaskPriority>(
    Map.fromEntries(TaskPriority.values.map((p) => MapEntry(p.title, p)))
  );
}

typedef TaskColorRecord = ({ String name, String displayName, MaterialColor color });
typedef TaskIconRecord = ({ String name, String displayName, IconData icon });

enum EventTaskStatus {
  upcoming,
  ongoing,
  past;
}

final class EventTask extends Task {
  Timestamp _startDate;
  Timestamp _endDate;

  Timestamp get startDate => _startDate;
  Timestamp get endDate => _endDate;

  Duration get duration => _endDate.toDate().difference(_startDate.toDate());

  bool get isToday {
    final now = DateTime.now();
    final start = _startDate.toDate();
    return start.year == now.year && start.month == now.month && start.day == now.day;
  }

  EventTaskStatus get status {
    final start = _startDate.toDate();
    final end = _endDate.toDate();
    final now = DateTime.now();

    if (start.isAfter(now)) return EventTaskStatus.upcoming;
    if (start.isBefore(now) && end.isAfter(now)) return EventTaskStatus.ongoing;
    return EventTaskStatus.past;
  }

  EventTask._({
    required super.snapshot,
    required super.title,
    required super.createdAt,
    required super.color,
    required super.icon,
    required super.priority,
    required super.favorite,
    required Timestamp startDate,
    required Timestamp endDate,
    super.description,
  }): _startDate = startDate, _endDate = endDate;

  @override
  void validate() {
    super.validate();
    final startAsDate = startDate.toDate();
    final endAsDate = endDate.toDate();
    if (startAsDate.isAfter(endAsDate)) {
      warn(const Warning(
        "Event start date must be before end date",
        WarningCodes.startDateAfterEndDate
      ));
    }
  }

  static TaskResult<EventTask> _fromMap(DocumentSnapshot snap, Map<String, dynamic> map) {
    final filtered = _mapVerifier.filter(map);
    if (filtered is Failure) return Failure(filtered.failure!);
    map = filtered.result!;
    return Success(
      EventTask._(
        snapshot: snap,
        title: map['title'],
        description: map['description'],
        createdAt: map['createdAt'],
        color: map['color'],
        icon: map['icon'],
        priority: map['priority'],
        startDate: map['startDate'],
        favorite: map['favorite'],
        endDate: map['endDate']
      )
    );
  }

  static final _mapVerifier = Task._defaultMapVerifier.extendFrom({
    "startDate": MapVerifierSimpleTypes.timestamp,
    "endDate": MapVerifierSimpleTypes.timestamp,
  });

  @override
  Map<String, dynamic> toMap() => {
    ...toBaseMap(),
    "startDate": _startDate,
    "endDate": _endDate,
  };

  @override
  EventTypes<EventTask> get type => EventTypes.event;
}

typedef ToDoListItem = ({ bool completed, String title, String? description });

final class ToDoListTask extends Task {
  List<ToDoListItem> _items;

  List<ToDoListItem> get items => List.unmodifiable(_items);

  int get length => _items.length;
  
  int get completedItems => _items.where((item) => item.completed).length;
  
  int get pendingItems => _items.where((item) => !item.completed).length;
  
  double get progress => length > 0 ? completedItems / length : 0.0;
  
  bool get isCompleted => length > 0 && completedItems == length;
  
  bool get isStarted => completedItems > 0;

  List<ToDoListItem> get completedList => _items.where((item) => item.completed).toList();
  
  List<ToDoListItem> get pendingList => _items.where((item) => !item.completed).toList();
  
  ToDoListItem? get nextPendingItem => (_items as List<ToDoListItem?>).firstWhere((item) => !item!.completed, orElse: () => null,);

  ToDoListTask._({
    required super.snapshot,
    required super.title,
    required super.createdAt,
    required super.color,
    required super.icon,
    required super.priority,
    required super.favorite,
    required List<ToDoListItem> items,
    super.description,
  }): _items = items;

  static TaskResult<ToDoListTask> _fromMap(DocumentSnapshot snap, Map<String, dynamic> map) {
    final filtered = _mapVerifier.filter(map);
    if (filtered is Failure) return Failure(filtered.failure!);
    map = filtered.result!;
    return Success(
      ToDoListTask._(
        snapshot: snap,
        title: map['title'],
        description: map['description'],
        createdAt: map['createdAt'],
        color: map['color'],
        icon: map['icon'],
        priority: map['priority'],
        favorite: map['favorite'],
        items: map['items'],
      )
    );
  }

  static final _mapVerifier = Task._defaultMapVerifier.extendFrom({
    "items": MapVerifierSubList(MapVerifierSubMap<ToDoListItem>(
      (map) => (
        completed: map["completed"],
        title: map["title"],
        description: map["description"],
      ),
      {
        "completed": MapVerifierSimpleTypes.boolean,
        "title": MapVerifierSimpleTypes.string,
        "description": MapVerifierSimpleTypes.stringNullable,
      }
    )),
  });

  @override
  Map<String, dynamic> toMap() => {
    ...toBaseMap(),
    "items": _items.map((item) => <String, dynamic>{
      "completed": item.completed,
      "title": item.title,
      if (item.description != null) "description": item.description,
    }).toList(),
  };

  @override
  EventTypes<ToDoListTask> get type => EventTypes.toDoList;
}

typedef HabitCompletionItem = ({ Timestamp date, String? note });

final class HabitTask extends Task {
  int _frequency;
  List<HabitCompletionItem> _completions;

  int get frequency => _frequency;
  List<HabitCompletionItem> get completions => List.unmodifiable(_completions);

  int get thisWeekCompletions {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    return _completions.where((completion) {
      final date = completion.date.toDate();
      return date.isAfter(startOfWeek) && date.isBefore(now);
    }).length;
  }
  
  int get last7DaysCompletions {
    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(Duration(days: 7));
    return _completions.where((completion) {
      final date = completion.date.toDate();
      return date.isAfter(sevenDaysAgo) && date.isBefore(now);
    }).length;
  }
  
  bool get completedToday {
    final today = DateTime.now();
    return _completions.any((completion) {
      final date = completion.date.toDate();
      return date.year == today.year && 
        date.month == today.month && 
        date.day == today.day;
    });
  }
  
  double get weeklyProgress => (thisWeekCompletions / _frequency).clamp(0.0, 1.0);
  
  double get last7DaysProgress => (last7DaysCompletions / _frequency).clamp(0.0, 1.0);

  HabitTask._({
    required super.snapshot,
    required super.title,
    required super.createdAt,
    required super.color,
    required super.icon,
    required super.favorite,
    required super.priority,
    required List<HabitCompletionItem> completions,
    required int frequency,
    super.description,
  }): _completions = completions, _frequency = frequency;

  @override
  void validate() {
    super.validate();
    if (frequency <= 0 || frequency > 7) {
      warn(const Warning(
        "Habit frequency must be between 1 and 7 days",
        WarningCodes.invalidHabitFrequencyRange
      ));
    }
  }

  static TaskResult<HabitTask> _fromMap(DocumentSnapshot snap, Map<String, dynamic> map) {
    final filtered = _mapVerifier.filter(map);
    if (filtered is Failure) return Failure(filtered.failure!);
    map = filtered.result!;
    return Success(
      HabitTask._(
        snapshot: snap,
        title: map['title'],
        description: map['description'],
        createdAt: map['createdAt'],
        color: map['color'],
        icon: map['icon'],
        priority: map['priority'],
        completions: map['completions'],
        favorite: map['favorite'],
        frequency: map['frequency'],
      )
    );
  }

  static final _mapVerifier = Task._defaultMapVerifier.extendFrom({
    "frequency": MapVerifierNumericTypes.integer,
    "completions": MapVerifierSubList(MapVerifierSubMap<HabitCompletionItem>(
      (map) => (
        date: map["date"],
        note: map["note"],
      ),
      {
        "date": MapVerifierSimpleTypes.timestamp,
        "note": MapVerifierSimpleTypes.stringNullable,
      }
    )),
  });

  @override
  Map<String, dynamic> toMap() => {
    ...toBaseMap(),
    "frequency": _frequency,
    "completions": _completions.map((completion) => <String, dynamic>{
      "date": completion.date,
      if (completion.note != null) "note": completion.note,
    }).toList(),
  };

  @override
  EventTypes<HabitTask> get type => EventTypes.habit;
}

typedef RecurringCompletionItem = ({ Timestamp date, String? note });

final class RecurringTask extends Task {
  DateDuration _interval;
  List<RecurringCompletionItem> _completions;
  Timestamp _nextOccurrence;

  DateDuration get interval => _interval;
  List<RecurringCompletionItem> get completions => List.unmodifiable(_completions);
  Timestamp get nextOccurrence => _nextOccurrence;

  Timestamp automaticNextOccurence() {
    final last = _completions.lastOrNull?.date.toDate() ?? _createdAt.toDate();
    return Timestamp.fromDate(_interval.copy(last));
  }

  bool get isDue => _nextOccurrence.toDate().isBefore(DateTime.now());
  
  bool get isOverdue => isDue;
  
  bool get isDueToday {
    final next = _nextOccurrence.toDate();
    final today = DateTime.now();
    return next.year == today.year && 
      next.month == today.month && 
      next.day == today.day;
  }
  
  Duration get timeUntilDue => _nextOccurrence.toDate().difference(DateTime.now());
  
  Duration get timeSinceDue {
    final diff = DateTime.now().difference(_nextOccurrence.toDate());
    return diff.isNegative ? Duration.zero : diff;
  }
  
  int get totalCompletions => _completions.length;
  
  RecurringCompletionItem? get lastCompletion => _completions.isNotEmpty ? _completions.last : null;

  RecurringTask._({
    required super.snapshot,
    required super.title,
    required super.createdAt,
    required super.color,
    required super.icon,
    required super.favorite,
    required super.priority,
    required DateDuration interval,
    required List<RecurringCompletionItem> completions,
    required Timestamp nextOccurrence,
    super.description,
  }): _interval = interval, _completions = completions, _nextOccurrence = nextOccurrence;

  @override
  void validate() {
    super.validate();
    if (interval case DateDurationRelative(
      duration: Duration(
        inDays: 0,
        inHours: 0,
        inMinutes: 0,
        inSeconds: 0,
        inMilliseconds: 0,
        inMicroseconds: 0
      )
    ) || DateDurationStatic(
      year: 0,
      month: 0,
      day: 0,
      hour: 0,
      minute: 0,
      second: 0,
      millisecond: 0,
      microsecond: 0,
    )) {
      warn(const Warning(
        "Recurring task interval must be greater than 0",
        WarningCodes.invalidRecurringInterval
      ));
    }
  }

  static TaskResult<RecurringTask> _fromMap(DocumentSnapshot snap, Map<String, dynamic> map) {
    final filtered = _mapVerifier.filter(map);
    if (filtered is Failure) return Failure(filtered.failure!);
    map = filtered.result!;
    return Success(
      RecurringTask._(
        snapshot: snap,
        title: map['title'],
        description: map['description'],
        createdAt: map['createdAt'],
        color: map['color'],
        icon: map['icon'],
        favorite: map['favorite'],
        priority: map['priority'],
        interval: map['interval'],
        completions: map['completions'],
        nextOccurrence: map['nextOccurrence'],
      )
    );
  }

  static final _mapVerifier = Task._defaultMapVerifier.extendFrom({
    "interval": DateDuration.mapVerifierType,
    "completions": MapVerifierSubList(MapVerifierSubMap<RecurringCompletionItem>(
      (map) => (
        date: map["date"],
        note: map["note"],
      ),
      {
        "date": MapVerifierSimpleTypes.timestamp,
        "note": MapVerifierSimpleTypes.stringNullable,
      }
    )),
    "nextOccurrence": MapVerifierSimpleTypes.timestamp,
  });

  @override
  Map<String, dynamic> toMap() => {
    ...toBaseMap(),
    "interval": _interval,
    "completions": _completions.map((completion) => <String, dynamic>{
      "date": completion.date,
      if (completion.note != null) "note": completion.note,
    }).toList(),
    "nextOccurrence": _nextOccurrence,
  };
  
  @override
  EventTypes<RecurringTask> get type => EventTypes.recurring;
}

typedef GoalInsertionItem = ({ Timestamp date, double value, String? note });

enum GoalTaskStatus {
  completed,
  overdue,
  inProgress,
  notStarted;
}

final class GoalTask extends Task {
  double _target;
  String _unit;
  List<GoalInsertionItem> _insertions;
  Timestamp? _date;

  double get target => _target;
  String get unit => _unit;
  List<GoalInsertionItem> get insertions => List.unmodifiable(_insertions);
  Timestamp? get date => _date;

  // ignore: avoid_types_as_parameter_names
  double get currentValue => _insertions.fold(0.0, (sum, item) => sum + item.value);
  
  double get progress => currentValue / _target;
  
  bool get isCompleted => currentValue >= _target;
  
  bool get isOverdue => _date != null && 
    _date!.toDate().isBefore(DateTime.now()) && 
    !isCompleted;

  GoalTaskStatus get status {
    if (isCompleted) return GoalTaskStatus.completed;
    if (isOverdue) return GoalTaskStatus.overdue;
    if (_date != null && _date!.toDate().isAfter(DateTime.now())) {
      return GoalTaskStatus.inProgress;
    }
    return GoalTaskStatus.notStarted;
  }

  GoalTask._({
    required super.snapshot,
    required super.title,
    required super.createdAt,
    required super.color,
    required super.icon,
    required super.favorite,
    required super.priority,
    required double target,
    required List<GoalInsertionItem> insertions,
    required String unit,
    Timestamp? date,
    super.description,
  }): _target = target, _insertions = insertions, _unit = unit, _date = date;

  @override
  void validate() {
    super.validate();
    if (_target <= 0) {
      warn(const Warning(
        "Goal target must be greater than 0",
        WarningCodes.invalidGoalTargetRange
      ));
    }
  }

  static TaskResult<GoalTask> _fromMap(DocumentSnapshot snap, Map<String, dynamic> map) {
    final filtered = _mapVerifier.filter(map);
    if (filtered is Failure) return Failure(filtered.failure!);
    map = filtered.result!;
    return Success(
      GoalTask._(
        snapshot: snap,
        title: map['title'],
        description: map['description'],
        createdAt: map['createdAt'],
        color: map['color'],
        icon: map['icon'],
        favorite: map['favorite'],
        priority: map['priority'],
        target: map['target'],
        insertions: map['insertions'],
        unit: map['unit'],
        date: map['date'],
      )
    );
  }

  static final _mapVerifier = Task._defaultMapVerifier.extendFrom({
    "target": MapVerifierNumericTypes.decimal,
    "unit": MapVerifierSimpleTypes.string,
    "insertions": MapVerifierSubList(MapVerifierSubMap<GoalInsertionItem>(
      (map) => (
        date: map["date"],
        value: map["value"],
        note: map["note"],
      ),
      {
        "date": MapVerifierSimpleTypes.timestamp,
        "value": MapVerifierNumericTypes.decimal,
        "note": MapVerifierSimpleTypes.stringNullable,
      }
    )),
    "date": MapVerifierSimpleTypes.timestampNullable,
  });
  
  @override
  Map<String, dynamic> toMap() => {
    ...toBaseMap(),
    "target": _target,
    "unit": _unit,
    "insertions": _insertions.map((insertion) => <String, dynamic>{
      "date": insertion.date,
      "value": insertion.value,
      if (insertion.note != null) "note": insertion.note,
    }).toList(),
    if (_date != null) "date": _date,
  };

  @override
  EventTypes<GoalTask> get type => EventTypes.goal;
}

enum ReminderTaskStatus {
  done,
  late,
  today,
  soon;
}

final class ReminderTask extends Task {
  Timestamp _date;
  bool _done;

  Timestamp get date => _date;
  bool get done => _done;

  bool get isDue => _date.toDate().isBefore(DateTime.now()) && !_done;
  
  bool get isDueToday {
    if (_done) return false;
    final due = _date.toDate();
    final today = DateTime.now();
    return due.year == today.year && 
      due.month == today.month && 
      due.day == today.day;
  }
  
  bool get isUpcoming => !_done && _date.toDate().isAfter(DateTime.now());
  
  Duration get timeUntilDue {
    if (_done) return Duration.zero;
    return _date.toDate().difference(DateTime.now());
  }
  
  Duration get timeSinceDue {
    if (_done || _date.toDate().isAfter(DateTime.now())) return Duration.zero;
    return DateTime.now().difference(_date.toDate());
  }

  ReminderTaskStatus get status {
    if (_done) return ReminderTaskStatus.done;
    final due = _date.toDate();
    final now = DateTime.now();
    
    if (due.isBefore(now)) return ReminderTaskStatus.late;
    if (due.year == now.year && due.month == now.month && due.day == now.day) {
      return ReminderTaskStatus.today;
    }
    
    return ReminderTaskStatus.soon;
  }

  ReminderTask._({
    required super.snapshot,
    required super.title,
    required super.createdAt,
    required super.color,
    required super.icon,
    required super.favorite,
    required super.priority,
    super.description,
    required Timestamp date,
    required bool done,
  }): _date = date, _done = done;

  static TaskResult<ReminderTask> _fromMap(DocumentSnapshot snap, Map<String, dynamic> map) {
    final filtered = _mapVerifier.filter(map);
    if (filtered is Failure) return Failure(filtered.failure!);
    map = filtered.result!;
    return Success(
      ReminderTask._(
        snapshot: snap,
        title: map['title'],
        description: map['description'],
        createdAt: map['createdAt'],
        color: map['color'],
        icon: map['icon'],
        favorite: map['favorite'],
        priority: map['priority'],
        date: map['date'],
        done: map['done'],
      )
    );
  }

  static final _mapVerifier = Task._defaultMapVerifier.extendFrom({
    "date": MapVerifierSimpleTypes.timestamp,
    "done": MapVerifierSimpleTypes.boolean,
  });

  @override
  Map<String, dynamic> toMap() => {
    ...toBaseMap(),
    "date": _date,
    "done": _done,
  };

  @override
  EventTypes<ReminderTask> get type => EventTypes.reminder;
}

enum EventTypes<T extends Task> with TitledEnum {
  event<EventTask>("event"),
  toDoList<ToDoListTask>("to-do-list"),
  habit<HabitTask>("habit"),
  recurring<RecurringTask>("recurring"),
  goal<GoalTask>("goal"),
  reminder<ReminderTask>("reminder");

  @override
  final String title;

  const EventTypes(this.title);

  static final Map<String, EventTypes> _map = Map.unmodifiable(
    Map.fromEntries(EventTypes.values.map((v) => MapEntry(v.title, v)))
  );

  static EventTypes fromTitle(String title) {
    final eventType = _map[title];
    if (eventType == null) throw Exception("Unknown event type title");
    return eventType;
  }
}