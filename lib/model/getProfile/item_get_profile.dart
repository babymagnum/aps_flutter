import 'package:json_annotation/json_annotation.dart';

part 'item_get_profile.g.dart';

@JsonSerializable()
class ItemGetProfile {
  ItemGetProfile(this.emp_id, this.emp_name, this.position, this.unit, this.nik, this.workarea, this.email, this.phone, this.img);
  
  String emp_id;
  String emp_name;
  String position;
  String unit;
  String nik;
  String workarea;
  String email;
  String phone;
  String img;

  factory ItemGetProfile.fromJson(Map<String, dynamic> json) => _$ItemGetProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ItemGetProfileToJson(this);
}