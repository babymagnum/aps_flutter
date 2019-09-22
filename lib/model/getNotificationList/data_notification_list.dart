import 'package:json_annotation/json_annotation.dart';
import 'item_notification_list.dart';

part 'data_notification_list.g.dart';

@JsonSerializable(explicitToJson: true)
class DataNotificationList {
  
  DataNotificationList(this.total_page, this.notification);
  
  int total_page;
  List<ItemNotificationList> notification;

  factory DataNotificationList.fromJson(Map<String, dynamic> json) => _$DataNotificationListFromJson(json);
  Map<String, dynamic> toJson() => _$DataNotificationListToJson(this);
}
