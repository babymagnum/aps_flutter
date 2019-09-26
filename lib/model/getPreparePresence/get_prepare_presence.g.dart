// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_prepare_presence.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPreparePresence _$GetPreparePresenceFromJson(Map<String, dynamic> json) {
  return GetPreparePresence(
      json['status'] as int,
      json['message'] as String,
      json['data'] == null
          ? null
          : DataGetPreparePresence.fromJson(
              json['data'] as Map<String, dynamic>));
}

Map<String, dynamic> _$GetPreparePresenceToJson(GetPreparePresence instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data?.toJson()
    };
