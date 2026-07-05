// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'accumulation_category_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AccumulationCategoryModel {
  String get id;
  String get name;
  double get currentBalance;
  double get targetAmount;
  String? get description;
  int? get colorValue;

  /// Create a copy of AccumulationCategoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AccumulationCategoryModelCopyWith<AccumulationCategoryModel> get copyWith =>
      _$AccumulationCategoryModelCopyWithImpl<AccumulationCategoryModel>(
          this as AccumulationCategoryModel, _$identity);

  /// Serializes this AccumulationCategoryModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AccumulationCategoryModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.currentBalance, currentBalance) ||
                other.currentBalance == currentBalance) &&
            (identical(other.targetAmount, targetAmount) ||
                other.targetAmount == targetAmount) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.colorValue, colorValue) ||
                other.colorValue == colorValue));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, currentBalance,
      targetAmount, description, colorValue);

  @override
  String toString() {
    return 'AccumulationCategoryModel(id: $id, name: $name, currentBalance: $currentBalance, targetAmount: $targetAmount, description: $description, colorValue: $colorValue)';
  }
}

/// @nodoc
abstract mixin class $AccumulationCategoryModelCopyWith<$Res> {
  factory $AccumulationCategoryModelCopyWith(AccumulationCategoryModel value,
          $Res Function(AccumulationCategoryModel) _then) =
      _$AccumulationCategoryModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String name,
      double currentBalance,
      double targetAmount,
      String? description,
      int? colorValue});
}

/// @nodoc
class _$AccumulationCategoryModelCopyWithImpl<$Res>
    implements $AccumulationCategoryModelCopyWith<$Res> {
  _$AccumulationCategoryModelCopyWithImpl(this._self, this._then);

  final AccumulationCategoryModel _self;
  final $Res Function(AccumulationCategoryModel) _then;

  /// Create a copy of AccumulationCategoryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? currentBalance = null,
    Object? targetAmount = null,
    Object? description = freezed,
    Object? colorValue = freezed,
  }) {
    return _then(AccumulationCategoryModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      currentBalance: null == currentBalance
          ? _self.currentBalance
          : currentBalance // ignore: cast_nullable_to_non_nullable
              as double,
      targetAmount: null == targetAmount
          ? _self.targetAmount
          : targetAmount // ignore: cast_nullable_to_non_nullable
              as double,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      colorValue: freezed == colorValue
          ? _self.colorValue
          : colorValue // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// Adds pattern-matching-related methods to [AccumulationCategoryModel].
extension AccumulationCategoryModelPatterns on AccumulationCategoryModel {
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
    TResult Function(_AccumulationCategoryModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AccumulationCategoryModel() when $default != null:
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
    TResult Function(_AccumulationCategoryModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AccumulationCategoryModel():
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
    TResult? Function(_AccumulationCategoryModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AccumulationCategoryModel() when $default != null:
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
    TResult Function(String id, String name, double currentBalance,
            double targetAmount, String? description, int? colorValue)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AccumulationCategoryModel() when $default != null:
        return $default(_that.id, _that.name, _that.currentBalance,
            _that.targetAmount, _that.description, _that.colorValue);
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
    TResult Function(String id, String name, double currentBalance,
            double targetAmount, String? description, int? colorValue)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AccumulationCategoryModel():
        return $default(_that.id, _that.name, _that.currentBalance,
            _that.targetAmount, _that.description, _that.colorValue);
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
    TResult? Function(String id, String name, double currentBalance,
            double targetAmount, String? description, int? colorValue)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AccumulationCategoryModel() when $default != null:
        return $default(_that.id, _that.name, _that.currentBalance,
            _that.targetAmount, _that.description, _that.colorValue);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _AccumulationCategoryModel extends AccumulationCategoryModel {
  const _AccumulationCategoryModel(
      {required this.id,
      required this.name,
      this.currentBalance = 0.0,
      this.targetAmount = 0.0,
      this.description,
      this.colorValue})
      : super._();
  factory _AccumulationCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$AccumulationCategoryModelFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey()
  final double currentBalance;
  @override
  @JsonKey()
  final double targetAmount;
  @override
  final String? description;
  @override
  final int? colorValue;

  /// Create a copy of AccumulationCategoryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AccumulationCategoryModelCopyWith<_AccumulationCategoryModel>
      get copyWith =>
          __$AccumulationCategoryModelCopyWithImpl<_AccumulationCategoryModel>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AccumulationCategoryModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AccumulationCategoryModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.currentBalance, currentBalance) ||
                other.currentBalance == currentBalance) &&
            (identical(other.targetAmount, targetAmount) ||
                other.targetAmount == targetAmount) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.colorValue, colorValue) ||
                other.colorValue == colorValue));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, currentBalance,
      targetAmount, description, colorValue);

  @override
  String toString() {
    return 'AccumulationCategoryModel(id: $id, name: $name, currentBalance: $currentBalance, targetAmount: $targetAmount, description: $description, colorValue: $colorValue)';
  }
}

/// @nodoc
abstract mixin class _$AccumulationCategoryModelCopyWith<$Res>
    implements $AccumulationCategoryModelCopyWith<$Res> {
  factory _$AccumulationCategoryModelCopyWith(_AccumulationCategoryModel value,
          $Res Function(_AccumulationCategoryModel) _then) =
      __$AccumulationCategoryModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      double currentBalance,
      double targetAmount,
      String? description,
      int? colorValue});
}

/// @nodoc
class __$AccumulationCategoryModelCopyWithImpl<$Res>
    implements _$AccumulationCategoryModelCopyWith<$Res> {
  __$AccumulationCategoryModelCopyWithImpl(this._self, this._then);

  final _AccumulationCategoryModel _self;
  final $Res Function(_AccumulationCategoryModel) _then;

  /// Create a copy of AccumulationCategoryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? currentBalance = null,
    Object? targetAmount = null,
    Object? description = freezed,
    Object? colorValue = freezed,
  }) {
    return _then(_AccumulationCategoryModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      currentBalance: null == currentBalance
          ? _self.currentBalance
          : currentBalance // ignore: cast_nullable_to_non_nullable
              as double,
      targetAmount: null == targetAmount
          ? _self.targetAmount
          : targetAmount // ignore: cast_nullable_to_non_nullable
              as double,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      colorValue: freezed == colorValue
          ? _self.colorValue
          : colorValue // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

// dart format on
