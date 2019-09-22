// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_emp_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataEmpList _$DataEmpListFromJson(Map<String, dynamic> json) {
  return DataEmpList(
      json['total_page'] as int,
      (json['emp'] as List)
          ?.map((e) => e == null
              ? null
              : ItemEmpList.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$DataEmpListToJson(DataEmpList instance) =>
    <String, dynamic>{
      'total_page': instance.total_page,
      'emp': instance.emp?.map((e) => e?.toJson())?.toList()
    };
