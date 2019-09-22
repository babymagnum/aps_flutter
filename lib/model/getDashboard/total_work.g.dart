// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'total_work.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TotalWork _$TotalWorkFromJson(Map<String, dynamic> json) {
  return TotalWork(json['total_work_achievement'] as String,
      json['total_work_hours'] as String);
}

Map<String, dynamic> _$TotalWorkToJson(TotalWork instance) => <String, dynamic>{
      'total_work_achievement': instance.total_work_achievement,
      'total_work_hours': instance.total_work_hours
    };
