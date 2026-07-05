import 'package:freezed_annotation/freezed_annotation.dart';

part 'accumulation_category.freezed.dart';
part 'accumulation_category.g.dart';

/// Пользовательская категория накоплений
@freezed
abstract class AccumulationCategory with _$AccumulationCategory {
  const factory AccumulationCategory({
    required String id,
    required String name,
    @Default(0.0) double currentBalance,
    @Default(0.0) double targetAmount,
    String? description,
    @Default(0xFF4CAF50) int colorValue,
  }) = _AccumulationCategory;

  factory AccumulationCategory.fromJson(Map<String, dynamic> json) => _$AccumulationCategoryFromJson(json);
}
