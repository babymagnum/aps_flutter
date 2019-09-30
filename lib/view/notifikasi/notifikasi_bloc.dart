import 'package:bloc/bloc.dart';
import 'package:flutter_playground/model/getNotificationList/item_notification_list.dart';
import 'package:flutter_playground/networking/service/information_networking.dart';
import 'package:flutter_playground/view/notifikasi/notifikasi_state_bloc.dart';
import 'notifikasi_event.dart';

class NotifikasiBloc extends Bloc<NotifikasiEvent, NotifikasiStateBloc> {
  int currentPage = 0;
  int totalPage = 1;
  List<ItemNotificationList> listNotifikasi = List();
  bool isEmpty = false;
  bool isExpired = false;
  bool isError = false;
  String errorMessage = "";

  @override
  NotifikasiStateBloc get initialState => NotifikasiStateBloc.initialState();

  @override
  Stream<NotifikasiStateBloc> mapEventToState(NotifikasiEvent event) async* {

    if (event is GetNotificationList) {
      if (currentPage + 1 <= totalPage) {
        var notifikasi = await InformationNetworking().getNotificationList(currentPage);

        if (notifikasi.status == 200) {
          currentPage += 1;
          totalPage = notifikasi.data.total_page;
          listNotifikasi.addAll(notifikasi.data.notification);
          isEmpty = notifikasi.data.notification.length == 0;
        } else if (notifikasi.status == 401) {
          isExpired = true;
        } else {
          isError = true;
          errorMessage = notifikasi.message;
        }

        yield NotifikasiStateBloc.updateState(false, listNotifikasi, isEmpty, isExpired, isError, errorMessage);
      }
    }

  }

  getNotificationList() {
    dispatch(GetNotificationList());
  }
}