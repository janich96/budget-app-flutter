// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'limits.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Limits _$LimitsFromJson(Map<String, dynamic> json) => _Limits(
      homeAndEveryday: (json['homeAndEveryday'] as num?)?.toDouble() ?? 0.0,
      personal: (json['personal'] as num?)?.toDouble() ?? 0.0,
      social: (json['social'] as num?)?.toDouble() ?? 0.0,
      bills: (json['bills'] as num?)?.toDouble() ?? 0.0,
      youtube: (json['youtube'] as num?)?.toDouble() ?? 0.0,
      longTerm: (json['longTerm'] as num?)?.toDouble() ?? 0.0,
      safetyNet: (json['safetyNet'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$LimitsToJson(_Limits instance) => <String, dynamic>{
      'homeAndEveryday': instance.homeAndEveryday,
      'personal': instance.personal,
      'social': instance.social,
      'bills': instance.bills,
      'youtube': instance.youtube,
      'longTerm': instance.longTerm,
      'safetyNet': instance.safetyNet,
    };
