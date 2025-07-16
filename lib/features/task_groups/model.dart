// ignore_for_file: prefer_final_fields

part of '../task_groups.dart';

final class TaskGroup with Model {
  @override
  DocumentSnapshot<Object?> get $snapshot => _snapshot;

  DocumentSnapshot _snapshot;

  String _name;
  Timestamp _createdAt;
  String? _description;

  String get name => _name;
  Timestamp get createdAt => _createdAt;
  String? get description => _description;
  
  

  TaskGroup({
    required DocumentSnapshot snapshot,
    required String name,
    required Timestamp createdAt,
    String? description,
  }): _snapshot = snapshot,
    _name = name,
    _createdAt = createdAt,
    _description = description
  {
    init();
  }
  
  @override
  ModelInstanceCollection<TaskGroup> get $instanceCollection => _instanceCollection;
  static final ModelInstanceCollection<TaskGroup> _instanceCollection = ModelInstanceCollection<TaskGroup>();

  @override
  ModelWarningCollection<TaskGroup> get $warningCollection => _warningCollection;
  static final ModelWarningCollection<TaskGroup> _warningCollection = ModelWarningCollection<TaskGroup>();

  @override
  WarningList<TaskGroup> get $warnings => super.$warnings as WarningList<TaskGroup>;

  static Result<TaskGroup, List<StructureWarning>> fromMap(DocumentSnapshot snap, Map<String, dynamic> map) {
    final filtered = _defaultMapVerifier.filter(map);
    if (filtered is Failure) return Failure(filtered.failure!);
    map = filtered.result!;
    return Success(
      TaskGroup(
        snapshot: snap,
        name: map['name'] as String,
        createdAt: map['createdAt'] as Timestamp,
        description: map['description'] as String?,
      )
    );
  }

  static final _defaultMapVerifier = MapVerifier({
    'name': MapVerifierSimpleTypes.string,
    'createdAt': MapVerifierSimpleTypes.timestamp,
    'description': MapVerifierSimpleTypes.stringNullable,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      "name": _name,
      "createdAt": _createdAt,
      "description": _description,
    };
  }
}