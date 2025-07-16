// ignore_for_file: prefer_final_fields

part of '../users.dart';

final class User with Model {
  DocumentSnapshot _snapshot;

  @override
  DocumentSnapshot get $snapshot => _snapshot;
  
  final String _name;
  final String _email;
  final Timestamp _birthDate;
  final Timestamp _createdAt;

  String get name => _name;
  String get email => _email;
  Timestamp get birthDate => _birthDate;
  Timestamp get createdAt => _createdAt;

  int get age {
    final now = DateTime.now();
    final birth = _birthDate.toDate();
    int age = now.year - birth.year;
    
    if (
      now.month < birth.month || 
      (now.month == birth.month && now.day < birth.day)
    ) {
      age--;
    }
    
    return age;
  }

  static final RegExp _wordRegExp = RegExp(r'\s+');

  String get initials {
    if (_name.isEmpty) return '';
    final words = _name.trim().split(_wordRegExp);
    if (words.length == 1) {
      return words[0].substring(0, 1).toUpperCase();
    }
    return '${words.first.substring(0, 1)}${words.last.substring(0, 1)}'.toUpperCase();
  }

  String get firstName {
    final words = _name.trim().split(_wordRegExp);
    return words.isNotEmpty ? words.first : '';
  }

  String get lastName {
    final words = _name.trim().split(_wordRegExp);
    return words.length > 1 ? words.last : '';
  }

  bool get isBirthdayToday {
    final now = DateTime.now();
    final birth = _birthDate.toDate();
    return now.month == birth.month && now.day == birth.day;
  }

  Duration get timeSinceCreated => DateTime.now().difference(_createdAt.toDate());

  User._({
    required DocumentSnapshot snapshot,
    required String name,
    required String email,
    required Timestamp birthDate,
    required Timestamp createdAt,
  }) : _name = name, _email = email, _birthDate = birthDate,
    _createdAt = createdAt, _snapshot = snapshot
  {
    init();
  }

  @override
  ModelWarningCollection<Model> get $warningCollection => _warningCollection;
  static final ModelWarningCollection<User> _warningCollection = ModelWarningCollection<User>();

  @override
  ModelInstanceCollection<Model> get $instanceCollection => _instanceCollection;
  static final ModelInstanceCollection<User> _instanceCollection = ModelInstanceCollection<User>();

  @override
  WarningList<User> get $warnings => super.$warnings as WarningList<User>;

  static Result<User, List<StructureWarning>> fromMap(DocumentSnapshot snap, Map<String, dynamic> map) {
    final filtered = _defaultMapVerifier.filter(map);
    if (filtered is Failure) return Failure(filtered.failure!);
    map = filtered.result!;
    return Success(
      User._(
        snapshot: snap,
        name: map['name'] as String,
        email: map['email'] as String,
        birthDate: map['birthDate'] as Timestamp,
        createdAt: map['createdAt'] as Timestamp,
      )
    );
  }

  @override
  Map<String, dynamic> toMap() => {
    "name": _name,
    "email": _email,
    "birthDate": _birthDate,
    "createdAt": _createdAt,
  };

  @override
  String toString() => 'User($_name - ${$snapshot.id})';

  static final MapVerifier _defaultMapVerifier = MapVerifier({
    'name': MapVerifierSimpleTypes.string,
    'email': MapVerifierSimpleTypes.string,
    'birthDate': MapVerifierSimpleTypes.timestamp,
    'createdAt': MapVerifierSimpleTypes.timestamp,
  });
}