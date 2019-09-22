// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'presence_today.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PresenceToday _$PresenceTodayFromJson(Map<String, dynamic> json) {
  return PresenceToday(
      json['time'] as String, json['status'] as String, json['icon'] as String);
}

Map<String, dynamic> _$PresenceTodayToJson(PresenceToday instance) =>
    <String, dynamic>{
      'time': instance.time,
      'status': instance.status,
      'icon': instance.icon
    };
