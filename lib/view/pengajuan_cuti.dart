import 'package:flutter/material.dart';

class PengajuanCuti extends StatefulWidget {
  PengajuanCuti({this.testPassData});

  String testPassData;

  @override
  State<StatefulWidget> createState() => PengajuanCutiState(data: testPassData);
}

class PengajuanCutiState extends State<PengajuanCuti> {
  PengajuanCutiState({this.data});

  String data;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  color: Color(0xfffafafa),
                  borderRadius: BorderRadius.all(Radius.circular(25 / 2))),
              ),
              Container(
                child: Text(
                  "Wayan Sanjaya",
                  style: TextStyle(fontSize: 12, fontFamily: "Roboto"),
                ),
                margin: EdgeInsets.only(left: 10),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[],
          ),
        ),
      ),
    );
  }
}
