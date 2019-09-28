import 'package:flutter_playground/view/splash_screen.dart';
import 'package:intl/intl.dart';
import '../constant/Constant.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import '../constant/ColorKey.dart';

mixin BaseView {
  
  showLoading(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => dialogLoading()
    );
  }

  hideDialog(context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  String dateTimeToString(pattern, DateTime dateTime) {
    DateFormat dateFormat = DateFormat(pattern);
    return dateFormat.format(dateTime);
  }

  DateTime stringToDateTime(stringDate, pattern) {
    DateFormat dateFormat = DateFormat(pattern);
    return dateFormat.parse(stringDate);
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

  forceLogout(preferences, context) {
    preferences.setString(Constant.IS_LOGIN, "false");
    Fluttertoast.showToast(msg: "Session anda berakhir");
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => RootView()),
        (Route<dynamic> route) => false);
  }
}