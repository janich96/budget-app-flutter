// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'week_entry_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WeekEntryModel {
  String get id;
  DateTime get startDate;
  DateTime get endDate;
  Map<String, double> get expenses;
  Map<String, double> get limitsSnapshot;
  Map<String, String> get linksSnapshot;

  /// Create a copy of WeekEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WeekEntryModelCopyWith<WeekEntryModel> get copyWith =>
      _$WeekEntryModelCopyWithImpl<WeekEntryModel>(
          this as WeekEntryModel, _$identity);

  /// Serializes this WeekEntryModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WeekEntryModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            const DeepCollectionEquality().equals(other.expenses, expenses) &&
            const DeepCollectionEquality()
                .equals(other.limitsSnapshot, limitsSnapshot) &&
            const DeepCollectionEquality()
                .equals(other.linksSnapshot, linksSnapshot));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      startDate,
      endDate,
      const DeepCollectionEquality().hash(expenses),
      const DeepCollectionEquality().hash(limitsSnapshot),
      const DeepCollectionEquality().hash(linksSnapshot));

  @override
  String toString() {
    return 'WeekEntryModel(id: $id, startDate: $startDate, endDate: $endDate, expenses: $expenses, limitsSnapshot: $limitsSnapshot, linksSnapshot: $linksSnapshot)';
  }
}

/// @nodoc
abstract mixin class $WeekEntryModelCopyWith<$Res> {
  factory $WeekEntryModelCopyWith(
          WeekEntryModel value, $Res Function(WeekEntryModel) _then) =
      _$WeekEntryModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      DateTime startDate,
      DateTime endDate,
      Map<String, double> expenses,
      Map<String, double> limitsSnapshot,
      Map<String, String> linksSnapshot});
}

/// @nodoc
class _$WeekEntryModelCopyWithImpl<$Res>
    implements $WeekEntryModelCopyWith<$Res> {
  _$WeekEntryModelCopyWithImpl(this._self, this._then);

  final WeekEntryModel _self;
  final $Res Function(WeekEntryModel) _then;

  /// Create a copy of WeekEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? expenses = null,
    Object? limitsSnapshot = null,
    Object? linksSnapshot = null,
  }) {
    return _then(WeekEntryModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expenses: null == expenses
          ? _self.expenses
          : expenses // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      limitsSnapshot: null == limitsSnapshot
          ? _self.limitsSnapshot
          : limitsSnapshot // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      linksSnapshot: null == linksSnapshot
          ? _self.linksSnapshot
          : linksSnapshot // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
    ));
  }
}

/// Adds pattern-matching-related methods to [WeekEntryModel].
extension WeekEntryModelPatterns on WeekEntryModel {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_WeekEntryModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WeekEntryModel() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_WeekEntryModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WeekEntryModel():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_WeekEntryModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WeekEntryModel() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            DateTime startDate,
            DateTime endDate,
            Map<String, double> expenses,
            Map<String, double> limitsSnapshot,
            Map<String, String> linksSnapshot)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WeekEntryModel() when $default != null:
        return $default(_that.id, _that.startDate, _that.endDate,
            _that.expenses, _that.limitsSnapshot, _that.linksSnapshot);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            DateTime startDate,
            DateTime endDate,
            Map<String, double> expenses,
            Map<String, double> limitsSnapshot,
            Map<String, String> linksSnapshot)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WeekEntryModel():
        return $default(_that.id, _that.startDate, _that.endDate,
            _that.expenses, _that.limitsSnapshot, _that.linksSnapshot);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            DateTime startDate,
            DateTime endDate,
            Map<String, double> expenses,
            Map<String, double> limitsSnapshot,
            Map<String, String> linksSnapshot)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WeekEntryModel() when $default != null:
        return $default(_that.id, _that.startDate, _that.endDate,
            _that.expenses, _that.limitsSnapshot, _that.linksSnapshot);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _WeekEntryModel extends WeekEntryModel {
  const _WeekEntryModel(
      {required this.id,
      required this.startDate,
      required this.endDate,
      Map<String, double> expenses = const {},
      Map<String, double> limitsSnapshot = const {},
      Map<String, String> linksSnapshot = const {}})
      : _expenses = expenses,
        _limitsSnapshot = limitsSnapshot,
        _linksSnapshot = linksSnapshot,
        super._();
  factory _WeekEntryModel.fromJson(Map<String, dynamic> json) =>
      _$WeekEntryModelFromJson(json);

  @override
  final String id;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  final Map<String, double> _expenses;
  @override
  @JsonKey()
  Map<String, double> get expenses {
    if (_expenses is EqualUnmodifiableMapView) return _expenses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_expenses);
  }

  final Map<String, double> _limitsSnapshot;
  @override
  @JsonKey()
  Map<String, double> get limitsSnapshot {
    if (_limitsSnapshot is EqualUnmodifiableMapView) return _limitsSnapshot;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_limitsSnapshot);
  }

  final Map<String, String> _linksSnapshot;
  @override
  @JsonKey()
  Map<String, String> get linksSnapshot {
    if (_linksSnapshot is EqualUnmodifiableMapView) return _linksSnapshot;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_linksSnapshot);
  }

  /// Create a copy of WeekEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WeekEntryModelCopyWith<_WeekEntryModel> get copyWith =>
      __$WeekEntryModelCopyWithImpl<_WeekEntryModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WeekEntryModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WeekEntryModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            const DeepCollectionEquality().equals(other._expenses, _expenses) &&
            const DeepCollectionEquality()
                .equals(other._limitsSnapshot, _limitsSnapshot) &&
            const DeepCollectionEquality()
                .equals(other._linksSnapshot, _linksSnapshot));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      startDate,
      endDate,
      const DeepCollectionEquality().hash(_expenses),
      const DeepCollectionEquality().hash(_limitsSnapshot),
      const DeepCollectionEquality().hash(_linksSnapshot));

  @override
  String toString() {
    return 'WeekEntryModel(id: $id, startDate: $startDate, endDate: $endDate, expenses: $expenses, limitsSnapshot: $limitsSnapshot, linksSnapshot: $linksSnapshot)';
  }
}

/// @nodoc
abstract mixin class _$WeekEntryModelCopyWith<$Res>
    implements $WeekEntryModelCopyWith<$Res> {
  factory _$WeekEntryModelCopyWith(
          _WeekEntryModel value, $Res Function(_WeekEntryModel) _then) =
      __$WeekEntryModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime startDate,
      DateTime endDate,
      Map<String, double> expenses,
      Map<String, double> limitsSnapshot,
      Map<String, String> linksSnapshot});
}

/// @nodoc
class __$WeekEntryModelCopyWithImpl<$Res>
    implements _$WeekEntryModelCopyWith<$Res> {
  __$WeekEntryModelCopyWithImpl(this._self, this._then);

  final _WeekEntryModel _self;
  final $Res Function(_WeekEntryModel) _then;

  /// Create a copy of WeekEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? expenses = null,
    Object? limitsSnapshot = null,
    Object? linksSnapshot = null,
  }) {
    return _then(_WeekEntryModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expenses: null == expenses
          ? _self._expenses
          : expenses // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      limitsSnapshot: null == limitsSnapshot
          ? _self._limitsSnapshot
          : limitsSnapshot // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      linksSnapshot: null == linksSnapshot
          ? _self._linksSnapshot
          : linksSnapshot // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
    ));
  }
}

// dart format on
