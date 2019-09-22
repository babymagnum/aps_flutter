// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Login _$LoginFromJson(Map<String, dynamic> json) {
  return Login(
      json['status'] as int,
      json['message'] as String,
      (json['data'] as List)
          ?.map((e) =>
              e == null ? null : ItemLogin.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$LoginToJson(Login instance) => <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data?.map((e) => e?.toJson())?.toList()
    };
