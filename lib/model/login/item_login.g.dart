// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemLogin _$ItemLoginFromJson(Map<String, dynamic> json) {
  return ItemLogin(
      json['user_id'] as String,
      json['username'] as String,
      json['emp_id'] as String,
      json['emp_name'] as String,
      json['emp_number'] as String,
      json['emp_photo'] as String,
      json['token'] as String);
}

Map<String, dynamic> _$ItemLoginToJson(ItemLogin instance) => <String, dynamic>{
      'user_id': instance.user_id,
      'username': instance.username,
      'emp_id': instance.emp_id,
      'emp_name': instance.emp_name,
      'emp_number': instance.emp_number,
      'emp_photo': instance.emp_photo,
      'token': instance.token
    };
