import 'package:json_annotation/json_annotation.dart';
import 'data_emp_list.dart';

part 'get_emp_list.g.dart';

@JsonSerializable(explicitToJson: true)
class GetEmpList {
  
  GetEmpList(this.status, this.message, this.data);
  
  int status;
  String message;
  DataEmpList data;

  factory GetEmpList.fromJson(Map<String, dynamic> json) => _$GetEmpListFromJson(json);
  Map<String, dynamic> toJson() => _$GetEmpListToJson(this);
}