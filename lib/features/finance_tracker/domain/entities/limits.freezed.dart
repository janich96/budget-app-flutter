// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'limits.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Limits {
  double get homeAndEveryday;
  double get personal;
  double get social;
  double get bills;
  double get youtube;
  double get longTerm;
  double get safetyNet;

  /// Create a copy of Limits
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LimitsCopyWith<Limits> get copyWith =>
      _$LimitsCopyWithImpl<Limits>(this as Limits, _$identity);

  /// Serializes this Limits to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Limits &&
            (identical(other.homeAndEveryday, homeAndEveryday) ||
                other.homeAndEveryday == homeAndEveryday) &&
            (identical(other.personal, personal) ||
                other.personal == personal) &&
            (identical(other.social, social) || other.social == social) &&
            (identical(other.bills, bills) || other.bills == bills) &&
            (identical(other.youtube, youtube) || other.youtube == youtube) &&
            (identical(other.longTerm, longTerm) ||
                other.longTerm == longTerm) &&
            (identical(other.safetyNet, safetyNet) ||
                other.safetyNet == safetyNet));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, homeAndEveryday, personal,
      social, bills, youtube, longTerm, safetyNet);

  @override
  String toString() {
    return 'Limits(homeAndEveryday: $homeAndEveryday, personal: $personal, social: $social, bills: $bills, youtube: $youtube, longTerm: $longTerm, safetyNet: $safetyNet)';
  }
}

/// @nodoc
abstract mixin class $LimitsCopyWith<$Res> {
  factory $LimitsCopyWith(Limits value, $Res Function(Limits) _then) =
      _$LimitsCopyWithImpl;
  @useResult
  $Res call(
      {double homeAndEveryday,
      double personal,
      double social,
      double bills,
      double youtube,
      double longTerm,
      double safetyNet});
}

/// @nodoc
class _$LimitsCopyWithImpl<$Res> implements $LimitsCopyWith<$Res> {
  _$LimitsCopyWithImpl(this._self, this._then);

  final Limits _self;
  final $Res Function(Limits) _then;

