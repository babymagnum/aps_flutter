import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant/Constant.dart';
import '../constant/ColorKey.dart';
import '../model/getNotificationList/item_notification_list.dart';
import '../networking/service/information_networking.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'splash_screen.dart';

class Notifikasi extends StatefulWidget {
  @override
  NotifikasiState createState() => NotifikasiState();
}

class NotifikasiState extends State<Notifikasi> {
  String notifikasiMessage = "Tidak ada notifikasi";
  SharedPreferences preferences;
  int currentPage = 0;
  int totalPage = 0;
  var listNotifikasi = List<ItemNotificationList>();
  bool isEmpty = true;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((SharedPreferences mPreference) {
      preferences = mPreference;
      showLoading();
      getNotifikasiList();
      _scrollController.addListener(scrollListener);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      setState(() {
        print("get more notification");
        showLoading();
        getNotifikasiList();
      });
    }
  }
  
  showLoading() {
    showDialog(context: context, builder: (BuildContext context) => dialogLoading());
  }

  Widget testWidget() => Container(
    child: Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: <Widget>[
          Text("test", style: TextStyle(),)
        ],
      ),
    ),
  );

  Widget dialogLoading() => Padding(
    padding: EdgeInsets.only(left: 65, right: 65),
    child: Dialog(
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
      backgroundColor: Colors.transparent,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
        ),
        child: Center(
          child: CircularProgressIndicator(
            valueColor:
            AlwaysStoppedAnimation<Color>(Color(ColorKey.aquaBlue)),
          ),
        ),
      ),
    ),
  );

  getNotifikasiList() async {
    var notification =
        await InformationNetworking().getNotificationList(currentPage);
    Navigator.of(context, rootNavigator: true).pop();
    
    if (notification.status == 200) {
      currentPage += 1;
      listNotifikasi.addAll(notification.data.notification);
      totalPage = notification.data.total_page;

      if (listNotifikasi.length == 0 &&
          notification.data.notification.length == 0) {
        isEmpty = true;
      } else {
        isEmpty = false;
      }

      setState(() {});
    } else if (notification.status == 401) {
      preferences.setString(Constant.IS_LOGIN, "false");
      Fluttertoast.showToast(msg: "Session anda berakhir");
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => SplashScreen()),
          ModalRoute.withName('/SplashScreen'));
    } else {
      Fluttertoast.showToast(msg: notification.message);
      setState(() {});
    }
  }

  Widget wNoNotifikasiView() => Visibility(
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
                notifikasiMessage,
                style: TextStyle(
                    color: Color(ColorKey.veryLightPinkThree),
                    fontSize: 12,
                    fontFamily: "Roboto"),
              )
            ],
          ),
        ),
      ));

  Widget wListNotifikasi(BuildContext context) => ListView.builder(
      controller: _scrollController,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: listNotifikasi.length,
      itemBuilder: (context, index) {
        return wItemListNotifikasi(listNotifikasi[index], index, context);
      });

  Widget wItemListNotifikasi(
          ItemNotificationList item, int position, BuildContext context) =>
      InkWell(
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

  Widget body() => SingleChildScrollView(
        child: Stack(
          children: <Widget>[wNoNotifikasiView(), wListNotifikasi(context)],
        ),
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
