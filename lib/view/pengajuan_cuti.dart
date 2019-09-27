import 'package:flutter/material.dart';
import 'package:flutter_playground/model/getLeaveType/item_get_leave_type.dart';
import 'package:flutter_playground/networking/service/information_networking.dart';
import 'package:flutter_playground/view/daftar_cuti.dart';
import 'package:flutter_playground/view/splash_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant/Constant.dart';
import '../constant/ColorKey.dart';

class PengajuanCuti extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => PengajuanCutiState();
}

class PengajuanCutiState extends State<PengajuanCuti> {

  // public properties

  // private properties
  SharedPreferences preferences;
  var nama = "";
  var unit = "";
  var alasan = "";
  var selectedDelegasi = "";
  var selectedAtasan = "";
  var selectedDelegasiId = "";
  var selectedAtasanId = "";
  ItemGetLeaveType selectedCuti;
  List<ItemGetLeaveType> listTypeCuti = List();

  gotoDaftarCuti() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => DaftarCuti()));
  }

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((preference){
      preferences = preference;
      getProfile();
      getLeaveType();
    });
  }

  getLeaveType() async {
    showLoading();
    var leaveType = await InformationNetworking().getLeaveType();
    hideDialog();

    if (leaveType.status == 200) {
      listTypeCuti = leaveType.data;
      selectedCuti = leaveType.data[0];
      setState(() {});
    } else if (leaveType.status == 401){
      preferences.setString(Constant.IS_LOGIN, "false");
      Fluttertoast.showToast(msg: "Session anda berakhir");
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => RootView()),
          (Route<dynamic> route) => false);
    } else {
      Fluttertoast.showToast(msg: leaveType.message);
    }
  }

  getProfile() async {
    showLoading();
    var profile = await InformationNetworking().getProfile();
    hideDialog();

    if (profile.status == 200) {
      nama = profile.data[0].emp_name;
      unit = profile.data[0].unit;
      setState(() { });
    } else if (profile.status == 401) {
      preferences.setString(Constant.IS_LOGIN, "false");
      Fluttertoast.showToast(msg: "Session anda berakhir");
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => RootView()),
          (Route<dynamic> route) => false);
    } else {
      Fluttertoast.showToast(msg: profile.message);
    }
  }

  showLoading() {
    showDialog(
      context: context,
      builder: (BuildContext context) => dialogLoading()
    );
  }

  hideDialog() {
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

  Widget wTitle(String content) => Text(
    content,
    style: TextStyle(
      fontFamily: "Roboto",
      fontWeight: FontWeight.w500,
      color: Color(ColorKey.greyishBrown),
      fontSize: 12
    ),
  );

  Widget dropDownJenisCuti() => DropdownButtonHideUnderline(
              child: DropdownButton<ItemGetLeaveType>(
                isExpanded: true,
                elevation: 1,
                hint: Text("-- Pilih  --"),
                icon: Icon(Icons.keyboard_arrow_down),
                value: selectedCuti,
                onChanged: (ItemGetLeaveType selectedValue) { setState(() {
                 selectedCuti = selectedValue; 
                }); },
                items: listTypeCuti.map((ItemGetLeaveType unit) {
                  return DropdownMenuItem<ItemGetLeaveType>(
                    value: unit,
                    child: Text(
                      unit.name,
                      style: TextStyle(
                        color: Color(ColorKey.veryLightPinkFive),
                        fontSize: 12,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w500),
                    ),
                  );
                }).toList(),
            )
          );

  Widget wViewJenisCuti() => Container(
    height: 37,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(3)),
      border: Border.all(
        width: 1,
        color: Color(ColorKey.veryLightPink)
      )
    ),
    child: Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: dropDownJenisCuti(),
    ),
  );

  Widget wViewAlasan() => Container(
    height: 88,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(3)),
      border: Border.all(
        width: 1,
        color: Color(ColorKey.veryLightPink)
      )
    ),
    child: Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        maxLines: null,
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
        onChanged: (value) => alasan = value,
        keyboardType: TextInputType.multiline,
        style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w400, color: Color(ColorKey.greyishBrown), fontSize: 12,  ),
      ),
    )
  );

  clickDelegasiView() {
    print("delegasi click");
  }

  clickAtasanView() {
    print("atasan click");
  }

  clickSimpanView() {
    print("simpan click");
  }

  clickSubmitView() {
    print("submit click");
  }

  Widget wViewDelegasiOrAtasan(String content, clickListener) => InkWell(
    onTap: clickListener,
    child: Container(
    width: MediaQuery.of(context).size.width,
    height: 37,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(3)),
      border: Border.all(
        width: 1,
        color: Color(ColorKey.veryLightPink)
      )
    ),
    child: Padding(
      padding: EdgeInsets.only(left: 9.8, right: 9.8),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Text(content == "" ? "Cari..." : content, style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w500, color: Color(ColorKey.greyishBrown), fontSize: 12),),
        ),
        SizedBox(width: 10,),
        Image.asset("${Constant.image}${getDelegasiAtasanIcon(content)}", width: 18, height: 18,)
      ],
    ),
    ),
  ),
  );

  String getDelegasiAtasanIcon(String content) {
    return content == "" ? "icSearch.png" : "icDeleteDelegasiAtasan.png";
  }

  Widget wButtonAction(clickListener, int bgColor, content) => Expanded(
      child: InkWell(
        onTap: clickListener,
        child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Color(bgColor),
          borderRadius: BorderRadius.all(Radius.circular(5))
        ),
        child: Center(
          child: Text(content, style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w700, color: Colors.white, fontSize: 12),),
        ),
      ),
      )
    );

  Widget containerButtonAction() => Row(
      children: <Widget>[
        wButtonAction(() => clickSimpanView(), ColorKey.darkSkyBlue, "Simpan"),
        SizedBox(width: 8.9,),
        wButtonAction(() => clickSubmitView(), ColorKey.tanGreen, "Submit"),
      ],
    );

  Widget body() => SingleChildScrollView(
    physics: ClampingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.only(top: 17.8, left: 14.2, right: 14.2, bottom: 12.2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            wTitle("Pegawai"),
            SizedBox(height: 14.2,),
            Text(nama, style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w500, color: Color(ColorKey.greyishBrown), fontSize: 12),),
            SizedBox(height: 20.4,),
            wTitle("Departemen / Unit"),
            SizedBox(height: 6.2,),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color(ColorKey.veryLightBlue),
                borderRadius: BorderRadius.all(Radius.circular(3)),
                border: Border.all(
                  width: 1,
                  color: Color(ColorKey.veryLightPink)
                )
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(unit, style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w500, color: Color(ColorKey.brownishGrey), fontSize: 12),),
              ),
            ),
            SizedBox(height: 7.1,),
            wTitle("Jenis Cuti"),
            SizedBox(height: 6.2,),
            wViewJenisCuti(),
            SizedBox(height: 7.1,),
            wTitle("Alasan"),
            SizedBox(height: 6.2,),
            wViewAlasan(),
            SizedBox(height: 8.9,),
            wTitle("Delegasi"),
            SizedBox(height: 6.2,),
            wViewDelegasiOrAtasan(selectedDelegasi, () => clickDelegasiView()),
            SizedBox(height: 12.4,),
            wTitle("Atasan"),
            SizedBox(height: 6.2,),
            wViewDelegasiOrAtasan(selectedAtasan, () => clickAtasanView()),
            SizedBox(height: 17.8,),
            containerButtonAction(),
          ],
        ),
      )
    );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                "Pengajuan Cuti",
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w500),
              )),
              InkWell(
                onTap: () => gotoDaftarCuti(),
                child: Image.asset(
                  "${Constant.image}icHistory.png",
                  width: 16,
                  height: 16,
                ),
              )
            ],
          ),
        ),
        body: body(),
      ),
    );
  }
}
