import 'package:json_annotation/json_annotation.dart';
import 'item_emp_list.dart';

part 'data_emp_list.g.dart';

@JsonSerializable(explicitToJson: true)
class DataEmpList {
  
  DataEmpList(this.total_page, this.emp);
  
  int total_page;
  List<ItemEmpList> emp;

  factory DataEmpList.fromJson(Map<String, dynamic> json) => _$DataEmpListFromJson(json);
  Map<String, dynamic> toJson() => _$DataEmpListToJson(this);
}