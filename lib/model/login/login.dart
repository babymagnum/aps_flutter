import 'package:json_annotation/json_annotation.dart';
import 'item_login.dart';

part 'login.g.dart';

@JsonSerializable(explicitToJson: true)
class Login {
    Login(this.status, this.message, this.data);

    int status;
    String message;
    List<ItemLogin> data;

    factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);
    Map<String, dynamic> toJson() => _$LoginToJson(this);
}

