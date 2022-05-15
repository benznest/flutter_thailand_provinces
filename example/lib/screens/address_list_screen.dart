import 'package:flutter/material.dart';
import 'package:flutter_thailand_provinces/provider/address_provider.dart';
import 'package:flutter_thailand_provinces/dao/address_dao.dart';
import 'package:flutter_thailand_provinces/dao/amphure_dao.dart';
import 'package:flutter_thailand_provinces/dao/province_dao.dart';
import 'package:flutter_thailand_provinces_example/screens/districts_list_screen.dart';

class AddressListScreen extends StatefulWidget {
  AddressListScreen();

  @override
  _AddressListScreenState createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  List<AddressDao> listAddresses;
  TextEditingController _searchAddressController = TextEditingController();
  String keyword = "";

  @override
  void initState() {
    listAddresses = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal[300],
        elevation: 0,
        title: Text("ที่อยู่"),
      ),
      body: Column(
        children: <Widget>[
          buildSearchContainer(),
          Expanded(
              child: FutureBuilder(
            future: AddressProvider.search(keyword: keyword),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                listAddresses = snapshot.data;
                return buildListView();
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return Text("กำลังโหลด");
              }
            },
          )),
        ],
      ),
    );
  }

  Widget buildListView() {
    return Stack(
      children: <Widget>[
        ListView.builder(
            itemCount: listAddresses.length,
            itemBuilder: (context, index) {
              return buildRowAddress(listAddresses[index]);
            }),
        Center(
            child: Visibility(
                visible: listAddresses.isEmpty,
                child: Text(
                  "ไม่มีข้อมูล",
                  style: TextStyle(fontSize: 22),
                )))
      ],
    );
  }

  Widget buildRowAddress(AddressDao address) {
    return GestureDetector(
        onTap: () {
          //
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
                  Row(
                    children: <Widget>[
                      Text(
                        address.district.nameTh,
                        style: TextStyle(
                            fontSize: 18,
                            color: getColorHighlight(address.district.nameTh)),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        ", " + address.amphure.nameTh,
                        style: TextStyle(
                            fontSize: 18,
                            color: getColorHighlight(address.amphure.nameTh)),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        address.district.zipCode == "0"
                            ? ""
                            : address.district.zipCode,
                        style: TextStyle(
                            fontSize: 18,
                            color: getColorHighlight(address.district.zipCode)),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        address.province.nameTh,
                        style: TextStyle(
                            fontSize: 14,
                            color: getColorHighlight(address.province.nameTh)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        address.district.nameEn,
                        style: TextStyle(
                            fontSize: 14,
                            color: getColorHighlight(address.district.nameEn)),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        ", " + address.amphure.nameEn,
                        style: TextStyle(
                            fontSize: 14,
                            color: getColorHighlight(address.amphure.nameEn)),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        address.province.nameEn,
                        style: TextStyle(
                            fontSize: 14,
                            color: getColorHighlight(address.province.nameEn)),
                      ),
                    ],
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

  Color getColorHighlight(String text) {
    if (keyword.isEmpty) {
      return Colors.grey[700];
    } else {
      if (text.toLowerCase().contains(keyword.toLowerCase())) {
        return Colors.red[400];
      }
      return Colors.grey[400];
    }
  }

  Widget buildSearchContainer() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.teal[300],
          border:
              Border(bottom: BorderSide(color: Colors.teal[400], width: 4))),
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
      child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: TextField(
            controller: _searchAddressController,
            decoration: InputDecoration.collapsed(
                hintText: "ที่อยู่ ตำบล/อำเภอ/เลขไปรษณีย์"),
            onChanged: (text) async {
              setState(() {
                keyword = text;
              });
            },
          )),
    );
  }
}
