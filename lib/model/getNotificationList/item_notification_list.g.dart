// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_notification_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemNotificationList _$ItemNotificationListFromJson(Map<String, dynamic> json) {
  return ItemNotificationList(
      json['id'] as String,
      json['title'] as String,
      json['content'] as String,
      json['redirect'] as String,
      json['data_id'] as String,
      json['is_read'] as String,
      json['date'] as String);
}

Map<String, dynamic> _$ItemNotificationListToJson(
        ItemNotificationList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'redirect': instance.redirect,
      'data_id': instance.data_id,
      'is_read': instance.is_read,
      'date': instance.date
    };
