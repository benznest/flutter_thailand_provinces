import 'package:flutter/material.dart';
import 'package:flutter_thailand_provinces/provider/amphure_provider.dart';
import 'package:flutter_thailand_provinces/dao/amphure_dao.dart';
import 'package:flutter_thailand_provinces/dao/province_dao.dart';
import 'package:flutter_thailand_provinces_example/screens/districts_list_screen.dart';

class AmphuresListScreen extends StatefulWidget {
  final ProvinceDao province;

  AmphuresListScreen({this.province});

  @override
  _AmphuresListScreenState createState() => _AmphuresListScreenState();
}

class _AmphuresListScreenState extends State<AmphuresListScreen> {
  List<AmphureDao> listAmphure;
  List<AmphureDao> listAmphureFilter;
  TextEditingController _searchAmphureController = TextEditingController();

  @override
  void initState() {
    listAmphure = [];
    listAmphureFilter = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green[300],
        elevation: 0,
        title: Text(widget.province.nameTh),
      ),
      body: Column(
        children: <Widget>[
          buildSearchContainer(),
          Expanded(
            child: listAmphure.isEmpty
                ? FutureBuilder(
                    future: AmphureProvider.all(provinceId: widget.province.id),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        listAmphure = snapshot.data;
                        listAmphureFilter = List.of(listAmphure);
                        return buildListView();
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      } else {
                        return Text("กำลังโหลด");
                      }
                    },
                  )
                : buildListView(),
          ),
        ],
      ),
    );
  }

  Widget buildListView() {
    return Stack(
      children: <Widget>[
        ListView.builder(
            itemCount: listAmphureFilter.length,
            itemBuilder: (context, index) {
              return buildRowAmphure(listAmphureFilter[index]);
            }),
        Center(
            child: Visibility(
                visible: listAmphureFilter.isEmpty,
                child: Text(
                  "ไม่มีข้อมูล",
                  style: TextStyle(fontSize: 22),
                )))
      ],
    );
  }

  Widget buildRowAmphure(AmphureDao amphure) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DistrictsListScreen(
                        amphure: amphure,
                      )));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    amphure.nameTh,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    amphure.nameEn,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[200],
            )
          ],
        ));
  }

  Widget buildSearchContainer() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.green[300],
          border:
              Border(bottom: BorderSide(color: Colors.green[400], width: 4))),
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
      child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: TextField(
            controller: _searchAmphureController,
            decoration: InputDecoration.collapsed(hintText: "อำเภอ.."),
            onChanged: (text) async {
              List list = await AmphureProvider.searchInProvince(
                  provinceId: widget.province.id, keyword: text);
              print("${list.length}");
              setState(() {
                listAmphureFilter = list;
              });
            },
          )),
    );
  }
}
