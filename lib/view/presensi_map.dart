import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_playground/model/getPreparePresence/data_get_prepare_presence.dart';
import 'package:flutter_playground/model/getPreparePresence/item_checkpoint.dart';
import 'package:flutter_playground/networking/request/add_presence_request.dart';
import 'package:flutter_playground/networking/service/information_networking.dart';
import 'package:flutter_playground/view/daftar_presensi.dart';
import 'package:flutter_playground/view/splash_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant/Constant.dart';
import '../constant/ColorKey.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PresensiMap extends StatefulWidget {

  PresensiMap(this.dataGetPreparePresence);

  DataGetPreparePresence dataGetPreparePresence;

  @override
  PresensiMapState createState() => PresensiMapState(dataGetPreparePresence);
}

class PresensiMapState extends State<PresensiMap> {

  // constructor
  PresensiMapState(this.presence);

  // properties
  DataGetPreparePresence presence;
  LocationData currentLocation;
  Location location = Location();
  var error = "";
  GoogleMapController mapController;
  Set<Marker> marker = {};
  Set<Circle> circles = {};
  BitmapDescriptor icon;
  var distance = 0.0;
  var second = 0;
  var minute = 0;
  var hour = 0;
  var currentTime = "";
  var currentDate = "Senin\n01 Mei 2019";
  var shiftStart = "08:00";
  var shiftEnd = "17:00";
  var checkpoint_id = "";
  var isInsideAnyPresence = false;
  var presenceType = "";
  SharedPreferences preference;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((mPreference) {
      preference = mPreference;
      startTimerAndSetView();
      BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(28, 35)), '${Constant.image}icMarkerMaps.png')
        .then((onValue) {
        icon = onValue;
      });
      getCurrentLocation();
      positionChangeListener();
    });
  }

  startTimerAndSetView() {
    final timeArray = presence.time.split(":");
    hour = int.parse(timeArray[0]);
    minute = int.parse(timeArray[1]);
    second = int.parse(timeArray[2]);
    currentDate = "${presence.day}\n${presence.date_formated}";
    shiftStart = presence.shift_start.substring(0, 5);
    shiftEnd = presence.shift_end.substring(0, 5);
    presenceType = presence.is_presence_in == "0" ? "in" : "out";

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

      currentTime = "${presence.date_formated} | ${hour.toString().length == 1 ? "0$hour" : hour}:${minute.toString().length == 1 ? "0$minute" : minute}:${second.toString().length == 1 ? "0$second" : second} ${presence.timezone}";
      setState(() {});
    });
  }

  addPresence() async {
    showLoading();
    var body = AddPresenceRequest(checkpoint_id, presenceType, currentLocation.latitude.toString(), currentLocation.longitude.toString());
    var success = await InformationNetworking().addPresence(body);
    hideDialog();

    if (success.status == 201) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => DaftarPresensi(true)));
    } else if (success.status == 401) {
      preference.setString(Constant.IS_LOGIN, "false");
      Fluttertoast.showToast(msg: "Session anda berakhir");
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => RootView()),
          (Route<dynamic> route) => false);
    } else {
      Fluttertoast.showToast(msg: success.message);
    }
  }

  Future<double> getDistance(LatLng current, LatLng destination) async {
    return await Geolocator().distanceBetween(current.latitude, current.longitude, destination.latitude, destination.longitude);
  }

  checkCoordinate() {
    circles.clear();
    presence.data_checkpoint.forEach((checkpoint) {
      getDistance(LatLng(currentLocation.latitude, currentLocation.longitude), LatLng(double.parse(checkpoint.checkpoint_latitude), double.parse(checkpoint.checkpoint_longitude))).then((userDistance) {
        if (userDistance < 50) {
          checkpoint_id = checkpoint.checkpoint_id;
          isInsideAnyPresence = true;
          drawSingleCircle(checkpoint.checkpoint_id, ColorKey.tanGreen, ColorKey.nastyGreen, LatLng(double.parse(checkpoint.checkpoint_latitude), double.parse(checkpoint.checkpoint_longitude)));
        } else {
          isInsideAnyPresence = false;
          drawSingleCircle(checkpoint.checkpoint_id, ColorKey.coral, ColorKey.coral, LatLng(double.parse(checkpoint.checkpoint_latitude), double.parse(checkpoint.checkpoint_longitude)));
        }
      });
    });
  }

  drawSingleCircle(String id, int solidColor, int strokeColor, LatLng latLng) {
    circles.add(
      Circle(
        circleId: CircleId(id),
        fillColor: Color(solidColor).withOpacity(0.6),
        strokeColor: Color(strokeColor).withOpacity(0.6),
        strokeWidth: 3,
        radius: 50,
        center: latLng
      )
    );
    circles.forEach((circle) {
      print("circle: ${circle.circleId}");
    });
    setState(() {});
  }

  showLoading() {
    showDialog(
      context: context, builder: (BuildContext context) => dialogLoading());
  }

  Widget containerBoxPresence() => Container(
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

  hideDialog() {
    Navigator.of(context, rootNavigator: true).pop();
  }

  positionChangeListener() {
    location.onLocationChanged().listen((LocationData currentLocation) {
      animateCamera(currentLocation.latitude, currentLocation.longitude);
      this.currentLocation = currentLocation;
      // give marker id 1, to make it not duplicate
      marker.add(Marker(
        markerId: MarkerId("1"),
        position: LatLng(currentLocation.latitude, currentLocation.longitude),
        icon: icon
      ));
      // populate circle
      checkCoordinate();
    });
  }

  animateCamera(latitude, longitude) {
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(latitude, longitude), zoom: double.parse(presence.zoom_maps))));
  }

  getCurrentLocation() async {
    showLoading();

    try {
      currentLocation = await location.getLocation();
      hideDialog();
      marker.add(
        Marker(
          markerId: MarkerId("1"),
          position: LatLng(currentLocation.latitude, currentLocation.longitude),
          icon: icon
        ));
      setState(() {});
      animateCamera(currentLocation.latitude, currentLocation.longitude);
      checkCoordinate();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      }
      currentLocation = null;
    }
  }

  gotoPresensiList() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => DaftarPresensi(false)));
  }

  Widget wClock() => Padding(
    padding: EdgeInsets.symmetric(horizontal: 30),
    child: Stack(
      children: <Widget>[
        Container(
          height: 35.6,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Color(ColorKey.darkSkyBlue)
            ),
            borderRadius: BorderRadius.all(Radius.circular(35.6/2)),
            color: Color(ColorKey.paleGrey).withOpacity(0.8)
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
        ),
        Align(
          alignment: Alignment.center,
          child: Image.asset("${Constant.image}icCircularClock.png", width: 37, height: 37,),
        )
      ],
    ),
  );

  Widget wContainerInsidePresence() => Visibility(
    visible: isInsideAnyPresence,
    child: Container(
      margin: EdgeInsets.only(left: 30, right: 30, bottom: 23),
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(
          color: Colors.black12,
          blurRadius: 4,
          spreadRadius: 2
        )],
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 13, right: 13, bottom: 13, top: 11),
        child: Column(
          children: <Widget>[
            SizedBox(height: 10.7,),
            Text("Anda berada di area presensi.", style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w500, fontSize: 10, color: Color(ColorKey.greyishBrown)),),
            SizedBox(height: 9.5,),
            InkWell(
              onTap:  () => addPresence(),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Color(ColorKey.darkSkyBlue)
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text("PRESENSI", style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w700, fontSize: 11, color: Colors.white),),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    )
  );

  Widget wContainerOutsidePresence() => Visibility(
    visible: !isInsideAnyPresence,
    child: Container(
      margin: EdgeInsets.only(left: 30, right: 30, bottom: 23),
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(
          color: Colors.black12,
          blurRadius: 4,
          spreadRadius: 2
        )],
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 16.3, top: 13, bottom: 13, right: 16.3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset("${Constant.image}icOutsidePresence.png", width: 34.9, height: 32.7,),
            SizedBox(width: 27.2,),
            Text("Cepat, Anda berada di luar area presensi!", style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w500, color: Color(ColorKey.greyishBrown), fontSize: 10),)
          ],
        ),
      ),
    )
  );

  Widget body() => Stack(
    children: <Widget>[
      Column(
        children: <Widget>[
          Expanded(
            child: GoogleMap(
              markers: marker,
              initialCameraPosition: CameraPosition(target: LatLng(0, 0)),
              mapType: MapType.normal,
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
              circles: circles,
            )
          )
        ],
      ),
      Container(
        height: 43,
        width: MediaQuery.of(context).size.width,
        color: Colors.white.withOpacity(0.8),
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(right: 23),
            child: Text(currentTime, style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w500, fontSize: 10, color: Color(ColorKey.darkSkyBlue)),),
          ),
        ),
      ),
      Column(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                wClock(),
                SizedBox(height: 15,),
                wContainerInsidePresence(),
                wContainerOutsidePresence()
              ],
            )
          )
        ],
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                "Presensi",
                style: TextStyle(fontSize: 12, fontFamily: "Roboto", fontWeight: FontWeight.w500),
              )
            ),
            InkWell(
              onTap: () => gotoPresensiList(),
              child: Image.asset("${Constant.image}icHistory.png", width: 16, height: 16,),
            )
          ],
        ),
      ),
      body: body(),
    );
  }
}
