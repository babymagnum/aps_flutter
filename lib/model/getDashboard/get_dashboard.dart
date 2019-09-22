import 'package:json_annotation/json_annotation.dart';
import 'item_dashboard.dart';

part 'get_dashboard.g.dart';

@JsonSerializable(explicitToJson: true)
class GetDashboard {
    GetDashboard(this.status, this.message, this.data);

    int status;
    String message;
    List<ItemDashboard> data;

    factory GetDashboard.fromJson(Map<String, dynamic> json) => _$GetDashboardFromJson(json);
    Map<String, dynamic> toJson() => _$GetDashboardToJson(this);
}