import 'package:json_annotation/json_annotation.dart';
import 'item_get_unit.dart';

part 'get_unit.g.dart';

@JsonSerializable(explicitToJson: true)
class GetUnit {
  GetUnit(this.status, this.message, this.data);
  
  int status;
  String message;
  List<ItemGetUnit> data;
  
  factory GetUnit.fromJson(Map<String, dynamic> json) => _$GetUnitFromJson(json);
  Map<String, dynamic> toJson() => _$GetUnitToJson(this);
}