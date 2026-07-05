import 'package:freezed_annotation/freezed_annotation.dart';

part 'limits.freezed.dart';
part 'limits.g.dart';

/// Сущность базовых недельных лимитов
@freezed
abstract class Limits with _$Limits {
  const factory Limits({
    @Default(0.0) double homeAndEveryday,
    @Default(0.0) double personal,
    @Default(0.0) double social,
    @Default(0.0) double bills,
    @Default(0.0) double youtube,
    @Default(0.0) double longTerm,
    @Default(0.0) double safetyNet,
  }) = _Limits;

  factory Limits.fromJson(Map<String, dynamic> json) => _$LimitsFromJson(json);
}
