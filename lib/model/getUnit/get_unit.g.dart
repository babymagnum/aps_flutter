// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_unit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUnit _$GetUnitFromJson(Map<String, dynamic> json) {
  return GetUnit(
      json['status'] as int,
      json['message'] as String,
      (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : ItemGetUnit.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$GetUnitToJson(GetUnit instance) => <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data?.map((e) => e?.toJson())?.toList()
    };
