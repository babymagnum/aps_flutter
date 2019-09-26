import 'package:flutter/material.dart';
import 'package:flutter_playground/networking/request/get_presence_list_request.dart';
import '../constant/Constant.dart';
import '../constant/ColorKey.dart';
import 'splash_screen.dart';
import '../model/getPresenceList/item_get_presence_list.dart';
import '../networking/service/information_networking.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DaftarPresensi extends StatefulWidget {
  @override
  DaftarPresensiState createState() => DaftarPresensiState();
}

class DaftarPresensiState extends State<DaftarPresensi> {

  // properties
  SharedPreferences preference;
  var listPresensi = List<ItemGetPresenceList>();
  var month = "";
  var year = "";

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((SharedPreferences preferences) {
      preferences = preferences;
      getPresenceList();
    });
  }

  getPresenceList() async {
    showLoading();
    var presence = await InformationNetworking().getPresenceList(GetPresenceListRequest(month, year));
    hideDialog();
    if (presence.status == 200) {
      listPresensi = presence.data;
      setState(() {});
    } else if (presence.status == 401) {
      preference.setString(Constant.IS_LOGIN, "false");
      Fluttertoast.showToast(msg: "Session anda berakhir");
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => RootView()),
          (Route<dynamic> route) => false);
    } else {
      Fluttertoast.showToast(msg: presence.message);
    }
  }

  showBottomSheetFilter() {

  }

  showLoading() {
    showDialog(context: context, builder: (BuildContext context) => dialogLoading());
  }

  hideDialog() {
    Navigator.of(context, rootNavigator: true).pop();
  }

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

  Widget body() => ListView.builder(
    physics: BouncingScrollPhysics(),
    itemCount: listPresensi.length,
    itemBuilder: (context, index) => wItemPresensi(index, listPresensi[index])
  );

  Widget wItemPresensi(int position, ItemGetPresenceList item) => Container(
    margin: EdgeInsets.only(top: position == 0 ? 18 : 16, left: 16, right: 16, bottom: position == listPresensi.length - 1 ? 20 : 0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(3)),
      boxShadow: [BoxShadow(
        color: Colors.black12,
        blurRadius: 4,
        spreadRadius: 2
      )]
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 11,),
          Text(item.date, style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w500, color: Color(ColorKey.veryLightPinkFive), fontSize: 10),),
          SizedBox(height: 18,),
          Row(
            children: <Widget>[
              Container(
                width: (MediaQuery.of(context).size.width - 32 - 30) * 0.5,
                child: Text("Jam Masuk", style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w400, color: Color(ColorKey.greyishBrown), fontSize: 10),),
              ),
              Expanded(
                child: Text("Masuk", style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w400, color: Color(ColorKey.tanGreen), fontSize: 10),),
              )
            ],
          ),
          SizedBox(height: 4,),
          Row(
            children: <Widget>[
              Container(
                width: (MediaQuery.of(context).size.width - 32 - 30) * 0.5,
                child: Text(item.shift_start == "" ? "-" : item.shift_start, style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w700, color: Color(ColorKey.greyishBrown), fontSize: 10),),
              ),
              Expanded(
                child: Text(item.date_in == "" ? "-" : item.date_in, style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w700, color: Color(ColorKey.greyishBrown), fontSize: 10),)
              )
            ],
          ),
          SizedBox(height: 11,),
          Row(
            children: <Widget>[
              Container(
                width: (MediaQuery.of(context).size.width - 32 - 30) * 0.5,
                child: Text("Jam Pulang", style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w400, color: Color(ColorKey.greyishBrown), fontSize: 10),),
              ),
              Expanded(
                child: Text("Pulang", style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w400, color: Color(ColorKey.tanGreen), fontSize: 10),),
              )
            ],
          ),
          SizedBox(height: 4,),
          Row(
            children: <Widget>[
              Container(
                width: (MediaQuery.of(context).size.width - 32 - 30) * 0.5,
                child: Text(item.shift_end == "" ? "-" : item.shift_end, style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w700, color: Color(ColorKey.greyishBrown), fontSize: 10),),
              ),
              Expanded(
                child: Text(item.date_out == "" ? "-" : item.date_out, style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w700, color: Color(ColorKey.greyishBrown), fontSize: 10),)
              )
            ],
          ),
          Visibility(
            visible: item.presence_status == "" ? true : false,
            child: SizedBox(height: 13,),
          ),
          Visibility(
            visible: item.presence_status == "" ? false : true,
            child: Container(
              margin: EdgeInsets.only(top: 21, bottom: 13),
              decoration: BoxDecoration(
                //color: Colors.redAccent,
                color: Color(int.parse("${item.presence_status_bg_color}".replaceAll("#", "0xff"))),
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 6, bottom: 6, left: 10, right: 10),
                child: Text(item.presence_status, style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w400, fontSize: 10, color: Colors.white),),
              ),
            ),
          )
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        canvasColor: Colors.transparent
      ),
      child: Scaffold(
        backgroundColor: Color(ColorKey.default_bg),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: <Widget>[
              InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Image.asset("${Constant.image}icBack.png", width: 9.1, height: 16,),
              ),
              SizedBox(width: 14.9,),
              Expanded(
                child: Text(
                  "Daftar Karyawan",
                  style: TextStyle(fontSize: 12, fontFamily: "Roboto", fontWeight: FontWeight.w500),
                )
              ),
              InkWell(
                onTap: () => showBottomSheetFilter(),
                child: Image.asset("${Constant.image}icFilter.png", width: 16, height: 16,),
              )
            ],
          ),
        ),
        body: body(),
      )
    );
  }
}
