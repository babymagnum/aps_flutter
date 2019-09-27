import 'package:json_annotation/json_annotation.dart';
import 'data_get_prepare_presence.dart';
part 'get_prepare_presence.g.dart';

@JsonSerializable()
class GetPreparePresence {

  GetPreparePresence(this.status, this.message, this.data);

  int status;
  String message;
  DataGetPreparePresence data;

  factory GetPreparePresence.fromJson(Map<String, dynamic> json) => _$GetPreparePresenceFromJson(json);
  Map<String, dynamic> toJson() => _$GetPreparePresenceToJson(this);
}