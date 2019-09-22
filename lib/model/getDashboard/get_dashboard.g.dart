// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_dashboard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetDashboard _$GetDashboardFromJson(Map<String, dynamic> json) {
  return GetDashboard(
      json['status'] as int,
      json['message'] as String,
      (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : ItemDashboard.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$GetDashboardToJson(GetDashboard instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data?.map((e) => e?.toJson())?.toList()
    };
