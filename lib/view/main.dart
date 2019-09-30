import 'package:flutter/material.dart';
import '../constant/ColorKey.dart';
import '../constant/Constant.dart';
import 'beranda.dart';
import 'berita.dart';
import 'notifikasi/notifikasi.dart';
import 'profil.dart';
import 'dart:io';

class MainApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainAppState();
}

class MainAppState extends State<MainApp> {
  var selectedIndex = 0;
  var hasNotif = true;

  //use to get data from server
  @override
  void initState() {
    super.initState();
  }

  onItemTapped(int index) {
    selectedIndex = index;
    setState(() {});
  }

  Widget setNotifikasiWidget() {
    if (selectedIndex == 2) {
      if (hasNotif) {
        return Image.asset(
          "${Constant.image}hasNotifikasiActive.png",
          width: 20,
          height: 20,
        );
      } else {
        return Image.asset(
          "${Constant.image}notifikasiActive.png",
          width: 20,
          height: 20,
        );
      }
    } else {
      if (hasNotif) {
        return Image.asset(
          "${Constant.image}hasNotifikasiNonActive.png",
          width: 20,
          height: 20,
        );
      } else {
        return Image.asset(
          "${Constant.image}notifikasiNonActive.png",
          width: 20,
          height: 20,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Color(ColorKey.default_bg),
        body: IndexedStack(
          index: selectedIndex,
          children: <Widget>[
            Beranda(),
            Berita(),
            Notifikasi(),
            Profil(false, null)
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(ColorKey.default_bg),
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: selectedIndex == 0
                ? Image.asset(
                "${Constant.image}berandaActive.png",
                width: 20,
                height: 20,
              )
                : Image.asset(
                "${Constant.image}berandaNonActive.png",
                width: 20,
                height: 20,
              ),
              title: Text(
                'Beranda',
                style: TextStyle(fontSize: 10, fontFamily: "Roboto"),
              ),
            ),
            BottomNavigationBarItem(
              icon: selectedIndex == 1
                ? Image.asset(
                "${Constant.image}beritaActive.png",
                width: 20,
                height: 20,
              )
                : Image.asset(
                "${Constant.image}beritaNonActive.png",
                width: 20,
                height: 20,
              ),
              title: Text(
                'Berita',
                style: TextStyle(fontSize: 10, fontFamily: "Roboto"),
              ),
            ),
            BottomNavigationBarItem(
              icon: setNotifikasiWidget(),
              title: Text(
                'Notifkasi',
                style: TextStyle(fontSize: 10, fontFamily: "Roboto"),
              ),
            ),
            BottomNavigationBarItem(
              icon: selectedIndex == 3
                ? Image.asset(
                "${Constant.image}profileActive.png",
                width: 20,
                height: 20,
              )
                : Image.asset(
                "${Constant.image}profileNonActive.png",
                width: 20,
                height: 20,
              ),
              title: Text(
                'Profil',
                style: TextStyle(fontSize: 10, fontFamily: "Roboto"),
              ),
            ),
          ],
          currentIndex: selectedIndex,
          selectedItemColor: Color(ColorKey.darkSkyBlue),
          onTap: onItemTapped,
        ),
      ),
      onWillPop: () async {
        exit(0);
        return false;
      }
    );
  }
}
