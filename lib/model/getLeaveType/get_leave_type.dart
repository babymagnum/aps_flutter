import 'package:flutter_playground/model/getLeaveType/item_get_leave_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_leave_type.g.dart';

@JsonSerializable(explicitToJson: true)
class GetLeaveType {

  GetLeaveType(this.status, this.message, this.data);

  int status;
  String message;
  List<ItemGetLeaveType> data;

  factory GetLeaveType.fromJson(Map<String, dynamic> json) => _$GetLeaveTypeFromJson(json);
    Map<String, dynamic> toJson() => _$GetLeaveTypeToJson(this);
}