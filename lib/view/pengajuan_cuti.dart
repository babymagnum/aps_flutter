import 'dart:io';
import 'package:camera/camera.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_playground/model/getLeaveType/item_get_leave_type.dart';
import 'package:flutter_playground/networking/service/information_networking.dart';
import 'package:flutter_playground/view/base_view.dart';
import 'package:flutter_playground/view/daftar_cuti.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant/Constant.dart';
import '../constant/ColorKey.dart';
import '../model/getLeaveQuota/item_get_leave_quota.dart';
import 'package:file_picker/file_picker.dart';

class PengajuanCuti extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PengajuanCutiState();
}

class PengajuanCutiState extends State<PengajuanCuti> with BaseView {

  // public properties

  // private properties
  SharedPreferences preferences;
  var isShowCamera = false;
  var showViewCuti = false;
  var nama = "";
  var unit = "";
  var alasan = "";
  var selectedDelegasi = "";
  var selectedAtasan = "";
  var selectedDelegasiId = "";
  var selectedAtasanId = "";
  var daysCount = "0";
  var showFile = false;
  var fileName = "";
  var filePath = "";
  var is_day = "0";
  var is_range = "0";
  var is_reduced = "0";
  var is_backdated = "0";
  var is_lampiran = "0";
  var rentangWaktuAwal = "Mulai";
  var rentangWaktuSelesai = "Selesai";
  var selectedDate = "Pilih tanggal...";
  var rentangTanggalAwal = "Pilih tanggal mulai...";
  var rentangTanggalAkhir = "Pilih tanggal selesai...";
  List<String> listSelectedTanggal = List();
  List<ItemGetLeaveQuota> listLeaveQuota = List();
  ItemGetLeaveType selectedCuti;
  List<ItemGetLeaveType> listTypeCuti = List();
  List<CameraDescription> cameras;
  CameraDescription firstCamera;
  CameraController cameraController;

