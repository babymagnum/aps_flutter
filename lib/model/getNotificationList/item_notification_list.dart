import 'package:json_annotation/json_annotation.dart';

part 'item_notification_list.g.dart';

@JsonSerializable()
class ItemNotificationList {
  ItemNotificationList(this.id, this.title, this.content, this.redirect, this.data_id, this.is_read, this.date);
  
  String id;
  String title;
  String content;
  String redirect;
  String data_id;
  String is_read;
  String date;

  factory ItemNotificationList.fromJson(Map<String, dynamic> json) => _$ItemNotificationListFromJson(json);
  Map<String, dynamic> toJson() => _$ItemNotificationListToJson(this);
}