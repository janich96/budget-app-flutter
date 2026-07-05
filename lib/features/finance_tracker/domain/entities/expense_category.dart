import 'package:freezed_annotation/freezed_annotation.dart';

part 'expense_category.freezed.dart';
part 'expense_category.g.dart';

/// Пользовательская категория трат
@freezed
abstract class ExpenseCategory with _$ExpenseCategory {
  const factory ExpenseCategory({
    required String id,
    required String name,
    @Default(0.0) double limit,
    /// ID категории накоплений, куда уходит остаток от лимита этой траты
    String? linkedAccumulationId,
    String? description,
    @Default(0xFF2196F3) int colorValue,
  }) = _ExpenseCategory;

  factory ExpenseCategory.fromJson(Map<String, dynamic> json) => _$ExpenseCategoryFromJson(json);
}
