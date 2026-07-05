// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'week_entry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WeekEntryModel _$WeekEntryModelFromJson(Map<String, dynamic> json) =>
    _WeekEntryModel(
      id: json['id'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      expenses: (json['expenses'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toDouble()),
          ) ??
          const {},
      limitsSnapshot: (json['limitsSnapshot'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toDouble()),
          ) ??
          const {},
      linksSnapshot: (json['linksSnapshot'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
    );

Map<String, dynamic> _$WeekEntryModelToJson(_WeekEntryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'expenses': instance.expenses,
      'limitsSnapshot': instance.limitsSnapshot,
      'linksSnapshot': instance.linksSnapshot,
    };
