import 'package:json_annotation/json_annotation.dart';

part 'item_latest_news.g.dart';

@JsonSerializable()
class ItemLatestNews {
    ItemLatestNews(this.id, this.title, this.date, this.img);

    String id;
    String title;
    String date;
    String img;

    factory ItemLatestNews.fromJson(Map<String, dynamic> json) => _$ItemLatestNewsFromJson(json);
    Map<String, dynamic> toJson() => _$ItemLatestNewsToJson(this);
}