// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_get_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemGetOrder _$ItemGetOrderFromJson(Map<String, dynamic> json) {
  return ItemGetOrder(json['order'] as String, json['order_name'] as String);
}

Map<String, dynamic> _$ItemGetOrderToJson(ItemGetOrder instance) =>
    <String, dynamic>{
      'order': instance.order,
      'order_name': instance.order_name
    };
