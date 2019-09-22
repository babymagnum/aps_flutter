import 'package:json_annotation/json_annotation.dart';

part 'presence_today.g.dart';

@JsonSerializable()
class PresenceToday {
    PresenceToday(this.time, this.status, this.icon);

    String time;
    String status;
    String icon;

    factory PresenceToday.fromJson(Map<String, dynamic> json) => _$PresenceTodayFromJson(json);
    Map<String, dynamic> toJson() => _$PresenceTodayToJson(this);
}