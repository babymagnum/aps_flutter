import 'package:dio/dio.dart';

class GetPresenceListRequest {
  GetPresenceListRequest(this.month, this.year);

  String month;
  String year;

  FormData getBody() {
    return FormData.from({
      "month": month,
      "year":year
    });
  }
}