  gotoDaftarCuti() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => DaftarCuti()));
  }

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((preference){
      preferences = preference;
      initializeCamera();
      getProfile();
      getLeaveType();
      getLeaveQuota();
    });
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  // FUNCTION //

  initializeCamera() async {
    cameras = await availableCameras();
    firstCamera = cameras.first;
    cameraController = CameraController(
      firstCamera,
      ResolutionPreset.veryHigh,
    );
    await cameraController.initialize();
  }

  showCamera() async {
    hideDialog(context);
    isShowCamera = true;
    setState(() {});
  }

  takePicture() async {
    try {
      final path = join((await getTemporaryDirectory()).path, "${DateTime.now()}.png",);

      if (path != null && path == "") {
        return;
      }

      await cameraController.takePicture(path);
      filePath = path;
      fileName = path.split("/").last;
      isShowCamera = false;
      setState(() {});
    } catch (e) {
      Fluttertoast.showToast(msg: "There was something error with camera, error: $e");
      print(e);
    }
  }

  openFileExplorer() {
    try {
      FilePicker.getFilePath(type: FileType.ANY).then((path) {
        filePath = path == "" ? "/test.png" : path;
        fileName = filePath.split("/").last;
        setState(() {});
      });
    } on PlatformException catch (e) {
      print("error bro:" + e.toString());
      //Fluttertoast.showToast(msg: "Unsupported operation ${e.toString()}");
    }
  }

  getLeaveQuota() async {
    showLoading(context);
    var leaveQuota = await InformationNetworking().getLeaveQuota();
    hideDialog(context);

    if (leaveQuota.status == 200) {
      listLeaveQuota = leaveQuota.data;
      setState(() {});
    } else if (leaveQuota.status == 401) {
      forceLogout(preferences, context);
    } else {
      Fluttertoast.showToast(msg: leaveQuota.message);
    }
  }

  getLeaveType() async {
    showLoading(context);
    var leaveType = await InformationNetworking().getLeaveType();
    hideDialog(context);

    if (leaveType.status == 200) {
      listTypeCuti = leaveType.data;
      selectedCuti = leaveType.data[0];
      setState(() {});
    } else if (leaveType.status == 401){
      forceLogout(preferences, context);
    } else {
      Fluttertoast.showToast(msg: leaveType.message);
    }
  }

  getProfile() async {
    showLoading(context);
    var profile = await InformationNetworking().getProfile();
    hideDialog(context);

    if (profile.status == 200) {
      nama = profile.data[0].emp_name;
      unit = profile.data[0].unit;
      setState(() { });
    } else if (profile.status == 401) {
      forceLogout(preferences, context);
    } else {
      Fluttertoast.showToast(msg: profile.message);
    }
  }

  setSelectedCuti() {
    if (selectedCuti.name == "-- Pilih --") {
      showViewCuti = false;
    } else {
      showViewCuti = true;
    }

    daysCount = selectedCuti.days_count;
    is_day = selectedCuti.is_day;
    is_range = selectedCuti.is_range;
    is_reduced = selectedCuti.is_reduced;
    is_backdated = selectedCuti.is_backdated;
    is_lampiran = selectedCuti.is_lampiran;
  }

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

  String getDelegasiAtasanIcon(String content) {
    return content == "" ? "icSearch.png" : "icDeleteDelegasiAtasan.png";
  }

  showDate(String type) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: is_backdated == "1" ? DateTime(2000) : stringToDateTime(dateTimeToString("yyyy-MM-dd", DateTime.now()), "yyyy-MM-dd"),
      lastDate: DateTime(int.parse(dateTimeToString("yyyy", DateTime.now())) + 10),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData(
            canvasColor: Color(ColorKey.darkSkyBlue)
          ),
          child: child,
        );
      },
    ).then((value) {

      if (type == "date") {
        selectedDate = dateTimeToString("yyyy-MM-dd", value);
      } else if (type == "tanggalAwal") {
        rentangTanggalAwal = dateTimeToString("yyyy-MM-dd", value);
      } else {
        rentangTanggalAkhir = dateTimeToString("yyyy-MM-dd", value);
      }

      if (is_day == "1" && is_range == "0") {
        if (listSelectedTanggal.contains(selectedDate)) {
          Fluttertoast.showToast(msg: ("Anda sudah memilih tanggal yang sama"));
        } else {
          listSelectedTanggal.add(selectedDate);
        }
      }
      setState(() {});
    });
  }

  showTime(String type) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) => Theme(
        data: ThemeData(
          canvasColor: Color(ColorKey.darkSkyBlue)
        ),
        child: child
      )
    ).then((value) {
      if (type == "awal") {
        rentangWaktuAwal = "${value.hour.toString().length == 1 ? "0${value.hour}" : value.hour}:${value.minute.toString().length == 1 ? "0${value.minute}" : value.minute}";
      } else {
        rentangWaktuSelesai = "${value.hour.toString().length == 1 ? "0${value.hour}" : value.hour}:${value.minute.toString().length == 1 ? "0${value.minute}" : value.minute}";
      }
      setState(() {});
    });
  }

  // WIDGET //

  showDialogFilePicker() {
    showDialog(
      context: context,
      builder: (context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Dialog(
          elevation: 0.6,
          child: Container(
            height: 89,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  onTap: () => showCamera(),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(Icons.camera),
                        SizedBox(width: 8,),
                        Text("Take Camera Picture", style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w500, fontSize: 12),)
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 1,
                  color: Colors.black12,
                ),
                InkWell(
                  onTap: () {
                    hideDialog(context);
                    openFileExplorer();
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(Icons.attach_file),
                        SizedBox(width: 8,),
                        Text("Pick File", style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w500, fontSize: 12),)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }

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
                onChanged: (ItemGetLeaveType selectedValue) {
                  selectedCuti = selectedValue;
                  setSelectedCuti();
                  setState(() {}); 
                },
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

  Widget wJatahCutiView() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      wTitle("Jatah Cuti"),
      ListView.builder(  
        shrinkWrap: true,      
        physics: ClampingScrollPhysics(),
        itemCount: listLeaveQuota.length,
        itemBuilder: (context, index) => wItemListJatahCuti(listLeaveQuota[index], index),
      )
    ],
  );

  Widget wTanggalCutiView(icon, content, clickListener, bool isShowTitle) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Visibility(
        visible: isShowTitle,
        child: wTitle("Tanggal Cuti")
      ),
      SizedBox(height: 6.2,),
      InkWell(
        onTap: clickListener,
        child: Container(
          height: 37,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(3)),
            color: Colors.white,
            border: Border.all(
              width: 1,
              color: Color(ColorKey.veryLightPink)
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(width: 10,),
              Expanded(
                child: Text(content, style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w500, fontSize: 12, color: Color(ColorKey.brownishGrey)),),
              ),
              SizedBox(width: 10,),
              Image.asset("${Constant.image}$icon", width: 17, height: 18,),
              SizedBox(width: 10,)
            ],
          ),
        ),
      )
    ],
  );

  Widget wItemListJatahCuti(ItemGetLeaveQuota item, int position) => Container(
    margin: EdgeInsets.only(top: position == 0 ? 6.2 : 11.6, bottom: position == listLeaveQuota.length - 1 ? 13.3 : 0),
    decoration: BoxDecoration(
      color: Color(ColorKey.veryLightBlue),
      borderRadius: BorderRadius.all(Radius.circular(3)),
      border: Border.all(
        width: 1,
        color: Color(ColorKey.veryLightPink)
      )
    ),
    child: Padding(
      padding: EdgeInsets.only(left: 6.2, right: 6.2, top: 9.8, bottom: 14.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          wRowContentJatahCuti("Periode", item.periode),
          SizedBox(height: 6.2,),
          wRowContentJatahCuti("Jatah Cuti", item.quota),
          SizedBox(height: 6.2,),
          wRowContentJatahCuti("Terambil", item.taken),
          SizedBox(height: 6.2,),
          wRowContentJatahCuti("Sisa Cuti", item.sisa),
          SizedBox(height: 6.2,),
          wRowContentJatahCuti("Kadaluarsa", item.expired)
        ],
      ),
    ),
  );

  Widget wRowContentJatahCuti(String title, String content) => Row(
    children: <Widget>[
      Container(
        width: MediaQuery.of(context).size.width * 0.25,
        child: Text(title, style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w500, fontSize: 12, color: Color(ColorKey.brownishGrey)),),
      ),
      Expanded(
        child: Text(content, overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w700, fontSize: 12, color: Color(ColorKey.brownishGrey)),),
      )
    ],
  );

  Widget wSelectedTanggalView() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      wTitle("Tanggal"),
      SizedBox(height: 6.2,),
      wListSelectedTanggal()
    ],
  );

  Widget wListSelectedTanggal() => ListView.builder(
    shrinkWrap: true,
    physics: ClampingScrollPhysics(),
    itemCount: listSelectedTanggal.length,
    itemBuilder: (context, index) => wItemListSelectedTanggal(listSelectedTanggal[index], index)
  );

  Widget wItemListSelectedTanggal(content, index) => InkWell(
    onTap: () {
      listSelectedTanggal.removeAt(index);
      setState(() {});
    },
    child: Container(
      margin: EdgeInsets.only(top: 5.8, bottom: index == listSelectedTanggal.length - 1 ? 6.2 : 0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(content, overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w400, color: Color(ColorKey.greyishBrown), fontSize: 12),)
              ),
              Image.asset("${Constant.image}icDeletePengajuanCuti.png", width: 27, height: 27,)
            ],
          ),
          SizedBox(height: 6.7,),
          Container(
            height: 1,
            color: Colors.black12,
          )
        ],
      ),
    ),
  );

  Widget wLampiranView() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(height: 6.2,),
      wTitle(("Lampirkan File")),
      SizedBox(height: 6.2,),
      InkWell(
        onTap: showDialogFilePicker,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 37,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Color(ColorKey.veryLightPink)
            ),
            color: Colors.white
          ),
          child: Center(
            child: Image.asset("${Constant.image}icUnggahFile.png", width: 66, height: 18,),
          ),
        ),
      ),
      SizedBox(height: 6.2,),
      Visibility(
        visible: fileName != "",
        child: Text(fileName, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w500, fontSize: 12, color: Color(ColorKey.darkSkyBlue)),)
      ),
      SizedBox(height: 5.2,),
      Visibility(
        visible: filePath != "",
        child: Center(
          child: Container(
            height: 100,
            width: 100,
            child: FadeInImage(
              placeholder: AssetImage("${Constant.image}icAppsIcon.png"),
              image: filePath != null ? FileImage(File(filePath)) : AssetImage("${Constant.image}icAppsIcon.png")
            ),
          ),
        )
      )
    ],
  );

  Widget wRentangTanggal() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(height: 6.2,),
      wTitle("Rentang Tanggal"),
      SizedBox(height: 6.2,),
      wTanggalCutiView("icCalendar.png", rentangTanggalAwal, () => showDate("tanggalAwal"), false),
      wTanggalCutiView("icCalendar.png", rentangTanggalAkhir, () => showDate("tanggalAkhir"), false)
    ],
  );

  Widget wRentangWaktu() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(height: 8.2,),
      wTitle("Waktu"),
      SizedBox(height: 6.3,),
      wTanggalCutiView("icClockPengajuanCuti.png", rentangWaktuAwal, () => showTime("awal"), false),
      wTanggalCutiView("icClockPengajuanCuti.png", rentangWaktuSelesai, () => showTime("selesai"), false)
    ],
  );

  Widget body() => Stack(
    children: <Widget>[
      SingleChildScrollView(
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
              Visibility(
                visible: showViewCuti,
                child: Visibility(
                  visible: is_range == "1" && is_day == "1",
                  child: wRentangTanggal()
                )
              ),
              SizedBox(height: 6.2,),
              Visibility(
                visible: showViewCuti,
                child: Visibility(
                  visible: daysCount == "0" ? false : true,
                  child: wTitle("Maksimal Cuti: $daysCount Hari"),
                )
              ),
              SizedBox(height: 6.2,),
              Visibility(
                visible: showViewCuti,
                child: Visibility(
                  visible: is_reduced == "1" ? true : false,
                  child: wJatahCutiView(),
                )
              ),
              Visibility(
                visible: showViewCuti,
                child: Visibility(
                  visible: is_day == "1" && is_range == "1" ? false : true,
                  child: wTanggalCutiView("icCalendar.png", selectedDate, () => showDate("date"), true)
                )
              ),
              Visibility(
                visible: showViewCuti,
                child: Visibility(
                  visible: is_day == "0",
                  child: wRentangWaktu()
                )
              ),
              Visibility(
                visible: showViewCuti,
                child: Visibility(
                  visible: is_lampiran == "1",
                  child: wLampiranView()
                )
              ),
              SizedBox(height: 7.1,),
              Visibility(
                visible: showViewCuti,
                child: Visibility(
                  visible: is_day == "1" && is_range == "0",
                  child: wSelectedTanggalView()
                )
              ),
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
      ),
      Visibility(
        visible: isShowCamera,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  CameraPreview(cameraController),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: FloatingActionButton(
                        child: Icon(Icons.camera),
                        onPressed: () => takePicture()
                      ),
                    ),
                  )
                ],
              )
            )
          ],
        )
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Color(ColorKey.default_bg),
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
      onWillPop: () async {
        if (isShowCamera) {
          isShowCamera = false;
          setState(() {});
          return false;
        } else {
          return true;
        }
      }
    );
  }
}
