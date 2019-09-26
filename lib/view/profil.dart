import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constant/Constant.dart';
import '../constant/ColorKey.dart';
import '../networking/service/information_networking.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'splash_screen.dart';
import '../model/getProfile/item_get_profile.dart';
import '../model/getProfile/get_profile.dart';
import '../networking/service/authentication_networking.dart';

class Profil extends StatefulWidget {
  Profil(this.isDetailKaryawan, this.itemProfile);
  
  bool isDetailKaryawan;
  ItemGetProfile itemProfile;
  
  @override
  ProfilState createState() => ProfilState(isDetailKaryawan, itemProfile);
}

class ProfilState extends State<Profil> {
  ProfilState(this.isDetailKaryawan, this.itemProfile);
  
  ItemGetProfile itemProfile;
  bool isDetailKaryawan;
  SharedPreferences preference;

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((SharedPreferences mPreference) {
      preference = mPreference;
      
      if (isDetailKaryawan) {
        getProfileByEmpId();
      } else {
        getProfile();
      }
    });
  }

  showLoading() {
    showDialog(context: context, builder: (BuildContext context) => dialogLoading());
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

  getProfileByEmpId() async {
    showLoading();
    var profile = await InformationNetworking().getProfileByEmpId(itemProfile.emp_id);
    hideLoading();
    setProfileView(profile);
  }
  
  setProfileView(GetProfile profile){
    if (profile.status == 200) {
      final mProfile = profile.data[0];
      itemProfile = mProfile;
      setState(() {});
    } else if (profile.status == 401) {
      preference.setString(Constant.IS_LOGIN, "false");
      Fluttertoast.showToast(msg: "Session anda berakhir");
      Navigator.of(context).popUntil(ModalRoute.withName('/'));
    } else {
      Fluttertoast.showToast(msg: profile.message);
    }
  }
  
  getProfile() async {
    showLoading();
    var profile = await InformationNetworking().getProfile();
    hideLoading();
    setProfileView(profile);
  }

  logout() async {
    showLoading();
    var logout = await AuthenticationNetworking().logout();
    hideLoading();

    if (logout.status == 200) {
      preference.setString(Constant.IS_LOGIN, "false");
      Fluttertoast.showToast(msg: "Session anda berakhir");
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => RootView()),
          (Route<dynamic> route) => false);
    } else if (logout.status == 401) {
      preference.setString(Constant.IS_LOGIN, "false");
      Fluttertoast.showToast(msg: "Session anda berakhir");
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => RootView()),
          (Route<dynamic> route) => false);
    } else {
      Fluttertoast.showToast(msg: logout.message);
    }
  }

  Widget body() => SingleChildScrollView(
        child: Column(
          children: <Widget>[wImageTop(), wInformation(), wAction()],
        ),
      );

  Widget wImageTop() => Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 160,
            decoration: BoxDecoration(
              image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("${Constant.image}profilBackground.png"))),
          ),
          Container(
            height: 160,
            color: Color(ColorKey.black).withOpacity(0.85),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(top: 16, bottom: 20.1),
              child: Column(
                children: <Widget>[
                  Container(
                    width: 67.6,
                    height: 67.6,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.fill, image: NetworkImage(itemProfile.img))),
                  ),
                  SizedBox(
                    height: 16.2,
                  ),
                  Text(
                    itemProfile.emp_name,
                    style: TextStyle(
                        fontFamily: "Roboto", fontSize: 9, color: Colors.white),
                  ),
                  SizedBox(
                    height: 4.1,
                  ),
                  Text(
                    itemProfile.position,
                    style: TextStyle(
                        fontFamily: "Roboto", fontSize: 9, color: Colors.white),
                  ),
                  SizedBox(
                    height: 4.1,
                  ),
                  Text(
                    itemProfile.unit,
                    style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 8,
                        color: Color(ColorKey.darkSkyBlue)),
                  ),
                ],
              ),
            ),
          )
        ],
      );

  Widget wInformation() => Container(
        margin: EdgeInsets.only(left: 14.2, right: 14.2, top: 16, bottom: 18.7),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(3)),
            boxShadow: [
              BoxShadow(color: Colors.black12, spreadRadius: 2, blurRadius: 4)
            ]),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: Padding(
                    child: Text("NIK", style: TextStyle(color: Color(ColorKey.brownishGrey), fontSize: 10, fontFamily: "Roboto", fontWeight: FontWeight.w700),),
                    padding: EdgeInsets.only(left: 15.1, top: 9, bottom: 9)),
                ),
                Expanded(
                    child: Padding(
                        child: Text(itemProfile.nik, style: TextStyle(color: Color(ColorKey.brownishGrey), fontSize: 10, fontFamily: "Roboto", fontWeight: FontWeight.w400)),
                        padding:
                            EdgeInsets.only(left: 15.1, top: 9, bottom: 9))),
              ],
            ),
            Container(
              height: 1,
              color: Colors.black12,
            ),
            Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: Padding(
                    child: Text("Lokasi Kerja", style: TextStyle(color: Color(ColorKey.brownishGrey), fontSize: 10, fontFamily: "Roboto", fontWeight: FontWeight.w700),),
                    padding: EdgeInsets.only(left: 15.1, top: 9, bottom: 9)),
                ),
                Expanded(
                  child: Padding(
                    child: Text(itemProfile.workarea, style: TextStyle(color: Color(ColorKey.brownishGrey), fontSize: 10, fontFamily: "Roboto", fontWeight: FontWeight.w400)),
                    padding:
                    EdgeInsets.only(left: 15.1, top: 9, bottom: 9))),
              ],
            ),
            Container(
              height: 1,
              color: Colors.black12,
            ),
            Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: Padding(
                    child: Text("Email", style: TextStyle(color: Color(ColorKey.brownishGrey), fontSize: 10, fontFamily: "Roboto", fontWeight: FontWeight.w700),),
                    padding: EdgeInsets.only(left: 15.1, top: 9, bottom: 9)),
                ),
                Expanded(
                  child: Padding(
                    child: Text(itemProfile.email, style: TextStyle(color: Color(ColorKey.brownishGrey), fontSize: 10, fontFamily: "Roboto", fontWeight: FontWeight.w400)),
                    padding:
                    EdgeInsets.only(left: 15.1, top: 9, bottom: 9))),
              ],
            ),
            Container(
              height: 1,
              color: Colors.black12,
            ),
            Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: Padding(
                    child: Text("Telepon", style: TextStyle(color: Color(ColorKey.brownishGrey), fontSize: 10, fontFamily: "Roboto", fontWeight: FontWeight.w700),),
                    padding: EdgeInsets.only(left: 15.1, top: 9, bottom: 9)),
                ),
                Expanded(
                  child: Padding(
                    child: Text(itemProfile.phone, style: TextStyle(color: Color(ColorKey.brownishGrey), fontSize: 10, fontFamily: "Roboto", fontWeight: FontWeight.w400)),
                    padding:
                    EdgeInsets.only(left: 15.1, top: 9, bottom: 9))),
              ],
            ),
            Container(
              height: 1,
              color: Colors.black12,
            ),
          ],
        ),
      );

  showDialogKeluar() {
    showDialog(context: context, builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Dialog(
          elevation: 0.2,
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5))
            ),
            height: 106,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("Yakin ingin keluar dari aplikasi APS?", textAlign: TextAlign.center,),
                ),
                Container(
                  height: 1,
                  color: Colors.black12,
                ),
                InkWell(
                  onTap: () => logout(),
                  child: Padding(
                    child: Text("Ya"),
                    padding: EdgeInsets.all(5)
                  ),
                ),
                Container(
                  height: 1,
                  color: Colors.black12,
                ),
                InkWell(
                  onTap: () => Navigator.of(context, rootNavigator: true).pop(),
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Text("Tidak"),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget wAction() => Visibility(
    visible: !isDetailKaryawan,
    child: Container(
      margin: EdgeInsets.only(left: 14.2, right: 14.2, bottom: 16),
      child: Column(
        children: <Widget>[
          InkWell(
            child: Padding(
              padding: EdgeInsets.only(top: 9, bottom: 9, left: 15, right: 15),
              child: Row(
                children: <Widget>[
                  Image.asset("${Constant.image}icUbahKataSandi.png", width: 11.7, height: 13.3,),
                  SizedBox(width: 7),
                  Expanded(
                    child: Text("Ubah Kata Sandi", style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w500, color: Color(ColorKey.brownishGrey), fontSize: 10),)
                  ),
                  Image.asset("${Constant.image}icExpandMore.png", width: 18, height: 18,),
                ],
              ),
            ),
          ),
          Container(
            height: 1,
            color: Colors.black12,
          ),
          InkWell(
            onTap: () => showDialogKeluar(),
            child: Padding(
              padding: EdgeInsets.only(top: 9, bottom: 9, left: 15, right: 15),
              child: Row(
                children: <Widget>[
                  Image.asset("${Constant.image}icLogout.png", width: 11.7, height: 13.3,),
                  SizedBox(width: 7),
                  Expanded(
                    child: Text("Keluar", style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w500, color: Color(ColorKey.brownishGrey), fontSize: 10),)
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(3)),
        boxShadow: [BoxShadow(
          color: Colors.black12,
          spreadRadius: 2,
          blurRadius: 5
        )]
      ),
    )
  );
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Color(ColorKey.default_bg),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: <Widget>[
              Visibility(
                visible: isDetailKaryawan,
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Image.asset("${Constant.image}icBack.png", width: 9.1, height: 16,),
                )
              ),
              Visibility(
                visible: isDetailKaryawan,
                child: SizedBox(width: 14.9,)
              ),
              Text(
                isDetailKaryawan ? "Detail Karyawan" : "Profil",
                style: TextStyle(fontSize: 12, fontFamily: "Roboto", fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
        body: body(),
      ),
      onWillPop: () async {
        if (itemProfile != null) {
          print("back button");
          Navigator.of(context).pop();
          return false;
        } else {
          return true;
        }
      }
    );
  }
}
