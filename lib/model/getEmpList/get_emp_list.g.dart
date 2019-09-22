// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_emp_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetEmpList _$GetEmpListFromJson(Map<String, dynamic> json) {
  return GetEmpList(
      json['status'] as int,
      json['message'] as String,
      json['data'] == null
          ? null
          : DataEmpList.fromJson(json['data'] as Map<String, dynamic>));
}

Map<String, dynamic> _$GetEmpListToJson(GetEmpList instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data?.toJson()
    };
