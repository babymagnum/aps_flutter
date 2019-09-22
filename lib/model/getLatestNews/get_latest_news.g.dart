// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_latest_news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetLatestNews _$GetLatestNewsFromJson(Map<String, dynamic> json) {
  return GetLatestNews(
      json['status'] as int,
      json['message'] as String,
      (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : ItemLatestNews.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$GetLatestNewsToJson(GetLatestNews instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data?.map((e) => e?.toJson())?.toList()
    };
