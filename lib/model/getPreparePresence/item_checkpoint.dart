import 'package:json_annotation/json_annotation.dart';

part 'item_checkpoint.g.dart';

@JsonSerializable()
class ItemCheckpoint {

  ItemCheckpoint(this.checkpoint_id, this.checkpoint_name, this.checkpoint_radius, this.checkpoint_latitude, this.checkpoint_longitude);

  String checkpoint_id;
  String checkpoint_name;
  String checkpoint_radius;
  String checkpoint_latitude;
  String checkpoint_longitude;

  factory ItemCheckpoint.fromJson(Map<String, dynamic> json) => _$ItemCheckpointFromJson(json);
  Map<String, dynamic> toJson() => _$ItemCheckpointToJson(this);
}