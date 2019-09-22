import 'package:dio/dio.dart';

class GetAllNewsRequest {
    GetAllNewsRequest(this.page);

    int page;

    FormData body() {
        return FormData.from({
            "page": "$page"
        });
    }
}