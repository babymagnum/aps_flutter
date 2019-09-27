// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_leave_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetLeaveType _$GetLeaveTypeFromJson(Map<String, dynamic> json) {
  return GetLeaveType(
      json['status'] as int,
      json['message'] as String,
      (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : ItemGetLeaveType.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$GetLeaveTypeToJson(GetLeaveType instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data?.map((e) => e?.toJson())?.toList()
    };
