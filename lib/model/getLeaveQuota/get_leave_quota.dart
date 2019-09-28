import 'package:json_annotation/json_annotation.dart';
import 'item_get_leave_quota.dart';

part 'get_leave_quota.g.dart';

@JsonSerializable()
class GetLeaveQuota {

  GetLeaveQuota(this.status, this.message, this.data);

  int status;
  String message;
  List<ItemGetLeaveQuota> data;

  factory GetLeaveQuota.fromJson(Map<String, dynamic> json) => _$GetLeaveQuotaFromJson(json);
  Map<String, dynamic> toJson() => _$GetLeaveQuotaToJson(this);
}