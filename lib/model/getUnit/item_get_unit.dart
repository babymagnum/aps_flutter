import 'package:json_annotation/json_annotation.dart';

part 'item_get_unit.g.dart';

@JsonSerializable()
class ItemGetUnit {
  ItemGetUnit(this.unit_id, this.unit_name);
  
  String unit_id;
  String unit_name;

  factory ItemGetUnit.fromJson(Map<String, dynamic> json) => _$ItemGetUnitFromJson(json);
  Map<String, dynamic> toJson() => _$ItemGetUnitToJson(this);
}