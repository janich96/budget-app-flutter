// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'week_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WeekEntry _$WeekEntryFromJson(Map<String, dynamic> json) => _WeekEntry(
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

Map<String, dynamic> _$WeekEntryToJson(_WeekEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'expenses': instance.expenses,
      'limitsSnapshot': instance.limitsSnapshot,
      'linksSnapshot': instance.linksSnapshot,
    };
