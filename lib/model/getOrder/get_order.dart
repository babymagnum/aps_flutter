import 'package:json_annotation/json_annotation.dart';
import 'item_get_order.dart';

part 'get_order.g.dart';

@JsonSerializable(explicitToJson: true)
class GetOrder {
  
  GetOrder(this.status, this.message, this.data);
  
  int status;
  String message;
  List<ItemGetOrder> data;
  
  factory GetOrder.fromJson(Map<String, dynamic> json) => _$GetOrderFromJson(json);
  Map<String, dynamic> toJson() => _$GetOrderToJson(this);
}