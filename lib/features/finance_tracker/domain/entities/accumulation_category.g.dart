// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accumulation_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AccumulationCategory _$AccumulationCategoryFromJson(
        Map<String, dynamic> json) =>
    _AccumulationCategory(
      id: json['id'] as String,
      name: json['name'] as String,
      currentBalance: (json['currentBalance'] as num?)?.toDouble() ?? 0.0,
      targetAmount: (json['targetAmount'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] as String?,
      colorValue: (json['colorValue'] as num?)?.toInt() ?? 0xFF4CAF50,
    );

Map<String, dynamic> _$AccumulationCategoryToJson(
        _AccumulationCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'currentBalance': instance.currentBalance,
      'targetAmount': instance.targetAmount,
      'description': instance.description,
      'colorValue': instance.colorValue,
    };
