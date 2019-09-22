import '../../constant/Constant.dart';
import 'base_service.dart';
import '../../model/getDashboard/get_dashboard.dart';
import '../../model/getLatestNews/get_latest_news.dart';
import '../../model/getAllNews/get_all_news.dart';
import 'package:dio/dio.dart';
import '../../model/getNotificationList/get_notification_list.dart';
import '../../model/getProfile/get_profile.dart';
import '../../model/getEmpList/get_emp_list.dart';
import '../../model/getUnit/get_unit.dart';
import '../../model/getWorkarea/get_workarea.dart';
import '../../model/getGender/get_gender.dart';
import '../../model/getOrder/get_order.dart';
import '../request/get_emp_list_request.dart';

class InformationNetworking extends BaseService {
  Future<GetDashboard> getDashboard() async {
    return await get("${Constant.base_url}api/getDashboard");
  }

  Future<GetLatestNews> getLatestNews() async {
    return await get("${Constant.base_url}api/getLatestNews");
  }

  Future<GetAllNews> getAllNews(int page) async {
    FormData body = FormData.from({"page": "$page"});
    return await postFormData("${Constant.base_url}api/getAllNews", body);
  }

  Future<GetNotificationList> getNotificationList(int page) async {
    FormData body = FormData.from({"page": "$page"});
    return await postFormData("${Constant.base_url}api/getNotificationList", body);
  }
  
  Future<GetProfile> getProfile() async {
    return await post("${Constant.base_url}api/getProfile");
  }
  
  Future<GetEmpList> getEmpList(GetEmpListRequest body) async {
    return await postFormData("${Constant.base_url}api/getEmpList", body.getBody());
  }
  
  Future<GetProfile> getProfileByEmpId(String empId) async {
    FormData body = FormData.from({"emp_id": empId});
    return await postFormData("${Constant.base_url}api/getProfileByEmpId", body);
  }
  
  Future<GetUnit> getUnit() async {
    return await get("${Constant.base_url}api/getUnit");
  }

  Future<GetWorkarea> getWorkarea() async {
    return await get("${Constant.base_url}api/getWorkarea");
  }

  Future<GetGender> getGender() async {
    return await get("${Constant.base_url}api/getGender");
  }

  Future<GetOrder> getOrder() async {
    return await get("${Constant.base_url}api/getOrder");
  }
}
