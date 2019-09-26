import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_playground/model/getPreparePresence/data_get_prepare_presence.dart';
import 'package:flutter_playground/model/getPreparePresence/item_checkpoint.dart';
import 'package:flutter_playground/view/daftar_presensi.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../constant/Constant.dart';
import '../constant/ColorKey.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';

class PresensiMap extends StatefulWidget {

  PresensiMap(this.dataGetPreparePresence);

  DataGetPreparePresence dataGetPreparePresence;

  @override
  PresensiMapState createState() => PresensiMapState(dataGetPreparePresence);
}

class PresensiMapState extends State<PresensiMap> {

  // constructor
  PresensiMapState(this.dataGetPreparePresence);

  // properties
  DataGetPreparePresence dataGetPreparePresence;
  LocationData currentLocation;
  Location location = Location();
  var error = "";
  GoogleMapController mapController;
  Set<Marker> marker = {};
  Set<Circle> circles = {};
  BitmapDescriptor icon;
  var distance = 0.0;

  @override
  void initState() {
    super.initState();
    dataGetPreparePresence.data_checkpoint.forEach((checkpoint){
      print("checkpoint: ${checkpoint.checkpoint_id}");
    });
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(28, 35)), '${Constant.image}icMarkerMaps.png')
      .then((onValue) {
      icon = onValue;
    });
    getCurrentLocation();
    positionChangeListener();
  }

  Future<double> getDistance(LatLng current, LatLng destination) async {
    return await Geolocator().distanceBetween(current.latitude, current.longitude, destination.latitude, destination.longitude);
  }

  checkCoordinate() {
    circles.clear();
    dataGetPreparePresence.data_checkpoint.forEach((checkpoint) {
      getDistance(LatLng(currentLocation.latitude, currentLocation.longitude), LatLng(double.parse(checkpoint.checkpoint_latitude), double.parse(checkpoint.checkpoint_longitude))).then((userDistance) {
        if (userDistance < 50) {
          drawSingleCircle(checkpoint.checkpoint_id, ColorKey.tanGreen, ColorKey.nastyGreen, LatLng(double.parse(checkpoint.checkpoint_latitude), double.parse(checkpoint.checkpoint_longitude)));
        } else {
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
      this.currentLocation = currentLocation;
      // give marker id 1, to make it not duplicate
      marker.add(Marker(
        markerId: MarkerId("1"),
        position: LatLng(currentLocation.latitude, currentLocation.longitude),
        icon: icon
      ));
      // populate circle
      checkCoordinate();
      Timer(Duration(seconds: 4), () => animateCamera(currentLocation.latitude, currentLocation.longitude));
    });
  }

  animateCamera(latitude, longitude) {
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(latitude, longitude), zoom: double.parse(dataGetPreparePresence.zoom_maps))));
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
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => DaftarPresensi()));
  }

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
      body: Stack(
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
                child: Text("test jam"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
