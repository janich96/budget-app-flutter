// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accumulation_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AccumulationCategoryModel _$AccumulationCategoryModelFromJson(
        Map<String, dynamic> json) =>
    _AccumulationCategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      currentBalance: (json['currentBalance'] as num?)?.toDouble() ?? 0.0,
      targetAmount: (json['targetAmount'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] as String?,
      colorValue: (json['colorValue'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AccumulationCategoryModelToJson(
        _AccumulationCategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'currentBalance': instance.currentBalance,
      'targetAmount': instance.targetAmount,
      'description': instance.description,
      'colorValue': instance.colorValue,
    };
