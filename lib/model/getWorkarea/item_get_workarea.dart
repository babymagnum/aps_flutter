import 'package:json_annotation/json_annotation.dart';

part 'item_get_workarea.g.dart';

@JsonSerializable()
class ItemGetWorkarea {
  
  ItemGetWorkarea(this.workarea_id, this.workarea_name);
  
  String workarea_id;
  String workarea_name;
  
  factory ItemGetWorkarea.fromJson(Map<String, dynamic> json) => _$ItemGetWorkareaFromJson(json);
  Map<String, dynamic> toJson() => _$ItemGetWorkareaToJson(this);
}