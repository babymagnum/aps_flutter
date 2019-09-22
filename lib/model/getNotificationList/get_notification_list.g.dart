// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_notification_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetNotificationList _$GetNotificationListFromJson(Map<String, dynamic> json) {
  return GetNotificationList(
      json['status'] as int,
      json['message'] as String,
      json['data'] == null
          ? null
          : DataNotificationList.fromJson(
              json['data'] as Map<String, dynamic>));
}

Map<String, dynamic> _$GetNotificationListToJson(
        GetNotificationList instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data?.toJson()
    };
