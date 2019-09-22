import 'package:json_annotation/json_annotation.dart';
import 'data_all_news.dart';

part 'get_all_news.g.dart';

@JsonSerializable(explicitToJson: true)
class GetAllNews {
    GetAllNews(this.status, this.message, this.data);

    int status;
    String message;
    DataAllNews data;

    factory GetAllNews.fromJson(Map<String, dynamic> json) => _$GetAllNewsFromJson(json);
    Map<String, dynamic> toJson() => _$GetAllNewsToJson(this);
}