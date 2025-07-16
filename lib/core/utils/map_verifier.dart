import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lista_tarefas/core/utils/result.dart';

typedef JSONMap = Map<String, dynamic>;

abstract class StructureWarning {
  final String field;

  StructureWarning._({
    required this.field
  }) {
    _instances[hashCode] = this;
  }

  static final Map<int, StructureWarning> _instances = {};
}

final class TypeStructureWarning extends StructureWarning {
  final Type expectedType;

  TypeStructureWarning._({
    required super.field,
    required this.expectedType,
  }): super._();

  factory TypeStructureWarning({
    required String field,
    required Type expectedType
  }) {
    final instance = StructureWarning._instances[
      Object.hash(TypeStructureWarning, field, expectedType)
    ];
    if (instance == null) {
      return TypeStructureWarning._(field: field, expectedType: expectedType);
    } else {
      return instance as TypeStructureWarning;
    }
  }

  @override
  int get hashCode => Object.hash(TypeStructureWarning, field, expectedType);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TypeStructureWarning) return false;
    return field == other.field && expectedType == other.expectedType;
  }
}

final class MissingStructureWarning extends StructureWarning {
  MissingStructureWarning._({
    required super.field,
  }): super._();

  factory MissingStructureWarning({
    required String field
  }) {
    final instance = StructureWarning._instances[
      Object.hash(MissingStructureWarning, field)
    ];
    if (instance == null) {
      return MissingStructureWarning._(field: field);
    } else {
      return instance as MissingStructureWarning;
    }
  }

  @override
  int get hashCode => Object.hash(MissingStructureWarning, field);
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MissingStructureWarning) return false;
    return field == other.field;
  }
}

final class ExtraFieldStructureWarning extends StructureWarning {
  ExtraFieldStructureWarning._({
    required super.field,
  }) : super._();

  factory ExtraFieldStructureWarning({
    required String field,
  }) {
    final instance = StructureWarning._instances[
      Object.hash(ExtraFieldStructureWarning, field)
    ];
    if (instance == null) {
      return ExtraFieldStructureWarning._(field: field);
    } else {
      return instance as ExtraFieldStructureWarning;
    }
  }

  @override
  int get hashCode => Object.hash(ExtraFieldStructureWarning, field);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ExtraFieldStructureWarning) return false;
    return field == other.field;
  }
}

class MapVerifier {
  final Map<String, MapVerifierType> requiredFields;

  const MapVerifier(this.requiredFields);

  List<StructureWarning> validate(JSONMap map) {
    final List<StructureWarning> warnings = [];
    final Set<String> validatedFields = {};
    for (var MapEntry(key: fieldName, value: verifier) in requiredFields.entries) {
      if (!map.containsKey(fieldName)) {
        if (verifier is! MapVerifierBlankableType) {
          warnings.add(MissingStructureWarning(field: fieldName));
        }
        continue;
      }
      final dynamic value = map[fieldName];
      if (!verifier.check(value)) {
        warnings.add(TypeStructureWarning(
          field: fieldName,
          expectedType: verifier._Ttype
        ));
        continue;
      }
      validatedFields.add(fieldName);
    }
    for (var key in map.keys) {
      if (!validatedFields.contains(key)) {
        warnings.add(ExtraFieldStructureWarning(field: key));
      }
    }
    return warnings;
  }

  Result<JSONMap, List<StructureWarning>> filter(JSONMap map) {
    final Map<String, dynamic> filtered = {};
    final List<StructureWarning> warnings = [];
    final Set<String> validatedFields = {};
    for (var MapEntry(key: fieldName, value: verifier) in requiredFields.entries) {
      validatedFields.add(fieldName);
      if (!map.containsKey(fieldName)) {
        if (verifier is! MapVerifierBlankableType) {
          warnings.add(MissingStructureWarning(field: fieldName));
        }
        continue;
      }
      final dynamic value = map[fieldName];
      if (!verifier.check(value)) {
        warnings.add(TypeStructureWarning(
          field: fieldName,
          expectedType: verifier._Ttype
        ));
        continue;
      }
      filtered[fieldName] = verifier.get(value);
    }
    for (var key in map.keys) {
      if (!validatedFields.contains(key)) {
        warnings.add(ExtraFieldStructureWarning(field: key));
      }
    }
    return warnings.isEmpty ? Success(filtered) : Failure(warnings);
  }

  MapVerifier extendFrom(Map<String, MapVerifierType> requiredFields) {
    return MapVerifier({
      ...this.requiredFields,
      ...requiredFields,
    });
  }

  factory MapVerifier.merge(Iterable<MapVerifier> verifiers) {
    final requiredFields = <String, MapVerifierType>{};

    for (var verifier in verifiers) {
      requiredFields.addAll(verifier.requiredFields);
    }

    return MapVerifier(requiredFields);
  }
}

abstract mixin class MapVerifierType<T> {
  // ignore: non_constant_identifier_names
  Type get _Ttype => T;

  bool check(dynamic value);

  T get(dynamic value);
}

/// Wrap around if field doesn't need to exist.
final class MapVerifierBlankableType<T> with MapVerifierType<T> {
  final MapVerifierType<T> _verifier;

