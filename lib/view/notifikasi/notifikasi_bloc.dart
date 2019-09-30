import 'package:bloc/bloc.dart';
import 'package:flutter_playground/model/getNotificationList/item_notification_list.dart';
import 'package:flutter_playground/networking/service/information_networking.dart';

enum NotifikasiEvent {
  GET_NOTIFICATION_LIST
}

class NotifikasiStateBloc {
  NotifikasiStateBloc({this.isLoading, this.listNotifikasi, this.isEmpty, this.isExpired, this.isError, this.errorMessage});

  bool isLoading;
  List<ItemNotificationList> listNotifikasi;
  bool isEmpty;
  bool isExpired;
  bool isError;
  String errorMessage;
}

class NotifikasiBloc extends Bloc<NotifikasiEvent, NotifikasiStateBloc> {
  int _currentPage = 0;
  int _totalPage = 1;
  List<ItemNotificationList> _listNotifikasi = List();

  @override
  NotifikasiStateBloc get initialState => NotifikasiStateBloc(isLoading: true, listNotifikasi: _listNotifikasi, isEmpty: false, isExpired: false, isError: false, errorMessage: "");

  @override
  Stream<NotifikasiStateBloc> mapEventToState(NotifikasiEvent event) async* {

    if (event == NotifikasiEvent.GET_NOTIFICATION_LIST) {

      if (_currentPage + 1 <= _totalPage) {
        yield NotifikasiStateBloc(isLoading: true, listNotifikasi: _listNotifikasi, isEmpty: _listNotifikasi.length == 0, isExpired: false, isError: false, errorMessage: "");

        var notifikasi = await InformationNetworking().getNotificationList(_currentPage);

        if (notifikasi.status == 200) {
          _currentPage += 1;
          _totalPage = notifikasi.data.total_page;
          _listNotifikasi.addAll(notifikasi.data.notification);
          yield NotifikasiStateBloc(isLoading: false, listNotifikasi: _listNotifikasi, isEmpty: _listNotifikasi.length == 0, isExpired: false, isError: false, errorMessage: "");
        } else if (notifikasi.status == 401) {
          yield NotifikasiStateBloc(isLoading: false, listNotifikasi: _listNotifikasi, isEmpty: _listNotifikasi.length == 0, isExpired: true, isError: false, errorMessage: "");
        } else {
          yield NotifikasiStateBloc(isLoading: false, listNotifikasi: _listNotifikasi, isEmpty: _listNotifikasi.length == 0, isExpired: false, isError: true, errorMessage: notifikasi.message);
        }
      }
    }
  }

  getNotificationList() => dispatch(NotifikasiEvent.GET_NOTIFICATION_LIST);
}