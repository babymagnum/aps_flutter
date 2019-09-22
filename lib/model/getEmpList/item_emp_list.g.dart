// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_emp_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemEmpList _$ItemEmpListFromJson(Map<String, dynamic> json) {
  return ItemEmpList(
      json['emp_id'] as String,
      json['emp_name'] as String,
      json['position'] as String,
      json['unit'] as String,
      json['img'] as String);
}

Map<String, dynamic> _$ItemEmpListToJson(ItemEmpList instance) =>
    <String, dynamic>{
      'emp_id': instance.emp_id,
      'emp_name': instance.emp_name,
      'position': instance.position,
      'unit': instance.unit,
      'img': instance.img
    };
