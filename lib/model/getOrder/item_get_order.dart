import 'package:json_annotation/json_annotation.dart';

part 'item_get_order.g.dart';

@JsonSerializable()
class ItemGetOrder {
  
  ItemGetOrder(this.order, this.order_name);
  
  String order;
  String order_name;
  
  factory ItemGetOrder.fromJson(Map<String, dynamic> json) => _$ItemGetOrderFromJson(json);
  Map<String, dynamic> toJson() => _$ItemGetOrderToJson(this);
}