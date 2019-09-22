import 'package:json_annotation/json_annotation.dart';

part 'item_emp_list.g.dart';

@JsonSerializable()
class ItemEmpList {
  
  ItemEmpList(this.emp_id, this.emp_name, this.position, this.unit, this.img);
  
  String emp_id;
  String emp_name;
  String position;
  String unit;
  String img;
  
  factory ItemEmpList.fromJson(Map<String, dynamic> json) => _$ItemEmpListFromJson(json);
  Map<String, dynamic> toJson() => _$ItemEmpListToJson(this);
}