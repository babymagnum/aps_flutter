import 'package:dio/dio.dart';

class AddPresenceRequest {

  AddPresenceRequest(this.checkpoint_id, this.presence_type, this.latitude, this.longitude);

  String checkpoint_id;
  String presence_type;
  String latitude;
  String longitude;

  FormData getBody() {
    return FormData.from({
      "checkpoint_id": checkpoint_id,
      "presence_type": presence_type,
      "latitude": latitude,
      "longitude": longitude,
    });
  }
}