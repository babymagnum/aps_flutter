import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_playground/view/base_view.dart';
import 'package:flutter_playground/view/notifikasi/notifikasi_bloc.dart';
import 'package:flutter_playground/view/notifikasi/notifikasi_event.dart';
import 'package:flutter_playground/view/notifikasi/notifikasi_state_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constant/Constant.dart';
import '../../constant/ColorKey.dart';
import '../../model/getNotificationList/item_notification_list.dart';
import '../../networking/service/information_networking.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../splash_screen.dart';

class Notifikasi extends StatefulWidget {
  @override
  NotifikasiState createState() => NotifikasiState();
}

class NotifikasiState extends State<Notifikasi> with BaseView {
  SharedPreferences _preferences;
  ScrollController _scrollController = ScrollController();
  final _notifikasiBloc = NotifikasiBloc();

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((SharedPreferences mPreference) {
      _preferences = mPreference;
      _notifikasiBloc.getNotificationList();
      _scrollController.addListener(scrollListener);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _notifikasiBloc.dispose();
    super.dispose();
  }

  scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _notifikasiBloc.getNotificationList();
    }
  }

  Widget wNoNotifikasiView(isEmpty, errorMessage) => Visibility(
      visible: isEmpty,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          margin: EdgeInsets.only(top: 100),
          child: Column(
            children: <Widget>[
              Image.asset(
                "${Constant.image}notifikasiNonActive.png",
                width: 26.6,
                height: 26.6,
              ),
              SizedBox(
                height: 11,
              ),
              Text(
                errorMessage,
                style: TextStyle(
                    color: Color(ColorKey.veryLightPinkThree),
                    fontSize: 12,
                    fontFamily: "Roboto"),
              )
            ],
          ),
        ),
      ));

  Widget wListNotifikasi(BuildContext context, List<ItemNotificationList> listNotifikasi) => ListView.builder(
      controller: _scrollController,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: listNotifikasi.length,
      itemBuilder: (context, index) {
        return wItemListNotifikasi(listNotifikasi, index, context);
      });

  Widget wItemListNotifikasi(List<ItemNotificationList> listNotifikasi, int position, BuildContext context) {
    final item = listNotifikasi[position];

    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(3)),
          boxShadow: [BoxShadow(
            color: Colors.black12,
            spreadRadius: 0.4,
            blurRadius: 2
          )]
        ),
        margin: EdgeInsets.only(
          top: position == 0 ? 20 : 13.3,
          left: 13.3,
          right: 13.3,
          bottom: position == listNotifikasi.length - 1 ? 20 : 0
        ),
        child: Padding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                item.title,
                style: TextStyle(
                  fontSize: 10,
                  color: Color(ColorKey.darkSkyBlue),
                  fontFamily: "Roboto"),
              ),
              SizedBox(
                height: 8.3,
              ),
              Text(
                item.date,
                style: TextStyle(
                  fontSize: 8,
                  color: Color(ColorKey.veryLightPinkFive),
                  fontFamily: "Roboto"),
              ),
              SizedBox(
                height: 10.7,
              ),
              Text(
                item.content,
                style: TextStyle(
                  fontSize: 11,
                  fontFamily: "Roboto",
                  color: Color(ColorKey.greyishBrown)),
              ),
            ],
          ),
          padding:
          EdgeInsets.only(left: 9.8, right: 9.8, top: 8.9, bottom: 9)),
      ),
    );
  }

  Widget body() => BlocBuilder(
    bloc: _notifikasiBloc,
    builder: (context, NotifikasiStateBloc notifikasiState) {
      if (notifikasiState.isExpired)
        forceLogout(_preferences, context);
      else if (notifikasiState.isError)
        Fluttertoast.showToast(msg: notifikasiState.errorMessage);

      return Stack(
        children: <Widget>[wNoNotifikasiView(notifikasiState.isEmpty, notifikasiState.errorMessage), wListNotifikasi(context, notifikasiState.listNotifikasi)],
      );
    }
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(ColorKey.default_bg),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: <Widget>[
            Container(
              child: Text(
                "Notifikasi",
                style: TextStyle(fontSize: 12, fontFamily: "Roboto"),
              ),
            )
          ],
        ),
      ),
      body: body(),
    );
  }
}
