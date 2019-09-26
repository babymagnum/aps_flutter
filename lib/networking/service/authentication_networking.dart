import 'package:dio/dio.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter_playground/networking/service/base_service.dart';
import 'dart:io' show Platform;
import '../../model/login/login.dart';
import '../../constant/Constant.dart';
import '../../model/success/success.dart';
import 'dart:convert';

class AuthenticationNetworking extends BaseService {
  Future<Login> login(String email, String password) async {
    String uniqueId;
    String phoneBrand;
    String phoneSeries;
    Login loginResponse;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      uniqueId = androidInfo.androidId;
      phoneBrand = androidInfo.brand;
      phoneSeries = androidInfo.model;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      uniqueId = iosInfo.identifierForVendor;
      phoneBrand = iosInfo.name;
      phoneSeries = iosInfo.model;
    }

    FormData formData = FormData.from(<String, dynamic>{
      "username": email,
      "password": password,
      "fcm": "aslkdjalksjd",
      "unique_id": uniqueId,
      "phone_brand": phoneBrand,
      "phone_series": phoneSeries
    });

    try {
      var response =
          await Dio().post("${Constant.base_url}api/login", data: formData);
      var loginResponseMap = jsonDecode(response.toString());
      loginResponse = Login.fromJson(loginResponseMap);
    } on DioError catch (e) {
      var loginErrorMap = jsonDecode(e.response.toString());
      loginResponse = Login.fromJson(loginErrorMap);
    }

    return loginResponse;
  }
  
  Future<Success> logout() async {
    return await post("${Constant.base_url}api/logout");
  }
}
