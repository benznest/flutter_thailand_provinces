import 'package:flutter/material.dart';
import 'package:flutter_thailand_provinces_example/screens/address_list_screen.dart';
import 'package:flutter_thailand_provinces_example/screens/provinces_list_screen.dart';
import 'package:flutter_thailand_provinces/provider/province_provider.dart';
import 'package:flutter_thailand_provinces/dialog/choose_province_dialog.dart';
import 'package:flutter_thailand_provinces/dao/province_dao.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProvinceDao provinceSelected;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue,
          title: Text("Thailand Provinces Database"),
        ),
        body: Container(
          color: Colors.grey[200],
          child: ListView(
            padding: EdgeInsets.all(16),
            children: <Widget>[
//              GestureDetector(
//                onTap: () {
//                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProvincesListScreen()));
//                },
//                child: Container(
//                  padding: EdgeInsets.all(16),
//                  decoration: BoxDecoration(
//                      borderRadius: BorderRadius.circular(16), color: Colors.white, boxShadow: [BoxShadow(color: Colors.grey[300], blurRadius: 80, offset: Offset(0, 10))]),
//                  child: Row(
//                    children: <Widget>[
//                      Expanded(
//                        child: Text(
//                          "จังหวัด > อำเภอ > ตำบล",
//                          style: TextStyle(fontSize: 20),
//                        ),
//                      ),
//                      Icon(
//                        Icons.arrow_forward_ios,
//                        color: Colors.grey[600],
//                      )
//                    ],
//                  ),
//                ),
//              ),
//              SizedBox(
//                height: 8,
//              ),
//              GestureDetector(
//                onTap: () {
//                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddressListScreen()));
//                },
//                child: Container(
//                  padding: EdgeInsets.all(16),
//                  decoration: BoxDecoration(
//                      borderRadius: BorderRadius.circular(16), color: Colors.white, boxShadow: [BoxShadow(color: Colors.grey[300], blurRadius: 80, offset: Offset(0, 10))]),
//                  child: Row(
//                    children: <Widget>[
//                      Expanded(
//                        child: Text(
//                          "ค้นหาที่อยู่",
//                          style: TextStyle(fontSize: 20),
//                        ),
//                      ),
//                      Icon(
//                        Icons.arrow_forward_ios,
//                        color: Colors.grey[600],
//                      )
//                    ],
//                  ),
//                ),
//              ),
//              SizedBox(
//                height: 8,
//              ),
              GestureDetector(
                onTap: () async {
                  List list = await ProvinceProvider.all();
                  ProvinceDao province = await ChooseProvinceDialog.show(
                    context,
                    listProvinces: list,
                    colorBackgroundHeader: Colors.purple[300],
                    colorLineHeader: Colors.purple[500],
                    styleTitle: TextStyle(fontSize: 18, fontFamily: "Kanit-Regular"),
                    styleSubTitle: TextStyle(fontSize: 14, fontFamily: "Kanit-Regular", color: Colors.grey[400]),
                    styleTextNoData: TextStyle(fontFamily: "Kanit-Regular"),
                    styleTextSearchHint: TextStyle(fontFamily: "Kanit-Regular"),
                    styleTextSearch: TextStyle(fontFamily: "Kanit-Regular"),
                  );
                  setState(() {
                    provinceSelected = province;
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16), color: Colors.white, boxShadow: [BoxShadow(color: Colors.grey[300], blurRadius: 80, offset: Offset(0, 10))]),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              provinceSelected == null ? "เลือกจังหวัด" : provinceSelected.nameTh,
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              provinceSelected == null ? "" : provinceSelected.nameEn,
                              style: TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: Colors.grey[600],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
