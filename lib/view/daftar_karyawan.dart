import 'package:flutter/material.dart';
import 'package:flutter_playground/view/base_view.dart';
import '../constant/Constant.dart';
import '../constant/ColorKey.dart';
import '../model/getEmpList/item_emp_list.dart';
import '../networking/service/information_networking.dart';
import '../networking/request/get_emp_list_request.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'splash_screen.dart';
import 'profil.dart';
import '../model/getProfile/item_get_profile.dart';
import 'filter_daftar_karyawan.dart';
import 'base_view.dart';

class DaftarKaryawan extends StatefulWidget {
  @override
  DaftarKaryawanState createState() => DaftarKaryawanState();
}

class DaftarKaryawanState extends State<DaftarKaryawan> with BaseView {
  
  var listKaryawan = List<ItemEmpList>();
  var currentPage = 0;
  var totalPage = 0;
  var order = "a_to_z";
  var emp_name = "";
  var unit_id = "";
  var workarea_id = "";
  var gender = "";
  var preference;
  ScrollController _scrollController = ScrollController();
  
  @override
  void initState() {
    super.initState();
    
    SharedPreferences.getInstance().then((SharedPreferences mPreference) {
      preference = mPreference;
      getDaftarKaryawan();
      _scrollController.addListener(scrollListener);
    });
  }

  scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      if (currentPage + 1 <= totalPage) {
        print("get more data");
        getDaftarKaryawan();
      }
    }
  }
  
  getDaftarKaryawan() async {
    final body = GetEmpListRequest(order, emp_name, unit_id, workarea_id, gender, "$currentPage");
    showLoading(context);
    var daftarKaryawan = await InformationNetworking().getEmpList(body);
    hideDialog(context);
    if (daftarKaryawan.status == 200) {
      totalPage = daftarKaryawan.data.total_page;
      currentPage += 1;
      listKaryawan.addAll(daftarKaryawan.data.emp);
      setState(() {});
    } else if (daftarKaryawan.status == 401) {
      forceLogout(preference, context);
    } else {
      Fluttertoast.showToast(msg: daftarKaryawan.message);
    }
  }
  
  Widget wBody() => ListView.builder(
    controller: _scrollController,
    physics: BouncingScrollPhysics(),
    itemCount: listKaryawan.length,
    itemBuilder: (context, index){
      return wItemListKaryawan(listKaryawan[index], index, context);
    },
  );
  
  Widget wItemListKaryawan(ItemEmpList item, int index, BuildContext context) => InkWell(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Profil(true, ItemGetProfile(item.emp_id, item.emp_name, item.position, item.unit, "", "", "", "", ""))));
    },
    child: Container(
      margin: EdgeInsets.only(top: index == 0 ? 20 : 13.3, left: 14.2, right: 14.2, bottom: index == listKaryawan.length - 1 ? 20 : 0),
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 99.6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(3), topRight: Radius.circular(3)),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("${Constant.image}profilBackground.png"))),
              ),
              Container(
                height: 99.6,
                decoration: BoxDecoration(
                  color: Color(ColorKey.black).withOpacity(0.85),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(3), topRight: Radius.circular(3))
                ),
              ),
              Center(
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 16),
                    child: Container(
                      width: 67.6,
                      height: 67.6,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fill, image: NetworkImage(item.img))),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 8.2,),
          Text(item.emp_name, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, fontFamily: "Roboto", color: Color(ColorKey.brownishGrey)),),
          SizedBox(height: 4.1,),
          Text(item.position, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w400, fontFamily: "Roboto", color: Color(ColorKey.blueGrey)),),
          SizedBox(height: 4.1,),
          Text(item.emp_name, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w400, fontFamily: "Roboto", color: Color(ColorKey.darkSkyBlue)),),
          SizedBox(height: 12.9,),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(3)),
        color: Colors.white,
        boxShadow: [BoxShadow(
          color: Colors.black12,
          blurRadius: 5,
          spreadRadius: 2
        )]
      ),
    ),
  );

  goToFilter(BuildContext context) async {
    final data = await Navigator.push(context, MaterialPageRoute(builder: (context) => FilterDaftarKaryawan()),) as Map<String, String>;
    emp_name = data["name"];
    unit_id = data["unit"];
    workarea_id = data["workarea"];
    gender = data["gender"];
    order = data["order"];
    currentPage = 0;
    listKaryawan.clear();
    getDaftarKaryawan();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(ColorKey.default_bg),
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
              onTap: () => goToFilter(context),
              child: Image.asset("${Constant.image}icFilter.png", width: 16, height: 16,),
            )
          ],
        ),
      ),
      body: wBody(),
    );
  }
}
