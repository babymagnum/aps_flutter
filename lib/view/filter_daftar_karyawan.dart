import 'package:flutter/material.dart';
import '../constant/Constant.dart';
import '../constant/ColorKey.dart';
import '../networking/service/information_networking.dart';
import '../model/getUnit/item_get_unit.dart';
import '../model/getWorkarea/item_get_workarea.dart';
import '../model/getGender/item_get_gender.dart';
import '../model/getOrder/item_get_order.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'splash_screen.dart';

class FilterDaftarKaryawan extends StatefulWidget {
  @override
  FilterDaftarKaryawanState createState() => FilterDaftarKaryawanState();
}

class FilterDaftarKaryawanState extends State<FilterDaftarKaryawan> {
  SharedPreferences preferences;
  var listUnit = List<ItemGetUnit>();
  var listWorkarea = List<ItemGetWorkarea>();
  var listGender = List<ItemGetGender>();
  var listOrder = List<ItemGetOrder>();
  var name = "";
  ItemGetUnit unit;
  ItemGetWorkarea workarea;
  ItemGetGender gender;
  ItemGetOrder order;

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((SharedPreferences prefence) {
      preferences = prefence;
      getUnit();
      getWorkarea();
      getGender();
      getOrder();
    });
  }

  showLoading() {
    showDialog(
        context: context, builder: (BuildContext context) => dialogLoading());
  }

  hideLoading() {
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

  getWorkarea() async {
    showLoading();
    final workarea = await InformationNetworking().getWorkarea();
    hideLoading();
    if (workarea.status == 200) {
      listWorkarea = workarea.data;
      this.workarea = listWorkarea[0];
      setState(() {});
    } else if (workarea.status == 401) {
      preferences.setString(Constant.IS_LOGIN, "false");
      Fluttertoast.showToast(msg: "Session anda berakhir");
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => SplashScreen()),
        ModalRoute.withName('/SplashScreen'));
    } else {
      Fluttertoast.showToast(msg: workarea.message);
    }
  }

  getGender() async {
    showLoading();
    final gender = await InformationNetworking().getGender();
    hideLoading();
    if (gender.status == 200) {
      listGender = gender.data;
      this.gender = listGender[0];
      setState(() {});
    } else if (gender.status == 401) {
      preferences.setString(Constant.IS_LOGIN, "false");
      Fluttertoast.showToast(msg: "Session anda berakhir");
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => SplashScreen()),
        ModalRoute.withName('/SplashScreen'));
    } else {
      Fluttertoast.showToast(msg: gender.message);
    }
  }

  getOrder() async {
    showLoading();
    final order = await InformationNetworking().getOrder();
    hideLoading();
    if (order.status == 200) {
      listOrder = order.data;
      this.order = listOrder[0];
      setState(() {});
    } else if (order.status == 401) {
      preferences.setString(Constant.IS_LOGIN, "false");
      Fluttertoast.showToast(msg: "Session anda berakhir");
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => SplashScreen()),
        ModalRoute.withName('/SplashScreen'));
    } else {
      Fluttertoast.showToast(msg: order.message);
    }
  }

  getUnit() async {
    showLoading();
    final unit = await InformationNetworking().getUnit();
    hideLoading();
    if (unit.status == 200) {
      listUnit = unit.data;
      this.unit = listUnit[0];
      setState(() {});
    } else if (unit.status == 401) {
      preferences.setString(Constant.IS_LOGIN, "false");
      Fluttertoast.showToast(msg: "Session anda berakhir");
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => SplashScreen()),
          ModalRoute.withName('/SplashScreen'));
    } else {
      Fluttertoast.showToast(msg: unit.message);
    }
  }

  Widget dropDown<T>(List<T> list, T value) => Container(
        height: 37.3,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(3)),
            border: Border.all(color: Color(ColorKey.veryLightPink), width: 1)),
        child: Padding(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<T>(
                isExpanded: true,
                hint: Text("-- Semua  --"),
                icon: Icon(Icons.keyboard_arrow_down),
                value: value,
                onChanged: (T newValue) { dropDownChangeValue(newValue); },
                items: list.map((T unit) {
                  return DropdownMenuItem<T>(
                    value: unit,
                    child: Text(
                      setValue(unit),
                      style: TextStyle(
                        color: Color(ColorKey.veryLightPinkFive),
                        fontSize: 12,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w500),
                    ),
                  );
                }).toList(),
            )),
            padding: EdgeInsets.only(left: 16, right: 13)),
  );

  dropDownChangeValue<T>(T newValue) {
    if (newValue is ItemGetUnit) {
      setState(() { unit = newValue; });
    } else if (newValue is ItemGetGender) {
      setState(() { gender = newValue; });
    } else if (newValue is ItemGetWorkarea) {
      setState(() { workarea = newValue; });
    } else if (newValue is ItemGetOrder) {
      setState(() { order = newValue; });
    }
  }

  String setValue<T>(T value) {
    if (value is ItemGetUnit) {
      return value.unit_name;
    } else if (value is ItemGetOrder) {
      return value.order_name;
    } else if (value is ItemGetWorkarea) {
      return value.workarea_name;
    } else if (value is ItemGetGender) {
      return value.gender_name;
    }
  }

  Widget titleForm(String content) => Container(
        width: MediaQuery.of(context).size.width - 28.4,
        child: Text(
          content,
          style: TextStyle(
              fontSize: 12,
              color: Color(ColorKey.greyishBrown),
              fontFamily: "Roboto",
              fontWeight: FontWeight.w500),
        ),
      );

  Widget fieldName() => Container(
        height: 37.3,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(3)),
            border: Border.all(color: Color(ColorKey.veryLightPink), width: 1)),
        child: Padding(
            child: TextField(
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.emailAddress,
                autofocus: true,
                onChanged: (text) {
                  name = text;
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                style: TextStyle(
                    color: Color(ColorKey.brownishGrey),
                    fontSize: 12,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w500)),
            padding: EdgeInsets.symmetric(horizontal: 16)),
      );

  Widget body() => Container(
        margin: EdgeInsets.only(top: 15, left: 14.2, right: 14.2, bottom: 16.9),
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    titleForm("No / Name"),
                    SizedBox(height: 6.2,),
                    fieldName(),
                    SizedBox(height: 10.7,),
                    titleForm("Divisi"),
                    SizedBox(height: 6.2,),
                    dropDown(listUnit, unit),
                    SizedBox(height: 10.7,),
                    titleForm("Lokasi Kerja"),
                    SizedBox(height: 6.2,),
                    dropDown(listWorkarea, workarea),
                    SizedBox(height: 10.7,),
                    titleForm("Gender"),
                    SizedBox(height: 6.2,),
                    dropDown(listGender, gender),
                    SizedBox(height: 10.7,),
                    titleForm("Order by"),
                    SizedBox(height: 6.2,),
                    dropDown(listOrder, order),
                ],
              ),
            ),),
            containerButton()
          ],
        ),
      );

  Widget containerButton() => Container(
        child: Row(
          children: <Widget>[
            buttonReset(),
            SizedBox(
              width: 15.1,
            ),
            buttonTerapkan()
          ],
        ),
      );

  Widget buttonTerapkan() => Expanded(
          child: InkWell(
        onTap: () => sendDataBack(context),
        child: Container(
          height: 38.2,
          decoration: BoxDecoration(
            color: Color(ColorKey.darkSkyBlue),
            borderRadius: BorderRadius.all(Radius.circular(38.2 / 2)),
          ),
          child: Center(
            child: Text(
              "TERAPKAN",
              style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ));

  Widget buttonReset() => Expanded(
          child: InkWell(
        onTap: () => sendDataBack(context),
        child: Container(
          height: 38.2,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(38.2 / 2)),
              border: Border.all(width: 1, color: Color(ColorKey.darkSkyBlue))),
          child: Center(
            child: Text(
              "RESET",
              style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 12,
                  color: Color(ColorKey.brownishGrey),
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ));

  sendDataBack(BuildContext context) {
    var map = Map<String, String>();
    map["name"] = name;
    map["unit"] = unit.unit_id;
    map["workarea"] = workarea.workarea_id;
    map["gender"] = gender.gender;
    map["order"] = order.order;
    Navigator.of(context).pop(map);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        canvasColor: Colors.white
      ),
      child: Scaffold(
        backgroundColor: Color(ColorKey.default_bg),
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: <Widget>[
              InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Image.asset(
                  "${Constant.image}icBack.png",
                  width: 9.1,
                  height: 16,
                ),
              ),
              SizedBox(
                width: 14.9,
              ),
              Expanded(
                child: Text(
                  "Filter",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w500),
                ))
            ],
          ),
        ),
        body: body(),
      )
    );
  }
}
