// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetOrder _$GetOrderFromJson(Map<String, dynamic> json) {
  return GetOrder(
      json['status'] as int,
      json['message'] as String,
      (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : ItemGetOrder.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$GetOrderToJson(GetOrder instance) => <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data?.map((e) => e?.toJson())?.toList()
    };
