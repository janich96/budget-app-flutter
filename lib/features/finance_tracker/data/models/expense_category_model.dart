import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/expense_category.dart';

part 'expense_category_model.freezed.dart';
part 'expense_category_model.g.dart';

@freezed
abstract class ExpenseCategoryModel with _$ExpenseCategoryModel {
  const ExpenseCategoryModel._();

  const factory ExpenseCategoryModel({
    required String id,
    required String name,
    @Default(0.0) double limit,
    String? linkedAccumulationId,
    String? description,
    int? colorValue,
  }) = _ExpenseCategoryModel;

  factory ExpenseCategoryModel.fromJson(Map<String, dynamic> json) => 
      _$ExpenseCategoryModelFromJson(json);

  factory ExpenseCategoryModel.fromEntity(ExpenseCategory entity) {
    return ExpenseCategoryModel(
      id: entity.id,
      name: entity.name,
      limit: entity.limit,
      linkedAccumulationId: entity.linkedAccumulationId,
      description: entity.description,
      colorValue: entity.colorValue,
    );
  }

  ExpenseCategory toEntity() {
    return ExpenseCategory(
      id: id,
      name: name,
      limit: limit,
      linkedAccumulationId: linkedAccumulationId,
      description: description,
      colorValue: colorValue ?? 0xFF2196F3,
    );
  }
}
