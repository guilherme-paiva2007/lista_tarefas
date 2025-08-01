import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

part 'warning.dart';

final class ModelInstanceCollection<T extends Model> extends Iterable<T> {
  final Map<DocumentReference, T> _map = {};

  ModelInstanceCollection._() {
    _instances[T] = this;
  }

  factory ModelInstanceCollection() {
    if (T == Model) throw Exception("Cannot create ModelInstanceCollection for Model type");
    final instance = _instances[T];
    if (instance != null) {
      return instance as ModelInstanceCollection<T>;
    }
    return ModelInstanceCollection<T>._();
  }

  T? operator [](DocumentReference ref) => _map[ref];

  void _set(T instance) {
    if (_map.containsKey(instance.$ref)) throw Exception("Document already exists");
    _map[instance.$ref] = instance;
  }

  void _remove(DocumentReference ref) {
    if (!_map.containsKey(ref)) throw Exception("Document does not exist");
    _map.remove(ref);
  }

  @override
  Iterator<T> get iterator => ModelInstanceCollectionIterator<T>(this);

  static final Map<Type, ModelInstanceCollection> _instances = {};
}

final class ModelInstanceCollectionIterator<T extends Model> implements Iterator<T> {
  final Iterator<T> _iterator;

  ModelInstanceCollectionIterator(ModelInstanceCollection<T> collection) : _iterator = collection._map.values.iterator;

  @override
  T get current => _iterator.current;

  @override
  bool moveNext() => _iterator.moveNext();
}

mixin Model {
  DocumentSnapshot get $snapshot;
  
  DocumentReference get $ref => $snapshot.reference;
  String get $id => $snapshot.id;

  bool _inited = false;
  bool _disposed = false;

  bool get $inited => _inited;
  bool get $disposed => _disposed;

  /// Required to get the warning collection to this type
  /// 
  /// Starts with `$` to not merge with the default properties
  /// 
  /// Make sure that the collection type matches the class
  ModelWarningCollection get $warningCollection;
  
  /// Required to get the instance collection to this type
  /// 
  /// Starts with `$` to not merge with the default properties
  /// 
  /// Make sure that the collection type matches the class
  ModelInstanceCollection get $instanceCollection;

  /// Can be cast as WarningList of the type of the model
  /// 
  /// Can be overrided changing the return type
  WarningList get $warnings {
    return $warningCollection[this];
  }

  /// Store warning about this instance
  void warn(Warning warning) {
    $warningCollection[this].add(warning);
  }

  /// When an instance is first created
  /// Must be used in the constructor
  void init() {
    if ($instanceCollection._map.containsKey($ref)) throw Exception("Document ref already inited");
    if (_inited) throw Exception("Instance already initialized");
    $instanceCollection._set(this);
    _inited = true;
  }

  /// When an instance is deleted in the database
  /// Should NOT be used after that
  void dispose() {
    if (_disposed) throw Exception("Instance already disposed");
    $instanceCollection._remove($ref);
    for (var warningList in $warningCollection) {
      warningList.clear();
    }
    _disposed = true;
  }

  void notifyUpdate() {
    // 
    // TODO: juntar aos listeners
  }

  // forçar de alguma forma um método update

  Map<String, dynamic> toMap();
}

/// Every Model needs to implements
/// - private snapshot property
/// - $snapshot getter
/// - static Instance Collection and Warning Collection
/// - getters for $instanceCollection and $warningCollection
/// - override $warnings to change return type to own type as generic
/// - static method with Result to create instance from Map (firestore)
/// - static MapVerifier
/// - toMap method

mixin InstanceCollectionListener<W extends StatefulWidget> on State<W> {
  // TODO: instance collection listener
}

mixin InstanceListener<W extends StatefulWidget> on State<W> {
  // TODO: instance listener
}

mixin TitledEnum {
  String get title;
}