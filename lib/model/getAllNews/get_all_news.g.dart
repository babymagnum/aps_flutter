// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllNews _$GetAllNewsFromJson(Map<String, dynamic> json) {
  return GetAllNews(
      json['status'] as int,
      json['message'] as String,
      json['data'] == null
          ? null
          : DataAllNews.fromJson(json['data'] as Map<String, dynamic>));
}

Map<String, dynamic> _$GetAllNewsToJson(GetAllNews instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data?.toJson()
    };
