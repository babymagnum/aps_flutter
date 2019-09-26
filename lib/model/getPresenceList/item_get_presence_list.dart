import 'package:json_annotation/json_annotation.dart';

part 'item_get_presence_list.g.dart';

@JsonSerializable()
class ItemGetPresenceList {

  ItemGetPresenceList(this.date, this.shift_start, this.shift_end, this.date_in, this.date_out, this.presence_status, this.presence_status_bg_color);

  String date;
  String shift_start;
  String shift_end;
  String date_in;
  String date_out;
  String presence_status;
  String presence_status_bg_color;

  factory ItemGetPresenceList.fromJson(Map<String, dynamic> json) => _$ItemGetPresenceListFromJson(json);
  Map<String, dynamic> toJson() => _$ItemGetPresenceListToJson(this);
}