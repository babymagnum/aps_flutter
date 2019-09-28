import 'package:flutter/material.dart';
import '../constant/Constant.dart';
import '../constant/ColorKey.dart';
import 'base_view.dart';

class DaftarCuti extends StatefulWidget {
  @override
  DaftarCutiState createState() => DaftarCutiState();
}

class DaftarCutiState extends State<DaftarCuti> with BaseView {
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
                "Daftar Karyawan",
                style: TextStyle(fontSize: 12, fontFamily: "Roboto", fontWeight: FontWeight.w500),
              )
            ),
            InkWell(
              child: Image.asset("${Constant.image}icFilter.png", width: 16, height: 16,),
            )
          ],
        ),
      ),
    );
  }
}