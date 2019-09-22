// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_notification_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataNotificationList _$DataNotificationListFromJson(Map<String, dynamic> json) {
  return DataNotificationList(
      json['total_page'] as int,
      (json['notification'] as List)
          ?.map((e) => e == null
              ? null
              : ItemNotificationList.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$DataNotificationListToJson(
        DataNotificationList instance) =>
    <String, dynamic>{
      'total_page': instance.total_page,
      'notification': instance.notification?.map((e) => e?.toJson())?.toList()
    };
