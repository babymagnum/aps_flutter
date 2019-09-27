import 'package:flutter/material.dart';
import '../constant/Constant.dart';
import '../constant/ColorKey.dart';
import '../networking/service/authentication_networking.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'main.dart';
import 'dart:io';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<Login> {
  var email = "";
  var password = "";
  var nodePassword = FocusNode();
  var isLoading = false;

  //use to get data from server
  @override
  void initState() {
    super.initState();
  }

  login() async {
    isLoading = true;
    setState(() {});

    var login = await AuthenticationNetworking().login(email, password);

    isLoading = false;
    setState(() {});

    var prefs = await SharedPreferences.getInstance();

    //success
    if (login.status == 200) {
      final dataLogin = login.data[0];

      //save to preference
      prefs.setString(Constant.TOKEN, dataLogin.token);
      prefs.setString(Constant.NAME, dataLogin.emp_name);
      prefs.setString(Constant.IMAGE, dataLogin.emp_photo);
      prefs.setString(Constant.IS_LOGIN, "true");
      prefs.setInt(Constant.MENU1, 1);
      prefs.setInt(Constant.MENU2, 2);
      prefs.setInt(Constant.MENU3, 3);
      prefs.setInt(Constant.MENU4, 4);
      prefs.setInt(Constant.MENU5, 5);
      prefs.setInt(Constant.MENU6, 6);
      prefs.setInt(Constant.MENU7, 7);
      prefs.setInt(Constant.MENU8, 8);
      prefs.setInt(Constant.MENU9, 9);
      prefs.setInt(Constant.MENU10, 10);
      prefs.setInt(Constant.MENU11, 11);

      //navigate to main screen
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => MainApp()));
    } else {
      Fluttertoast.showToast(
          msg: login.message, gravity: ToastGravity.BOTTOM, fontSize: 14);
    }
  }

  // widget goes here
  Widget dialogLoading() => Visibility(
      visible: isLoading,
      child: Dialog(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        backgroundColor: Colors.transparent,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(ColorKey.aquaBlue)),
        ),
      ));

  Widget textFieldEmail() => Container(
        height: 37,
        margin: EdgeInsets.only(left: 24, right: 24, bottom: 21),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(37 / 2)),
            border: Border.all(color: Color(ColorKey.veryLightPink), width: 1)),
        child: Container(
          margin: EdgeInsets.only(left: 19.5, right: 19.5),
          child: TextField(
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(nodePassword);
            },
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            autofocus: true,
            onChanged: (text) {
              email = text;
            },
            style: TextStyle(
                color: Color(ColorKey.brownishGrey),
                fontSize: 12,
                fontWeight: FontWeight.w400,
                fontFamily: "Roboto"),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintMaxLines: 1,
              hintStyle: TextStyle(fontSize: 12, fontFamily: "Roboto", fontWeight: FontWeight.w400),
              hintText: "e.g ariefzainuri@gmail.com",
            ),
          ),
        ),
      );

  Widget textFieldPassword() => Container(
        height: 37,
        margin: EdgeInsets.only(left: 24, right: 24),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(37 / 2)),
            border: Border.all(color: Color(ColorKey.veryLightPink), width: 1)),
        child: Container(
          margin: EdgeInsets.only(left: 19.5, right: 19.5),
          child: TextField(
            focusNode: nodePassword,
            textInputAction: TextInputAction.done,
            obscureText: true,
            keyboardType: TextInputType.text,
            autofocus: true,
            onChanged: (text) {
              password = text;
            },
            style: TextStyle(
                color: Color(ColorKey.brownishGrey),
                fontSize: 12,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w400
              ),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintMaxLines: 1,
              hintStyle: TextStyle(fontSize: 12, fontFamily: "Roboto", fontWeight: FontWeight.w400),
              hintText: "input password...",
            ),
          ),
        ),
      );

  Widget buttonMasuk() => InkWell(
        onTap: () => login(),
        child: Container(
          height: 42.6,
          decoration: BoxDecoration(
              color: Color(ColorKey.darkSkyBlue),
              borderRadius: BorderRadius.all(Radius.circular(42.6 / 2))),
          margin: EdgeInsets.only(left: 24, right: 24, top: 17.7),
          child: Center(
            child: Text(
              "MASUK",
              style: TextStyle(
                  fontSize: 12, fontFamily: "Roboto", fontWeight: FontWeight.w700, color: Colors.white),
            ),
          ),
        ),
      );

  Widget toast() {}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Color(ColorKey.default_bg),
        resizeToAvoidBottomPadding: true,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.416,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    image:
                    AssetImage("${Constant.image}imageLoginTop.png"))),
              ),
              Container(
                transform: Matrix4.translationValues(0, -60, 0),
                child: Image.asset(
                  "${Constant.image}logoAps.png",
                  height: 74.5,
                  width: 175,
                ),
              ),
              textFieldEmail(),
              textFieldPassword(),
              buttonMasuk(),
              dialogLoading()
            ],
          ),
        ),
      ),
      onWillPop: () async {
        exit(0);
        return false;
      }
    );
  }
}