  MapVerifierBlankableType(this._verifier) {
    if (_verifier is MapVerifierBlankableType) {
      throw Exception("Cannot nest MapVerifierBlankableType");
    }
  }

  @override
  bool check(dynamic value) => _verifier.check(value);

  @override
  T get(dynamic value) => _verifier.get(value);
}

enum MapVerifierSimpleTypes<T> with MapVerifierType<T> {
  string<String>(),
  boolean<bool>(),
  /// for fix structure, use [MapVerifierSubList]
  list<List<dynamic>>(),
  /// for fix structure, use [MapVerifierSubMap]
  map<JSONMap>(),
  timestamp<Timestamp>(),
  blank<Null>(),
  geopoint<GeoPoint>(),
  reference<DocumentReference>(),
  stringNullable<String?>(),
  booleanNullable<bool?>(),
  /// for fix structure, use [MapVerifierSubList]
  listNullable<List<dynamic>?>(),
  /// for fix structure, use [MapVerifierSubMap]
  mapNullable<JSONMap?>(),
  timestampNullable<Timestamp?>(),
  geopointNullable<GeoPoint?>(),
  referenceNullable<DocumentReference?>();

  const MapVerifierSimpleTypes();

  @override
  bool check(dynamic value) => value is T;

  @override
  T get(dynamic value) => value as T;
}

enum MapVerifierNumericTypes<T extends num?> with MapVerifierType<T> {
  integer<int>(),
  decimal<double>(true),
  integerNullable<int?>(),
  decimalNullable<double?>(true);

  final bool intFallback;

  const MapVerifierNumericTypes([ this.intFallback = false ]);

  @override
  bool check(dynamic value) => value is T || (value is int && intFallback);

  @override
  T get(dynamic value) {
    if (value is T) return value;
    if (value is int && intFallback) return value.toDouble() as T;
    throw Exception("Couldn't convert $value to $T");
  }
}

class MapVerifierSubMap<T extends Object> extends MapVerifier with MapVerifierType<T> {
  final T Function(JSONMap map) mapToRecord;
  
  const MapVerifierSubMap(this.mapToRecord, super.requiredFields);

  @override
  bool check(value) {
    if (value is! JSONMap) return false;
    if (validate(value).isNotEmpty) return false;
    return true;
  }

  @override
  T get(value) {
    if (value is! JSONMap) throw Exception("Expected a Map<String, dynamic> for sub-map");
    final filtered = filter(value);
    if (filtered is Failure) {
      throw Exception("Validation failed: ${filtered.failure}");
    }
    return mapToRecord(filtered.result!);
  }
}

class MapVerifierSubMapNullable<T extends Object> extends MapVerifier with MapVerifierType<T?> {
  final T Function(JSONMap map) mapToRecord;
  
  const MapVerifierSubMapNullable(this.mapToRecord, super.requiredFields);

  @override
  bool check(value) {
    if (value == null) return true;
    if (value is! JSONMap) return false;
    if (validate(value).isNotEmpty) return false;
    return true;
  }

  @override
  T? get(value) {
    if (value == null) return null;
    if (value is! JSONMap) throw Exception("Expected a Map<String, dynamic> for sub-map");
    final filtered = filter(value);
    if (filtered is Failure) {
      throw Exception("Validation failed: ${filtered.failure}");
    }
    return mapToRecord(filtered.result!);
  }
}

class MapVerifierSubList<T> with MapVerifierType<List<T>> {
  final MapVerifierType<T> type;

  const MapVerifierSubList(this.type);

  @override
  bool check(value) {
    if (value is! List<dynamic>) return false;
    for (var element in value) {
      if (!type.check(element)) return false;
    }
    return true;
  }

  @override
  List<T> get(value) {
    final List<T> newList = [];
    if (value is! List<dynamic>) throw Exception("Expected a List<dynamic> for sub-list");
    for (var element in value) {
      newList.add(type.get(element));
    }
    return newList;
  }
}

class MapVerifierSubListNullable<T> with MapVerifierType<List<T>?> {
  final MapVerifierType<T> type;

  const MapVerifierSubListNullable(this.type);

  @override
  bool check(value) {
    if (value == null) return true;
    if (value is! List<dynamic>) return false;
    for (var element in value) {
      if (!type.check(element)) return false;
    }
    return true;
  }

  @override
  List<T>? get(value) {
    if (value == null) return null;
    final List<T> newList = [];
    if (value is! List<dynamic>) throw Exception("Expected a List<dynamic> for sub-list");
    for (var element in value) {
      newList.add(type.get(element));
    }
    return newList;
  }
}

class MapVerifierStringAssociated<T> with MapVerifierType<T> {
  final Map<String, T> associations;

  MapVerifierStringAssociated(this.associations);

  @override
  bool check(value) {
    if (value is! String) return false;
    return associations.containsKey(value);
  }

  @override
  T get(value) {
    if (value is! String) throw Exception("Expected a String for associated value");
    for (var MapEntry(key: string, value: association) in associations.entries) {
      if (value == string) return association;
    }
    throw Exception("No association found for value: $value");
  }

  String fromAssociated(T value) {
    for (var MapEntry(key: string, value: association) in associations.entries) {
      if (value == association) return string;
    }
    throw Exception("No associated string found for value: $value");
  }
}