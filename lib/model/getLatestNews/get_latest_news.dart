import 'package:json_annotation/json_annotation.dart';
import 'item_latest_news.dart';

part 'get_latest_news.g.dart';

@JsonSerializable(explicitToJson: true)
class GetLatestNews {
    GetLatestNews(this.status, this.message, this.data);

    int status;
    String message;
    List<ItemLatestNews> data;

    factory GetLatestNews.fromJson(Map<String, dynamic> json) => _$GetLatestNewsFromJson(json);
    Map<String, dynamic> toJson() => _$GetLatestNewsToJson(this);
}