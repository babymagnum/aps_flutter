// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_get_leave_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemGetLeaveType _$ItemGetLeaveTypeFromJson(Map<String, dynamic> json) {
  return ItemGetLeaveType(
      json['id'] as String,
      json['code'] as String,
      json['type'] as String,
      json['name'] as String,
      json['is_day'] as String,
      json['days_count'] as String,
      json['is_range'] as String,
      json['is_reduced'] as String,
      json['is_backdated'] as String,
      json['is_salary_reduced'] as String,
      json['is_lampiran'] as String,
      json['work_period'] as String);
}

Map<String, dynamic> _$ItemGetLeaveTypeToJson(ItemGetLeaveType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'type': instance.type,
      'name': instance.name,
      'is_day': instance.is_day,
      'days_count': instance.days_count,
      'is_range': instance.is_range,
      'is_reduced': instance.is_reduced,
      'is_backdated': instance.is_backdated,
      'is_salary_reduced': instance.is_salary_reduced,
      'is_lampiran': instance.is_lampiran,
      'work_period': instance.work_period
    };
