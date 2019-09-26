// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_presence_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPresenceList _$GetPresenceListFromJson(Map<String, dynamic> json) {
  return GetPresenceList(
      json['status'] as int,
      json['message'] as String,
      (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : ItemGetPresenceList.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$GetPresenceListToJson(GetPresenceList instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data?.map((e) => e?.toJson())?.toList()
    };
