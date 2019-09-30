import 'package:flutter_playground/model/getNotificationList/item_notification_list.dart';

class NotifikasiStateBloc {

  NotifikasiStateBloc._({this.isLoading, this.listNotifikasi, this.isEmpty, this.isExpired, this.isError, this.errorMessage});

  bool isLoading;
  List<ItemNotificationList> listNotifikasi;
  bool isEmpty;
  bool isExpired;
  bool isError;
  String errorMessage;

  factory NotifikasiStateBloc.initialState() {
    return NotifikasiStateBloc._(listNotifikasi: List(), isEmpty: false, isExpired: false, isError: false, errorMessage: "");
  }

  factory NotifikasiStateBloc.loading(bool isLoading) {
    return NotifikasiStateBloc._(isLoading: isLoading);
  }

  factory NotifikasiStateBloc.updateState(bool isLoading, List<ItemNotificationList> listNotifikasi, bool isEmpty, bool isExpired, bool isError, String errorMessage) {
    return NotifikasiStateBloc._(isLoading: isLoading, listNotifikasi: listNotifikasi, isEmpty: isEmpty, isExpired: isExpired, isError: isError, errorMessage: errorMessage);
  }
}