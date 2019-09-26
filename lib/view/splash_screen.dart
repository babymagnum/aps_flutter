import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant/Constant.dart';
import 'main.dart';
import 'login.dart';

void main() => runApp(RootView());

class RootView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((SharedPreferences preference) {
      Timer(Duration(seconds: 2), () => {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => preference.getString(Constant.IS_LOGIN) == "true" ? MainApp() : Login()))
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Text("Splash Screen"),
                )
              )
            ],
          ),
        )),
    );
  }
}
