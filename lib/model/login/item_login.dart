import 'package:json_annotation/json_annotation.dart';

part 'item_login.g.dart';

@JsonSerializable()
class ItemLogin {
    ItemLogin(this.user_id, this.username, this.emp_id, this.emp_name, this.emp_number,
        this.emp_photo, this.token);

    String user_id;
    String username;
    String emp_id;
    String emp_name;
    String emp_number;
    String emp_photo;
    String token;

    factory ItemLogin.fromJson(Map<String, dynamic> json) => _$ItemLoginFromJson(json);
    Map<String, dynamic> toJson() => _$ItemLoginToJson(this);
}