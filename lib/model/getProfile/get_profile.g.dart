// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetProfile _$GetProfileFromJson(Map<String, dynamic> json) {
  return GetProfile(
      json['status'] as int,
      json['message'] as String,
      (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : ItemGetProfile.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$GetProfileToJson(GetProfile instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data?.map((e) => e?.toJson())?.toList()
    };
