import 'package:json_annotation/json_annotation.dart';

part 'item_get_leave_type.g.dart';

@JsonSerializable()
class ItemGetLeaveType {

  ItemGetLeaveType(this.id, this.code, this.type, this.name, this.is_day, this.days_count, this.is_range,
   this.is_reduced, this.is_backdated, this.is_salary_reduced, this.is_lampiran, this.work_period);

  String id;
  String code;
  String type;
  String name;
  String is_day;
  String days_count;
  String is_range;
  String is_reduced;
  String is_backdated;
  String is_salary_reduced;
  String is_lampiran;
  String work_period;

  factory ItemGetLeaveType.fromJson(Map<String, dynamic> json) => _$ItemGetLeaveTypeFromJson(json);
  Map<String, dynamic> toJson() => _$ItemGetLeaveTypeToJson(this);
}