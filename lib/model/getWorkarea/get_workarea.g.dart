// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_workarea.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetWorkarea _$GetWorkareaFromJson(Map<String, dynamic> json) {
  return GetWorkarea(
      json['status'] as int,
      json['message'] as String,
      (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : ItemGetWorkarea.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$GetWorkareaToJson(GetWorkarea instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data?.map((e) => e?.toJson())?.toList()
    };
