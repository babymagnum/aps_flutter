// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_gender.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetGender _$GetGenderFromJson(Map<String, dynamic> json) {
  return GetGender(
      json['status'] as int,
      json['message'] as String,
      (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : ItemGetGender.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$GetGenderToJson(GetGender instance) => <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data?.map((e) => e?.toJson())?.toList()
    };