  /// Create a copy of Limits
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? homeAndEveryday = null,
    Object? personal = null,
    Object? social = null,
    Object? bills = null,
    Object? youtube = null,
    Object? longTerm = null,
    Object? safetyNet = null,
  }) {
    return _then(Limits(
      homeAndEveryday: null == homeAndEveryday
          ? _self.homeAndEveryday
          : homeAndEveryday // ignore: cast_nullable_to_non_nullable
              as double,
      personal: null == personal
          ? _self.personal
          : personal // ignore: cast_nullable_to_non_nullable
              as double,
      social: null == social
          ? _self.social
          : social // ignore: cast_nullable_to_non_nullable
              as double,
      bills: null == bills
          ? _self.bills
          : bills // ignore: cast_nullable_to_non_nullable
              as double,
      youtube: null == youtube
          ? _self.youtube
          : youtube // ignore: cast_nullable_to_non_nullable
              as double,
      longTerm: null == longTerm
          ? _self.longTerm
          : longTerm // ignore: cast_nullable_to_non_nullable
              as double,
      safetyNet: null == safetyNet
          ? _self.safetyNet
          : safetyNet // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// Adds pattern-matching-related methods to [Limits].
extension LimitsPatterns on Limits {
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
    TResult Function(_Limits value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Limits() when $default != null:
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
    TResult Function(_Limits value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Limits():
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
    TResult? Function(_Limits value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Limits() when $default != null:
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
    TResult Function(double homeAndEveryday, double personal, double social,
            double bills, double youtube, double longTerm, double safetyNet)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Limits() when $default != null:
        return $default(_that.homeAndEveryday, _that.personal, _that.social,
            _that.bills, _that.youtube, _that.longTerm, _that.safetyNet);
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
    TResult Function(double homeAndEveryday, double personal, double social,
            double bills, double youtube, double longTerm, double safetyNet)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Limits():
        return $default(_that.homeAndEveryday, _that.personal, _that.social,
            _that.bills, _that.youtube, _that.longTerm, _that.safetyNet);
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
    TResult? Function(double homeAndEveryday, double personal, double social,
            double bills, double youtube, double longTerm, double safetyNet)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Limits() when $default != null:
        return $default(_that.homeAndEveryday, _that.personal, _that.social,
            _that.bills, _that.youtube, _that.longTerm, _that.safetyNet);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Limits implements Limits {
  const _Limits(
      {this.homeAndEveryday = 0.0,
      this.personal = 0.0,
      this.social = 0.0,
      this.bills = 0.0,
      this.youtube = 0.0,
      this.longTerm = 0.0,
      this.safetyNet = 0.0});
  factory _Limits.fromJson(Map<String, dynamic> json) => _$LimitsFromJson(json);

  @override
  @JsonKey()
  final double homeAndEveryday;
  @override
  @JsonKey()
  final double personal;
  @override
  @JsonKey()
  final double social;
  @override
  @JsonKey()
  final double bills;
  @override
  @JsonKey()
  final double youtube;
  @override
  @JsonKey()
  final double longTerm;
  @override
  @JsonKey()
  final double safetyNet;

  /// Create a copy of Limits
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LimitsCopyWith<_Limits> get copyWith =>
      __$LimitsCopyWithImpl<_Limits>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LimitsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Limits &&
            (identical(other.homeAndEveryday, homeAndEveryday) ||
                other.homeAndEveryday == homeAndEveryday) &&
            (identical(other.personal, personal) ||
                other.personal == personal) &&
            (identical(other.social, social) || other.social == social) &&
            (identical(other.bills, bills) || other.bills == bills) &&
            (identical(other.youtube, youtube) || other.youtube == youtube) &&
            (identical(other.longTerm, longTerm) ||
                other.longTerm == longTerm) &&
            (identical(other.safetyNet, safetyNet) ||
                other.safetyNet == safetyNet));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, homeAndEveryday, personal,
      social, bills, youtube, longTerm, safetyNet);

  @override
  String toString() {
    return 'Limits(homeAndEveryday: $homeAndEveryday, personal: $personal, social: $social, bills: $bills, youtube: $youtube, longTerm: $longTerm, safetyNet: $safetyNet)';
  }
}

/// @nodoc
abstract mixin class _$LimitsCopyWith<$Res> implements $LimitsCopyWith<$Res> {
  factory _$LimitsCopyWith(_Limits value, $Res Function(_Limits) _then) =
      __$LimitsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {double homeAndEveryday,
      double personal,
      double social,
      double bills,
      double youtube,
      double longTerm,
      double safetyNet});
}

/// @nodoc
class __$LimitsCopyWithImpl<$Res> implements _$LimitsCopyWith<$Res> {
  __$LimitsCopyWithImpl(this._self, this._then);

  final _Limits _self;
  final $Res Function(_Limits) _then;

  /// Create a copy of Limits
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? homeAndEveryday = null,
    Object? personal = null,
    Object? social = null,
    Object? bills = null,
    Object? youtube = null,
    Object? longTerm = null,
    Object? safetyNet = null,
  }) {
    return _then(_Limits(
      homeAndEveryday: null == homeAndEveryday
          ? _self.homeAndEveryday
          : homeAndEveryday // ignore: cast_nullable_to_non_nullable
              as double,
      personal: null == personal
          ? _self.personal
          : personal // ignore: cast_nullable_to_non_nullable
              as double,
      social: null == social
          ? _self.social
          : social // ignore: cast_nullable_to_non_nullable
              as double,
      bills: null == bills
          ? _self.bills
          : bills // ignore: cast_nullable_to_non_nullable
              as double,
      youtube: null == youtube
          ? _self.youtube
          : youtube // ignore: cast_nullable_to_non_nullable
              as double,
      longTerm: null == longTerm
          ? _self.longTerm
          : longTerm // ignore: cast_nullable_to_non_nullable
              as double,
      safetyNet: null == safetyNet
          ? _self.safetyNet
          : safetyNet // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

// dart format on
