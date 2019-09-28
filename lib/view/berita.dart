import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../networking/service/information_networking.dart';
import '../model/getLatestNews/item_latest_news.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'splash_screen.dart';
import '../constant/Constant.dart';
import '../constant/ColorKey.dart';
import 'base_view.dart';

class Berita extends StatefulWidget {
  @override
  BeritaState createState() => BeritaState();
}

class BeritaState extends State<Berita> with BaseView {
  var listBerita = List<ItemLatestNews>();
  var currentPage = 0;
  var totalPage = 0;

  @override
  void initState() {
    super.initState();
    
    SharedPreferences.getInstance().then((preference) {
      getBerita(preference);
    });
  }

  getBerita(preference) async {
    var allNews = await InformationNetworking().getAllNews(currentPage);

    if (allNews.status == 200) {
      setState(() {
        listBerita = allNews.data.news;
      });
    } else if (allNews.status == 401) {
      forceLogout(preference, context);
    } else {
      Fluttertoast.showToast(msg: allNews.message);
    }
  }

  Widget body() => ListView.builder(
        itemBuilder: (context, index) {
          return wItemListBerita(
              berita: listBerita[index], context: context, position: index);
        },
        itemCount: listBerita.length,
        scrollDirection: Axis.vertical,
      );

  Widget wItemListBerita(
          {ItemLatestNews berita, BuildContext context, int position}) =>
      Container(
        width: MediaQuery.of(context).size.width - 28,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        margin: EdgeInsets.only(
            left: 14,
            right: 14,
            top: 15,
            bottom: position == listBerita.length - 1 ? 15 : 0),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5)),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 28,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(ColorKey.default_bg),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: <Widget>[
            Container(
              child: Text(
                "Berita",
                style: TextStyle(fontSize: 12, fontFamily: "Roboto"),
              ),
            )
          ],
        ),
      ),
      body: body(),
    );
  }
}
