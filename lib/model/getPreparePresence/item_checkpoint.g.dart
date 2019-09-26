// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_checkpoint.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemCheckpoint _$ItemCheckpointFromJson(Map<String, dynamic> json) {
  return ItemCheckpoint(
      json['checkpoint_id'] as String,
      json['checkpoint_name'] as String,
      json['checkpoint_radius'] as String,
      json['checkpoint_latitude'] as String,
      json['checkpoint_longitude'] as String);
}

Map<String, dynamic> _$ItemCheckpointToJson(ItemCheckpoint instance) =>
    <String, dynamic>{
      'checkpoint_id': instance.checkpoint_id,
      'checkpoint_name': instance.checkpoint_name,
      'checkpoint_radius': instance.checkpoint_radius,
      'checkpoint_latitude': instance.checkpoint_latitude,
      'checkpoint_longitude': instance.checkpoint_longitude
    };
