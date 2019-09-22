import 'package:json_annotation/json_annotation.dart';
import '../getLatestNews/item_latest_news.dart';

part 'data_all_news.g.dart';

@JsonSerializable(explicitToJson: true)
class DataAllNews {
    DataAllNews(this.total_page, this.news);

    int total_page;
    List<ItemLatestNews> news;

    factory DataAllNews.fromJson(Map<String, dynamic> json) => _$DataAllNewsFromJson(json);
    Map<String, dynamic> toJson() => _$DataAllNewsToJson(this);
}