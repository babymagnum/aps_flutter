// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_get_presence_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemGetPresenceList _$ItemGetPresenceListFromJson(Map<String, dynamic> json) {
  return ItemGetPresenceList(
      json['date'] as String,
      json['shift_start'] as String,
      json['shift_end'] as String,
      json['date_in'] as String,
      json['date_out'] as String,
      json['presence_status'] as String,
      json['presence_status_bg_color'] as String);
}

Map<String, dynamic> _$ItemGetPresenceListToJson(
        ItemGetPresenceList instance) =>
    <String, dynamic>{
      'date': instance.date,
      'shift_start': instance.shift_start,
      'shift_end': instance.shift_end,
      'date_in': instance.date_in,
      'date_out': instance.date_out,
      'presence_status': instance.presence_status,
      'presence_status_bg_color': instance.presence_status_bg_color
    };
