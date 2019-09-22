// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_latest_news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemLatestNews _$ItemLatestNewsFromJson(Map<String, dynamic> json) {
  return ItemLatestNews(json['id'] as String, json['title'] as String,
      json['date'] as String, json['img'] as String);
}

Map<String, dynamic> _$ItemLatestNewsToJson(ItemLatestNews instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'date': instance.date,
      'img': instance.img
    };
