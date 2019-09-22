import 'package:json_annotation/json_annotation.dart';
import 'item_get_workarea.dart';

part 'get_workarea.g.dart';

@JsonSerializable(explicitToJson: true)
class GetWorkarea {
  
  GetWorkarea(this.status, this.message, this.data);
  
  int status;
  String message;
  List<ItemGetWorkarea> data;

  factory GetWorkarea.fromJson(Map<String, dynamic> json) => _$GetWorkareaFromJson(json);
  Map<String, dynamic> toJson() => _$GetWorkareaToJson(this);
}