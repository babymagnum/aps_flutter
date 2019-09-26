import 'package:json_annotation/json_annotation.dart';
import 'item_get_presence_list.dart';

part 'get_presence_list.g.dart';

@JsonSerializable(explicitToJson: true)
class GetPresenceList {

  GetPresenceList(this.status, this.message, this.data);

  int status;
  String message;
  List<ItemGetPresenceList> data;

  factory GetPresenceList.fromJson(Map<String, dynamic> json) => _$GetPresenceListFromJson(json);
  Map<String, dynamic> toJson() => _$GetPresenceListToJson(this);
}