import 'package:json_annotation/json_annotation.dart';
import 'item_checkpoint.dart';

part 'data_get_prepare_presence.g.dart';

@JsonSerializable()
class DataGetPreparePresence {

  DataGetPreparePresence(this.data_checkpoint, this.is_presence_in, this.day, this.date,
    this.date_formated, this.time, this.shift_start, this.shift_end, this.timezone, this.zoom_maps);

  List<ItemCheckpoint> data_checkpoint;
  String is_presence_in;
  String day;
  String date;
  String date_formated;
  String time;
  String shift_start;
  String shift_end;
  String timezone;
  String zoom_maps;

  factory DataGetPreparePresence.fromJson(Map<String, dynamic> json) => _$DataGetPreparePresenceFromJson(json);
  Map<String, dynamic> toJson() => _$DataGetPreparePresenceToJson(this);
}