import 'package:json_annotation/json_annotation.dart';
import 'item_get_gender.dart';

part 'get_gender.g.dart';

@JsonSerializable(explicitToJson: true)
class GetGender {
  GetGender(this.status, this.message, this.data);
  
  int status;
  String message;
  List<ItemGetGender> data;
  
  factory GetGender.fromJson(Map<String, dynamic> json) => _$GetGenderFromJson(json);
  Map<String, dynamic> toJson() => _$GetGenderToJson(this);
}