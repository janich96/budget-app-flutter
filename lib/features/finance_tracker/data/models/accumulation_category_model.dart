import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/accumulation_category.dart';

part 'accumulation_category_model.freezed.dart';
part 'accumulation_category_model.g.dart';

@freezed
abstract class AccumulationCategoryModel with _$AccumulationCategoryModel {
  const AccumulationCategoryModel._();

  const factory AccumulationCategoryModel({
    required String id,
    required String name,
    @Default(0.0) double currentBalance,
    @Default(0.0) double targetAmount,
    String? description,
    int? colorValue,
  }) = _AccumulationCategoryModel;

  factory AccumulationCategoryModel.fromJson(Map<String, dynamic> json) => 
      _$AccumulationCategoryModelFromJson(json);

  /// Конвертация Entity -> Model
  factory AccumulationCategoryModel.fromEntity(AccumulationCategory entity) {
    return AccumulationCategoryModel(
      id: entity.id,
      name: entity.name,
      currentBalance: entity.currentBalance,
      targetAmount: entity.targetAmount,
      description: entity.description,
      colorValue: entity.colorValue,
    );
  }

  /// Конвертация Model -> Entity
  AccumulationCategory toEntity() {
    return AccumulationCategory(
      id: id,
      name: name,
      currentBalance: currentBalance,
      targetAmount: targetAmount,
      description: description,
      colorValue: colorValue ?? 0xFF4CAF50,
    );
  }
}
