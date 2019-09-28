// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_leave_quota.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetLeaveQuota _$GetLeaveQuotaFromJson(Map<String, dynamic> json) {
  return GetLeaveQuota(
      json['status'] as int,
      json['message'] as String,
      (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : ItemGetLeaveQuota.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$GetLeaveQuotaToJson(GetLeaveQuota instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data
    };
