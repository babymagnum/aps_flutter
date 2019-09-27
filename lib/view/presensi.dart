import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_playground/model/getPreparePresence/data_get_prepare_presence.dart';
import 'package:flutter_playground/view/presensi_map.dart';
import '../constant/Constant.dart';
import '../constant/ColorKey.dart';

class Presensi extends StatefulWidget {

  Presensi(this.dataGetPreparePresence);

  DataGetPreparePresence dataGetPreparePresence;

  @override
  PresensiState createState() => PresensiState(dataGetPreparePresence);
}

class PresensiState extends State<Presensi> {

  PresensiState(this.presence);

  DataGetPreparePresence presence;

  var second = 0;
  var minute = 0;
  var hour = 0;
  var currentTime = "";
  var currentDate = "Senin\n01 Mei 2019";
  var shiftStart = "08:00";
  var shiftEnd = "17:00";

  @override
  void initState() {
    super.initState();
    startTimerAndSetView();
  }
  
  startTimerAndSetView() {
    final timeArray = presence.time.split(":");
    hour = int.parse(timeArray[0]);
    minute = int.parse(timeArray[1]);
    second = int.parse(timeArray[2]);
    currentDate = "${presence.day}\n${presence.date_formated}";
    shiftStart = presence.shift_start.substring(0, 5);
    shiftEnd = presence.shift_end.substring(0, 5);

    Timer.periodic(Duration(seconds: 1), (timer) {
      second += 1;

      if (second == 60) {
        second = 0;
        minute += 1;
      }

      if (minute == 60) {
        minute = 0;
        hour += 1;
      }

      if (hour == 24) {
        hour = 0;
      }

      currentTime = "${hour.toString().length == 1 ? "0$hour" : hour}:${minute.toString().length == 1 ? "0$minute" : minute}:${second.toString().length == 1 ? "0$second" : second} ${presence.timezone}";
      setState(() {});
    });
  }

  presenceMasuk() {
    if (presence.is_presence_in == "0") {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => PresensiMap(presence)));
    } else {
      showDialogPreparePresence("Anda sudah melakukan presensi masuk, silahkan melakukan presensi pulang.");
    }
  }

  presencePulang() {
    if (presence.is_presence_in == "1") {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => PresensiMap(presence)));
    } else {
      showDialogPreparePresence("Anda belum melakukan presensi masuk, silahkan melakukan presensi masuk terlebih dahulu.");
    }
  }

  showDialogPreparePresence(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialogPreparePresence(message);
      });
  }

  hideDialog() {
    Navigator.of(context, rootNavigator: true).pop();
  }

  Widget dialogPreparePresence(String message) => Dialog(
    elevation: 0.2,
    backgroundColor: Colors.transparent,
    child: Container(
      height: 325,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 62.1,
          ),
          Image.asset(
            "${Constant.image}icDialogCancel.png",
            height: 71,
            width: 71,
          ),
          SizedBox(
            height: 47.9,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(ColorKey.black)),
            ),
          ),
          SizedBox(
            height: 39.8,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: InkWell(
                  onTap: hideDialog,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.circular(5)),
                      color: Color(ColorKey.darkSkyBlue)),
                    margin: EdgeInsets.only(left: 22, right: 22),
                    child: Center(
                      child: Padding(
                        child: Text(
                          "OKE",
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                        ),
                        padding: EdgeInsets.only(top: 11, bottom: 11)),
                    ),
                  ),
                ))
            ],
          ),
          SizedBox(
            height: 23,
          )
        ],
      ),
    ),
  );

  Widget wBody() => Column(
    children: <Widget>[
      Expanded(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill, image: AssetImage("${Constant.image}icBackgroundPresensi.png")
                )
              ),
            ),
            Container(
              color: Color(ColorKey.black).withOpacity(0.6),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(currentTime, style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w500, fontSize: 23, color: Colors.white),),
                      SizedBox(height: 16.2,),
                      Text(currentDate, textAlign: TextAlign.center, style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w500, fontSize: 12, color: Colors.white),),
                      SizedBox(height: 23.3,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 28.6),
                        child: Stack(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    height: 35.6,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(35.6/2)),
                                      color: Color(ColorKey.paleGrey)
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            SizedBox(width: 28.4,),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text("jam masuk", style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w500, fontSize: 6, color: Color(ColorKey.darkSkyBlue)),),
                                                  Text(shiftStart, style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w500, fontSize: 12, color: Color(ColorKey.darkSkyBlue)),),
                                                ],
                                              )
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: <Widget>[
                                                  Text("jam pulang", style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w500, fontSize: 6, color: Color(ColorKey.brownishGrey)),),
                                                  Text(shiftEnd, style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w500, fontSize: 12, color: Color(ColorKey.brownishGrey)),),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 28.4,)
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                )
                              ],
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Image.asset("${Constant.image}icCircularClock.png", width: 37, height: 37,),
                            )
                          ],
                        ),
                    ),
                      SizedBox(height: 24.9,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 28.4),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: InkWell(
                                onTap: () => presenceMasuk(),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(ColorKey.tanGreen),
                                    borderRadius: BorderRadius.all(Radius.circular(6))
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 28.4, left: 18.1, right: 18.1, bottom: 20),
                                    child: Column(
                                      children: <Widget>[
                                        Image.asset("${Constant.image}icPresensiMasuk.png", height: 44.4, width: 44.4,),
                                        SizedBox(height: 6.2,),
                                        Text("Presensi Masuk", style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w500, fontSize: 11, color: Colors.white),)
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ),
                            SizedBox(width: 33.9,),
                            Expanded(
                              child: InkWell(
                                onTap: () => presencePulang(),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(ColorKey.coral),
                                    borderRadius: BorderRadius.all(Radius.circular(6))
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 28.4, left: 18.1, right: 18.1, bottom: 20),
                                    child: Column(
                                      children: <Widget>[
                                        Image.asset("${Constant.image}icPresensiPulang.png", height: 44.4, width: 44.4,),
                                        SizedBox(height: 6.2,),
                                        Text("Presensi Pulang", style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w500, fontSize: 11, color: Colors.white),)
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                )
              ],
            )
          ],
        ),
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        canvasColor: Colors.white
      ),
      child: Scaffold(
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
                  "Presensi",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w500),
                )
              )
            ],
          ),
        ),
        body: wBody(),
      ),
    );
  }
}
