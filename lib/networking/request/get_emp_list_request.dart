import 'package:dio/dio.dart';

class GetEmpListRequest {
  GetEmpListRequest(this.order, this.emp_name, this.unit_id, this.workarea_id, this.gender, this.page);
  
  String order;
  String emp_name;
  String unit_id;
  String workarea_id;
  String gender;
  String page;
  
  FormData getBody() {
    return FormData.from({
      "order": order,
      "emp_name": emp_name,
      "unit_id": unit_id,
      "workarea_id": workarea_id,
      "gender": gender,
      "page": page
    });
  }
}