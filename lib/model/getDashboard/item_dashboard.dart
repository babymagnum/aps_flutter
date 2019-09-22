import 'package:json_annotation/json_annotation.dart';
import 'presence_today.dart';
import 'total_work.dart';

part 'item_dashboard.g.dart';

@JsonSerializable()
class ItemDashboard {
    ItemDashboard(this.presence_today, this.total_work, this.total_leave_quota);

    PresenceToday presence_today;
    TotalWork total_work;
    String total_leave_quota;

    factory ItemDashboard.fromJson(Map<String, dynamic> json) => _$ItemDashboardFromJson(json);
    Map<String, dynamic> toJson() => _$ItemDashboardToJson(this);
}