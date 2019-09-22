// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_dashboard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemDashboard _$ItemDashboardFromJson(Map<String, dynamic> json) {
  return ItemDashboard(
      json['presence_today'] == null
          ? null
          : PresenceToday.fromJson(
              json['presence_today'] as Map<String, dynamic>),
      json['total_work'] == null
          ? null
          : TotalWork.fromJson(json['total_work'] as Map<String, dynamic>),
      json['total_leave_quota'] as String);
}

Map<String, dynamic> _$ItemDashboardToJson(ItemDashboard instance) =>
    <String, dynamic>{
      'presence_today': instance.presence_today,
      'total_work': instance.total_work,
      'total_leave_quota': instance.total_leave_quota
    };
