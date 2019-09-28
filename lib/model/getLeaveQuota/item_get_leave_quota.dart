import 'package:json_annotation/json_annotation.dart';

part 'item_get_leave_quota.g.dart';

@JsonSerializable()
class ItemGetLeaveQuota {

  ItemGetLeaveQuota(this.periode, this.quota, this.taken, this.sisa, this.expired);

  String periode;
  String quota;
  String taken;
  String sisa;
  String expired;

  factory ItemGetLeaveQuota.fromJson(Map<String, dynamic> json) => _$ItemGetLeaveQuotaFromJson(json);
  Map<String, dynamic> toJson() => _$ItemGetLeaveQuotaToJson(this);
}