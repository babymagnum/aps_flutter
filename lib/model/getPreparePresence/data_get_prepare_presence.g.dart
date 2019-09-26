// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_get_prepare_presence.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataGetPreparePresence _$DataGetPreparePresenceFromJson(
    Map<String, dynamic> json) {
  return DataGetPreparePresence(
      (json['data_checkpoint'] as List)
          ?.map((e) => e == null
              ? null
              : ItemCheckpoint.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['is_presence_in'] as String,
      json['day'] as String,
      json['date'] as String,
      json['date_formated'] as String,
      json['time'] as String,
      json['shift_start'] as String,
      json['shift_end'] as String,
      json['timezone'] as String,
      json['zoom_maps'] as String);
}

Map<String, dynamic> _$DataGetPreparePresenceToJson(
        DataGetPreparePresence instance) =>
    <String, dynamic>{
      'data_checkpoint': instance.data_checkpoint,
      'is_presence_in': instance.is_presence_in,
      'day': instance.day,
      'date': instance.date,
      'date_formated': instance.date_formated,
      'time': instance.time,
      'shift_start': instance.shift_start,
      'shift_end': instance.shift_end,
      'timezone': instance.timezone,
      'zoom_maps': instance.zoom_maps
    };
