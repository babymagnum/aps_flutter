import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constant/Constant.dart';
import 'dart:convert';
import '../../model/getLatestNews/get_latest_news.dart';
import '../../model/getDashboard/get_dashboard.dart';
import '../../model/login/login.dart';
import '../../model/getAllNews/get_all_news.dart';
import '../../model/getNotificationList/get_notification_list.dart';
import '../../model/getProfile/get_profile.dart';
import '../../model/getEmpList/get_emp_list.dart';
import '../../model/getUnit/get_unit.dart';
import '../../model/getWorkarea/get_workarea.dart';
import '../../model/getGender/get_gender.dart';
import '../../model/getOrder/get_order.dart';
import '../../model/success/success.dart';
import '../../model/getPreparePresence/get_prepare_presence.dart';
import '../../model/getPresenceList/get_presence_list.dart';

class BaseService {
  Future<Map<String, dynamic>> getHeaders() async {
    var prefs = await SharedPreferences.getInstance();
    var maps = Map<String, dynamic>();
    maps["Authorization"] = "Bearer ${prefs.getString(Constant.TOKEN)}";
    return maps;
  }

  Future<T> postFormData<T>(String url, FormData body) async {
    T resultResponse;

    try {
      var response = await Dio()
          .post(url, data: body, options: Options(headers: await getHeaders()));
      print("ResponseSuccess: ${response.toString()}");
      var responseMap = jsonDecode(response.toString());
      resultResponse = fromJson<T>(responseMap);
    } on DioError catch (e) {
      print("ResponseError: ${e.response.toString()}");
      var responseMap = jsonDecode(e.response.toString());
      resultResponse = fromJson<T>(responseMap);
    }

    return resultResponse;
  }

  Future<T> post<T>(String url) async {
    T resultResponse;

    try {
      var response =
          await Dio().post(url, options: Options(headers: await getHeaders()));
      print("ResponseSuccess: ${response.toString()}");
      var responseMap = jsonDecode(response.toString());
      resultResponse = fromJson<T>(responseMap);
    } on DioError catch (e) {
      print("ResponseError: ${e.response.toString()}");
      var responseMap = jsonDecode(e.response.toString());
      resultResponse = fromJson<T>(responseMap);
    }
    return resultResponse;
  }

  Future<T> postJsonBody<T>(String url, dynamic body) async {
    T resultResponse;

    try {
      var response = await Dio()
          .post(url, data: body, options: Options(headers: await getHeaders()));
      print("ResponseSuccess: ${response.toString()}");
      var responseMap = jsonDecode(response.toString());
      resultResponse = fromJson<T>(responseMap);
    } on DioError catch (e) {
      print("ResponseError: ${e.response.toString()}");
      var responseMap = jsonDecode(e.response.toString());
      resultResponse = fromJson<T>(responseMap);
    }
    return resultResponse;
  }

  Future<T> get<T>(String url) async {
    T resultResponse;

    try {
      var response =
          await Dio().get(url, options: Options(headers: await getHeaders()));
      print("ResponseSuccess: ${response.toString()}");
      var responseMap = jsonDecode(response.toString());
      resultResponse = fromJson<T>(responseMap);
    } on DioError catch (e) {
      print("ResponseError: ${e.response.toString()}");
      var responseMap = jsonDecode(e.response.toString());
      resultResponse = fromJson<T>(responseMap);
    }

    return resultResponse;
  }

  //from json object
  static T fromJson<T>(dynamic json) {
    if (json is Iterable) {
      return _fromJsonList<T>(json) as T;
    } else if (T == Login) {
      return Login.fromJson(json) as T;
    } else if (T == GetDashboard) {
      return GetDashboard.fromJson(json) as T;
    } else if (T == GetLatestNews) {
      return GetLatestNews.fromJson(json) as T;
    } else if (T == GetAllNews) {
      return GetAllNews.fromJson(json) as T;
    } else if (T == GetNotificationList) {
      return GetNotificationList.fromJson(json) as T;
    } else if (T == GetProfile) {
      return GetProfile.fromJson(json) as T;
    } else if (T == GetEmpList) {
      return GetEmpList.fromJson(json) as T;
    } else if (T == GetUnit) {
      return GetUnit.fromJson(json) as T;
    } else if (T == GetWorkarea) {
      return GetWorkarea.fromJson(json) as T;
    } else if (T == GetGender) {
      return GetGender.fromJson(json) as T;
    } else if (T == GetOrder) {
      return GetOrder.fromJson(json) as T;
    } else if (T == Success) {
      return Success.fromJson(json) as T;
    } else if (T == GetPreparePresence) {
      return GetPreparePresence.fromJson(json) as T;
    } else if (T == GetPresenceList) {
      return GetPresenceList.fromJson(json) as T;
    } else {
      throw Exception("Unknown class");
    }
  }

  //from json list
  static List<T> _fromJsonList<T>(List jsonList) {
    if (jsonList == null) {
      return null;
    }

    List<T> output = List();

    for (Map<String, dynamic> json in jsonList) {
      output.add(fromJson(json));
    }

    return output;
  }
}
