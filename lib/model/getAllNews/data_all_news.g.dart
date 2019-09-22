// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_all_news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataAllNews _$DataAllNewsFromJson(Map<String, dynamic> json) {
  return DataAllNews(
      json['total_page'] as int,
      (json['news'] as List)
          ?.map((e) => e == null
              ? null
              : ItemLatestNews.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$DataAllNewsToJson(DataAllNews instance) =>
    <String, dynamic>{
      'total_page': instance.total_page,
      'news': instance.news?.map((e) => e?.toJson())?.toList()
    };
