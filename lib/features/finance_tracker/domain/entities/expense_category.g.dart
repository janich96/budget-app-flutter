// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExpenseCategory _$ExpenseCategoryFromJson(Map<String, dynamic> json) =>
    _ExpenseCategory(
      id: json['id'] as String,
      name: json['name'] as String,
      limit: (json['limit'] as num?)?.toDouble() ?? 0.0,
      linkedAccumulationId: json['linkedAccumulationId'] as String?,
      description: json['description'] as String?,
      colorValue: (json['colorValue'] as num?)?.toInt() ?? 0xFF2196F3,
    );

Map<String, dynamic> _$ExpenseCategoryToJson(_ExpenseCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'limit': instance.limit,
      'linkedAccumulationId': instance.linkedAccumulationId,
      'description': instance.description,
      'colorValue': instance.colorValue,
    };
