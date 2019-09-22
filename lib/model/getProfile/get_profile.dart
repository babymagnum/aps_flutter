import 'package:json_annotation/json_annotation.dart';
import 'item_get_profile.dart';

part 'get_profile.g.dart';

@JsonSerializable(explicitToJson: true)
class GetProfile {
  GetProfile(this.status, this.message, this.data);
  
  int status;
  String message;
  List<ItemGetProfile> data;
  
  factory GetProfile.fromJson(Map<String, dynamic> json) => _$GetProfileFromJson(json);
  Map<String, dynamic> toJson() => _$GetProfileToJson(this);
}