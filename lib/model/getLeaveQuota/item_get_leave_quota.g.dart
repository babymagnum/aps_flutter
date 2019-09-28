// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_get_leave_quota.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemGetLeaveQuota _$ItemGetLeaveQuotaFromJson(Map<String, dynamic> json) {
  return ItemGetLeaveQuota(
      json['periode'] as String,
      json['quota'] as String,
      json['taken'] as String,
      json['sisa'] as String,
      json['expired'] as String);
}

Map<String, dynamic> _$ItemGetLeaveQuotaToJson(ItemGetLeaveQuota instance) =>
    <String, dynamic>{
      'periode': instance.periode,
      'quota': instance.quota,
      'taken': instance.taken,
      'sisa': instance.sisa,
      'expired': instance.expired
    };
