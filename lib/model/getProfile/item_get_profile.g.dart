// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_get_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemGetProfile _$ItemGetProfileFromJson(Map<String, dynamic> json) {
  return ItemGetProfile(
      json['emp_id'] as String,
      json['emp_name'] as String,
      json['position'] as String,
      json['unit'] as String,
      json['nik'] as String,
      json['workarea'] as String,
      json['email'] as String,
      json['phone'] as String,
      json['img'] as String);
}

Map<String, dynamic> _$ItemGetProfileToJson(ItemGetProfile instance) =>
    <String, dynamic>{
      'emp_id': instance.emp_id,
      'emp_name': instance.emp_name,
      'position': instance.position,
      'unit': instance.unit,
      'nik': instance.nik,
      'workarea': instance.workarea,
      'email': instance.email,
      'phone': instance.phone,
      'img': instance.img
    };
