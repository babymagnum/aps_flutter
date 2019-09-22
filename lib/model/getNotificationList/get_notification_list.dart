import 'package:json_annotation/json_annotation.dart';
import 'data_notification_list.dart';

part 'get_notification_list.g.dart';

@JsonSerializable(explicitToJson: true)
class GetNotificationList {

  GetNotificationList(this.status, this.message, this.data);
  
  int status;
  String message;
  DataNotificationList data;

  factory GetNotificationList.fromJson(Map<String, dynamic> json) => _$GetNotificationListFromJson(json);
  Map<String, dynamic> toJson() => _$GetNotificationListToJson(this);
}