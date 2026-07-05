// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExpenseCategoryModel _$ExpenseCategoryModelFromJson(
        Map<String, dynamic> json) =>
    _ExpenseCategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      limit: (json['limit'] as num?)?.toDouble() ?? 0.0,
      linkedAccumulationId: json['linkedAccumulationId'] as String?,
      description: json['description'] as String?,
      colorValue: (json['colorValue'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ExpenseCategoryModelToJson(
        _ExpenseCategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'limit': instance.limit,
      'linkedAccumulationId': instance.linkedAccumulationId,
      'description': instance.description,
      'colorValue': instance.colorValue,
    };
