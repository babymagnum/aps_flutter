import 'package:json_annotation/json_annotation.dart';

part 'item_get_gender.g.dart';

@JsonSerializable()
class ItemGetGender {
  ItemGetGender(this.gender, this.gender_name);
  
  String gender;
  String gender_name;
  
  factory ItemGetGender.fromJson(Map<String, dynamic> json) => _$ItemGetGenderFromJson(json);
  Map<String, dynamic> toJson() => _$ItemGetGenderToJson(this);
}