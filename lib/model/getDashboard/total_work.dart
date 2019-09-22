import 'package:json_annotation/json_annotation.dart';

part 'total_work.g.dart';

@JsonSerializable()
class TotalWork {

    TotalWork(this.total_work_achievement, this.total_work_hours);

    String total_work_achievement;
    String total_work_hours;

    factory TotalWork.fromJson(Map<String, dynamic> json) => _$TotalWorkFromJson(json);
    Map<String, dynamic> toJson() => _$TotalWorkToJson(this);
}