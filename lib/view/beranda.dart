import 'package:flutter/material.dart';
import 'package:flutter_playground/view/daftar_presensi.dart';
import 'package:flutter_playground/view/pengajuan_cuti.dart';
import 'package:flutter_playground/view/presensi.dart';
import '../constant/ColorKey.dart';
import '../constant/Constant.dart';
import '../model/Menu.dart';
import 'splash_screen.dart';
import '../model/getLatestNews/item_latest_news.dart';
import '../networking/service/information_networking.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'daftar_karyawan.dart';
import 'base_view.dart';

class Beranda extends StatefulWidget {
  @override
  State createState() => BerandaState();
}

class BerandaState extends State<Beranda> with BaseView {
  //properties
  var listMenuFavorit = List<Menu>();
  var listMenuLainya = List<Menu>();
  var listMenu = List<Menu>();
  var listBerita = List<ItemLatestNews>();
  var labelButtonMenuEdit = "UBAH";
  var name = "";
  var statusPresensi = "";
  var waktuPresensi = "";
  var jatahCuti = "";
  var capaianKerja = "";
  var isUbahMenu = false;
  var isAlreadyGenerateMenuEdit = false;
  SharedPreferences preference;
  StateSetter stateBottom;

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((SharedPreferences mSharedPreference) {
      preference = mSharedPreference;
      initView();
      generateMenuUtama();
      getDashboard();
      getLatestNews();
    });
  }

  onItemListMenuTap(Menu menu, int position, BuildContext context) {
    if (menu.action != "") {
      if (menu.action == "add") {
        listMenuLainya.removeAt(position);
        listMenuFavorit.insert(0, menu);
        showActionMenuFavorit();

        if (listMenuFavorit.length == 6) {
          hideActionMenuLainya();
        } else {
          showActionMenuLainya();
        }
      } else {
        listMenuFavorit.removeAt(position);
        listMenuLainya.add(menu);

        if (listMenuFavorit.length == 6) {
          hideActionMenuLainya();
        } else {
          showActionMenuLainya();
        }
      }
    } else {
      switch (menu.id) {
        //pengajuan cuti
        case 1:
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => PengajuanCuti()));
          break;

        //pengajuan elmbur
        case 2:
          showDialogSegeraHadir();
          break;

        //persetujuan
        case 3:
          Fluttertoast.showToast(msg: "In development feature");
          break;

        //presensi
        case 4:
          Fluttertoast.showToast(msg: "In development feature");
          break;

        //presensi list
        case 5:
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => DaftarPresensi(false))
          );
          break;

        //lihat lainya
        case 6:
          showBottomSheetUpdateMenu(context);
          break;

        //Slip gaji
        case 7:
          Fluttertoast.showToast(msg: "In development feature");
          break;

        //peminjaman ruangan
        case 8:
          showDialogSegeraHadir();
          break;

        //peminjaman mobil dinas
        case 9:
          showDialogSegeraHadir();
          break;

        //daftar karyawan
        case 10:
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DaftarKaryawan()));
          break;

        //link website
        case 11:
          Fluttertoast.showToast(msg: "In development feature");
          break;
      }
    }
  }

  saveOrEditMenu() {
    if (isUbahMenu) {
      isUbahMenu = !isUbahMenu;
      labelButtonMenuEdit = "UBAH";
      generateMenuLainya();
      hideActionMenuFavorit();
      hideActionMenuLainya();
    } else {
      isUbahMenu = !isUbahMenu;
      labelButtonMenuEdit = "SIMPAN";
      showActionMenuFavorit();
    }
  }

  showDialogSegeraHadir() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            elevation: 0.2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4))),
            backgroundColor: Colors.transparent,
            child: Container(
              height: 308.6,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 26.6,
                  ),
                  Image.asset(
                    "${Constant.image}icSegeraHadir.png",
                    height: 56.7,
                    width: 56.7,
                  ),
                  SizedBox(
                    height: 43.4,
                  ),
                  Text(
                    "Segera Hadir",
                    style: TextStyle(
                        color: Color(ColorKey.black),
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                  ),
                  SizedBox(
                    height: 87.1,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: InkWell(
                        onTap: hideDialog(context),
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
                    height: 25.8,
                  )
                ],
              ),
            ),
          );
        });
  }

  showBottomSheetUpdateMenu(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, setBottomState) {
            this.stateBottom = setBottomState;

            if (!isAlreadyGenerateMenuEdit) {
              isAlreadyGenerateMenuEdit = !isAlreadyGenerateMenuEdit;
              generateMenuFavorit();
              generateMenuLainya();
            }

            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
              ),
              height: MediaQuery.of(context).size.height * 0.75,
              child: SingleChildScrollView(
                child: Wrap(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          top: 3, right: 19.5, left: 19.5, bottom: 19.5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Image.asset(
                                "${Constant.image}verticalLineMenu.png",
                                width: 26.7,
                                height: 6.1),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10.4, bottom: 5),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    child: Text("Menu Favorit",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(ColorKey.black)))),
                                InkWell(
                                  onTap: () => saveOrEditMenu(),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        color: Color(ColorKey.darkSkyBlue)),
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: 6,
                                          bottom: 6,
                                          right: 12,
                                          left: 12),
                                      child: Text(
                                        labelButtonMenuEdit,
                                        style: TextStyle(
                                            fontSize: 8, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          wListMenu(listMenuFavorit),
                          Container(
                            margin: EdgeInsets.only(top: 24.5, bottom: 5),
                            child: Text(
                              "Menu Lainya",
                              style: TextStyle(
                                  fontSize: 12, color: Color(ColorKey.black)),
                            ),
                          ),
                          wListMenu(listMenuLainya)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          });
        }).whenComplete(() {
      saveMenuFavorit();
      saveMenuLainya();
      generateMenuUtama();
    });
  }

  getLatestNews() async {
    var dataLatestNews = await InformationNetworking().getLatestNews();
    var preference = await SharedPreferences.getInstance();

    if (dataLatestNews.status == 200) {
      setState(() {
        listBerita = dataLatestNews.data;
      });
    } else if (dataLatestNews.status == 401) {
      forceLogout(preference, context);
    } else {
      Fluttertoast.showToast(msg: dataLatestNews.message);
    }
  }

  getDashboard() async {
    var dataDashboard = await InformationNetworking().getDashboard();
    if (dataDashboard.status == 200) {
      var dashboard = dataDashboard.data[0];
      statusPresensi = dashboard.presence_today.status;
      waktuPresensi = dashboard.presence_today.time;
      capaianKerja = dashboard.total_work.total_work_hours;
      jatahCuti = dashboard.total_leave_quota;
      setState(() {});
    } else if (dataDashboard.status == 401) {
      forceLogout(preference, context);
    } else {
      Fluttertoast.showToast(msg: dataDashboard.message);
    }
  }

  preparePresence() async {
    showLoading(context);
    var presence = await InformationNetworking().getPreparePresence();
    hideDialog(context);

    if (presence.status == 200) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => Presensi(presence.data)));
    } else if (presence.status == 401) {
      forceLogout(preference, context);
    } else if (presence.status == 406) {
      showDialogPreparePresence(presence.message);
    } else {
      showDialogPreparePresence(presence.message);
    }
  }

  showDialogPreparePresence(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialogPreparePresence(message);
        });
  }

  Widget dialogPreparePresence(String message) => Dialog(
        elevation: 0.2,
        backgroundColor: Colors.transparent,
        child: Container(
          height: 295,
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
              Text(
                message,
                style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(ColorKey.black)),
              ),
              SizedBox(
                height: 39.8,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      onTap: hideDialog(context),
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

  initView() {
    name = preference.getString(Constant.NAME);
    print("TOKEN: ${preference.getString(Constant.TOKEN)}");
    setState(() {});
  }

  Menu generateMenu(String key) {
    int menu = preference.getInt(key);

    if (menu == 1) {
      return Menu(
          id: 1,
          image: "${Constant.image}briefcase.png",
          content: "Pengajuan Cuti",
          action: "");
    } else if (menu == 2) {
      return Menu(
          id: 2,
          image: "${Constant.image}employee.png",
          content: "Pengajuan Lembur",
          action: "");
    } else if (menu == 3) {
      return Menu(
          id: 3,
          image: "${Constant.image}test.png",
          content: "Persetujuan",
          action: "");
    } else if (menu == 4) {
      return Menu(
          id: 4,
          image: "${Constant.image}circular-clock.png",
          content: "Presensi",
          action: "");
    } else if (menu == 5) {
      return Menu(
          id: 5,
          image: "${Constant.image}form.png",
          content: "Daftar Presensi",
          action: "");
    } else if (menu == 6) {
      return Menu(
          id: 6,
          image: "${Constant.image}menuLainya.png",
          content: "Lihat Lainya",
          action: "");
    } else if (menu == 7) {
      return Menu(
          id: 7,
          image: "${Constant.image}slipGaji.png",
          content: "Slip Gaji",
          action: "");
    } else if (menu == 8) {
      return Menu(
          id: 8,
          image: "${Constant.image}peminjamanRuangan.png",
          content: "Peminjaman Ruangan",
          action: "");
    } else if (menu == 9) {
      return Menu(
          id: 9,
          image: "${Constant.image}peminjamanMobilDinas.png",
          content: "Peminjaman Mobil Dinas",
          action: "");
    } else if (menu == 10) {
      return Menu(
          id: 10,
          image: "${Constant.image}daftarKaryawan.png",
          content: "Daftar Karyawan",
          action: "");
    } else {
      return Menu(
          id: 11,
          image: "${Constant.image}websiteAPS.png",
          content: "Link Website APS",
          action: "");
    }
  }

  generateMenuUtama() {
    listMenu.clear();
    for (var i = 0; i < 6; i++) {
      listMenu.add(generateMenu("MENU${i + 1}"));
      setState(() {});
    }
  }

  generateMenuFavorit() {
    listMenuFavorit.clear();

    for (var i = 0; i < 6; i++) {
      listMenuFavorit.add(generateMenu("MENU${i + 1}"));
      stateBottom(() {});
    }
  }

  generateMenuLainya() {
    listMenuLainya.clear();
    for (var i = 6; i < 11; i++) {
      listMenuLainya.add(generateMenu("MENU${i + 1}"));
      stateBottom(() {});
    }
  }

  hideActionMenuFavorit() {
    for (var i = 0; i < listMenuFavorit.length; i++) {
      listMenuFavorit[i].action = "";
      stateBottom(() {});
    }
  }

  saveMenuFavorit() {
    for (var i = 0; i < 6; i++) {
      preference.setInt("MENU${i + 1}", listMenuFavorit[i].id);
    }
  }

  saveMenuLainya() {
    for (var i = 0; i < 5; i++) {
      preference.setInt("MENU${i + 7}", listMenuLainya[i].id);
    }
  }

  hideActionMenuLainya() {
    for (var i = 0; i < listMenuLainya.length; i++) {
      listMenuLainya[i].action = "";
      stateBottom(() {});
    }
  }

  showActionMenuFavorit() {
    for (int i = 0; i < listMenuFavorit.length; i++) {
      if (listMenuFavorit[i].content == "Lihat Lainya") {
        continue;
      }

      listMenuFavorit[i].action = "substract";
      stateBottom(() {});
    }
  }

  showActionMenuLainya() {
    for (int i = 0; i < listMenuLainya.length; i++) {
      listMenuLainya[i].action = "add";
      stateBottom(() {});
    }
  }

  String getImage(String action) {
    if (action == "add") {
      return "iconAddMenu.png";
    } else if (action == "substract") {
      return "iconMinusMenu.png";
    } else {
      return "";
    }
  }

  double setRightMargin(int position, String action) {
    if ((position + 1) % 3 == 0) {
      if (action != "") {
        return 7;
      } else {
        return 0;
      }
    } else {
      return 7;
    }
  }

  Widget wItemListMenu({List<Menu> list, int position, BuildContext context}) {
    var menu = list[position];

    return InkWell(
      onTap: () => onItemListMenuTap(menu, position, context),
      child: Container(
        margin: EdgeInsets.only(
            left: position % 3 == 0 ? 0 : 7,
            right: setRightMargin(position, menu.action),
            top: 5,
            bottom: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(7)),
            border:
                Border.all(color: Color(ColorKey.veryLightPinkTwo), width: 1)),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: Container(
                transform: Matrix4.translationValues(7, -7, 0),
                child: Image.asset("${Constant.image}${getImage(menu.action)}",
                    width: 14, height: 14),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    menu.image,
                    width: 38,
                    height: 38,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 7.2),
                    child: Text(
                      menu.content,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 9, color: Color(ColorKey.brownishGrey)),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget wMenuUtama() => Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 11.6),
            child: Row(
              children: <Widget>[
                wMenuTop(
                    image: '${Constant.image}happy.png',
                    title: waktuPresensi,
                    description: statusPresensi.toUpperCase(),
                    backgroundColor: ColorKey.tanGreen),
                Container(
                  width: 10,
                  color: Colors.white,
                ),
                wMenuTop(
                    image: '${Constant.image}fast.png',
                    title: capaianKerja,
                    description: "CAPAIAN / JAM KERJA",
                    backgroundColor: ColorKey.aquaBlue)
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 11.6),
            child: Row(
              children: <Widget>[
                wMenuTop(
                    image: '${Constant.image}portfolio.png',
                    title: jatahCuti,
                    description: "JATAH CUTI",
                    backgroundColor: ColorKey.sunYellow),
                Container(
                  width: 10,
                  color: Colors.white,
                ),
                wMenuTop(
                    image: '${Constant.image}presensi.png',
                    title: "",
                    description: "PRESENSI",
                    backgroundColor: ColorKey.coral,
                    clickListener: () => preparePresence()
                )
              ],
            ),
          ),
        ],
      );

  Widget wListMenu(List<Menu> list) => Container(
        margin: EdgeInsets.only(
          top: 5,
        ),
        child: GridView.builder(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, position) {
            return wItemListMenu(
                list: list, position: position, context: context);
          },
          itemCount: list.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, childAspectRatio: 1),
        ),
      );

  Widget wListBerita(BuildContext context) => Container(
        height: 164,
        margin: EdgeInsets.only(top: 10),
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, position) {
            return wItemListBerita(
                berita: listBerita[position],
                context: context,
                position: position);
          },
          itemCount: listBerita.length,
          scrollDirection: Axis.horizontal,
        ),
      );

  Widget wItemListBerita(
          {ItemLatestNews berita, BuildContext context, int position}) =>
      Container(
        width: MediaQuery.of(context).size.width * 0.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        margin: EdgeInsets.only(left: position == 0 ? 0 : 5),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5)),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: 100,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill, image: NetworkImage(berita.img))),
                  )),
              Container(
                margin: EdgeInsets.only(top: 10, left: 8, right: 8, bottom: 5),
                child: Text(
                  berita.title,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                      color: Color(ColorKey.brownishGrey),
                      fontSize: 12,
                      fontFamily: "Roboto-Medium"),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 8, right: 8, bottom: 10),
                child: Row(
                  children: <Widget>[
                    Image.asset(
                      "${Constant.image}calendarBerita.png",
                      height: 10,
                      width: 9,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 7.5),
                      child: Text(
                        berita.date,
                        style: TextStyle(
                            color: Color(ColorKey.veryLightPinkFive),
                            fontSize: 10,
                            fontFamily: "Roboto-Medium"),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );

  Widget wMenuTop(
          {image, title, description, backgroundColor, clickListener}) =>
      Expanded(
          child: InkWell(
        onTap: clickListener,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Color(backgroundColor),
              boxShadow: [
                BoxShadow(color: Colors.black12, spreadRadius: 3, blurRadius: 6)
              ]),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Image.asset(image, width: 25, height: 25),
                Container(
                    margin: EdgeInsets.only(top: 3.6),
                    child: Text(title,
                        style: TextStyle(color: Colors.white, fontSize: 13))),
                Container(
                    margin: EdgeInsets.only(top: 2.3),
                    child: Text(description,
                        style: TextStyle(color: Colors.white, fontSize: 8)))
              ],
            ),
          ),
        ),
      ));

  Widget wTextBeritaPengumuman() => Container(
        margin: EdgeInsets.only(top: 17.8),
        child: Row(
          children: <Widget>[
            Expanded(child: Text("Berita & Pengumuman")),
            Expanded(
              child: Text(
                "Selengkapnya...",
                textAlign: TextAlign.end,
                style: TextStyle(color: Color(ColorKey.darkSkyBlue)),
              ),
            )
          ],
        ),
      );

  Widget berandaWidget() => Theme(
      data: ThemeData(canvasColor: Colors.transparent),
      child: Scaffold(
        backgroundColor: Color(ColorKey.default_bg),
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
                  name,
                  style: TextStyle(fontSize: 12, fontFamily: "Roboto"),
                ),
                margin: EdgeInsets.only(left: 10),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Overview",
                style: TextStyle(
                    fontSize: 12, color: Color(ColorKey.brownishGrey)),
              ),
              wMenuUtama(),
              Container(
                  margin: EdgeInsets.only(top: 16),
                  child: Text(
                    "Menu utama",
                    style: TextStyle(
                        fontSize: 12, color: Color(ColorKey.brownishGrey)),
                  )),
              Container(
                margin: EdgeInsets.only(top: 11.6),
                color: Color(ColorKey.black).withAlpha(26),
                height: 1,
              ),
              wListMenu(listMenu),
              Container(
                margin: EdgeInsets.only(top: 11.6),
                color: Color(ColorKey.black).withAlpha(26),
                height: 1,
              ),
              wTextBeritaPengumuman(),
              wListBerita(context),
            ],
          ),
        )),
      ));

  @override
  Widget build(BuildContext context) {
    return berandaWidget();
  }
}
