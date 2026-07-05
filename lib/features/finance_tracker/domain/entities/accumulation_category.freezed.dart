// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'accumulation_category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AccumulationCategory {
  String get id;
  String get name;
  double get currentBalance;
  double get targetAmount;
  String? get description;
  int get colorValue;

  /// Create a copy of AccumulationCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AccumulationCategoryCopyWith<AccumulationCategory> get copyWith =>
      _$AccumulationCategoryCopyWithImpl<AccumulationCategory>(
          this as AccumulationCategory, _$identity);

  /// Serializes this AccumulationCategory to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AccumulationCategory &&
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
    return 'AccumulationCategory(id: $id, name: $name, currentBalance: $currentBalance, targetAmount: $targetAmount, description: $description, colorValue: $colorValue)';
  }
}

/// @nodoc
abstract mixin class $AccumulationCategoryCopyWith<$Res> {
  factory $AccumulationCategoryCopyWith(AccumulationCategory value,
          $Res Function(AccumulationCategory) _then) =
      _$AccumulationCategoryCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String name,
      double currentBalance,
      double targetAmount,
      String? description,
      int colorValue});
}

/// @nodoc
class _$AccumulationCategoryCopyWithImpl<$Res>
    implements $AccumulationCategoryCopyWith<$Res> {
  _$AccumulationCategoryCopyWithImpl(this._self, this._then);

  final AccumulationCategory _self;
  final $Res Function(AccumulationCategory) _then;

  /// Create a copy of AccumulationCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? currentBalance = null,
    Object? targetAmount = null,
    Object? description = freezed,
    Object? colorValue = null,
  }) {
    return _then(AccumulationCategory(
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
      colorValue: null == colorValue
          ? _self.colorValue
          : colorValue // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [AccumulationCategory].
extension AccumulationCategoryPatterns on AccumulationCategory {
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
    TResult Function(_AccumulationCategory value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AccumulationCategory() when $default != null:
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
    TResult Function(_AccumulationCategory value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AccumulationCategory():
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
    TResult? Function(_AccumulationCategory value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AccumulationCategory() when $default != null:
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
            double targetAmount, String? description, int colorValue)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AccumulationCategory() when $default != null:
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
            double targetAmount, String? description, int colorValue)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AccumulationCategory():
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
            double targetAmount, String? description, int colorValue)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AccumulationCategory() when $default != null:
        return $default(_that.id, _that.name, _that.currentBalance,
            _that.targetAmount, _that.description, _that.colorValue);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _AccumulationCategory implements AccumulationCategory {
  const _AccumulationCategory(
      {required this.id,
      required this.name,
      this.currentBalance = 0.0,
      this.targetAmount = 0.0,
      this.description,
      this.colorValue = 0xFF4CAF50});
  factory _AccumulationCategory.fromJson(Map<String, dynamic> json) =>
      _$AccumulationCategoryFromJson(json);

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
  @JsonKey()
  final int colorValue;

  /// Create a copy of AccumulationCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AccumulationCategoryCopyWith<_AccumulationCategory> get copyWith =>
      __$AccumulationCategoryCopyWithImpl<_AccumulationCategory>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AccumulationCategoryToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AccumulationCategory &&
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
    return 'AccumulationCategory(id: $id, name: $name, currentBalance: $currentBalance, targetAmount: $targetAmount, description: $description, colorValue: $colorValue)';
  }
}

/// @nodoc
abstract mixin class _$AccumulationCategoryCopyWith<$Res>
    implements $AccumulationCategoryCopyWith<$Res> {
  factory _$AccumulationCategoryCopyWith(_AccumulationCategory value,
          $Res Function(_AccumulationCategory) _then) =
      __$AccumulationCategoryCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      double currentBalance,
      double targetAmount,
      String? description,
      int colorValue});
}

/// @nodoc
class __$AccumulationCategoryCopyWithImpl<$Res>
    implements _$AccumulationCategoryCopyWith<$Res> {
  __$AccumulationCategoryCopyWithImpl(this._self, this._then);

  final _AccumulationCategory _self;
  final $Res Function(_AccumulationCategory) _then;

  /// Create a copy of AccumulationCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? currentBalance = null,
    Object? targetAmount = null,
    Object? description = freezed,
    Object? colorValue = null,
  }) {
    return _then(_AccumulationCategory(
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
      colorValue: null == colorValue
          ? _self.colorValue
          : colorValue // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
