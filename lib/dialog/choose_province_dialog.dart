import 'package:flutter/material.dart';
import 'package:flutter_thailand_provinces/provider/province_provider.dart';
import 'package:flutter_thailand_provinces/dao/province_dao.dart';

class ChooseProvinceDialog extends StatefulWidget {
  final List<ProvinceDao> listProvinces;

  ChooseProvinceDialog({this.listProvinces});

  static show(BuildContext context, {@required List<ProvinceDao> listProvinces}) {
    return showDialog(
        context: context,
        builder: (context) {
          return ChooseProvinceDialog(
            listProvinces: listProvinces,
          );
        });
  }

  @override
  _ChooseProvinceDialogState createState() => _ChooseProvinceDialogState();
}

class _ChooseProvinceDialogState extends State<ChooseProvinceDialog> {
  List<ProvinceDao> listProvincesFilter;
  TextEditingController _searchProvinceController = TextEditingController();

  @override
  void initState() {
    listProvincesFilter = List.of(widget.listProvinces);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
//          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          width: 300,
          height: 420,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              buildSearchContainer(),
              Container(
                color: Colors.blue[600],
                height: 4,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(bottom: Radius.circular(16))),
                  padding: EdgeInsets.all(8),
                  child: buildListView(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListView() {
    return Stack(
      children: <Widget>[
        ListView.builder(
            itemCount: listProvincesFilter.length,
            itemBuilder: (context, index) {
              return buildRowProvince(listProvincesFilter[index]);
            }),
        Center(
            child: Visibility(
                visible: listProvincesFilter.isEmpty,
                child: Text(
                  "ไม่มีข้อมูล",
                  style: TextStyle(fontSize: 22),
                )))
      ],
    );
  }

  Widget buildRowProvince(ProvinceDao province) {
    return GestureDetector(
        onTap: () {
          Navigator.pop(context,province);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    province.nameTh,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    province.nameEn,
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
      padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
      decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      child: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.7), borderRadius: BorderRadius.circular(8)),
              child: TextField(
                controller: _searchProvinceController,
                decoration: InputDecoration.collapsed(hintText: "จังหวัด.."),
                onChanged: (text) async {
                  List list = widget.listProvinces.where((item) {
                    return item.nameTh.contains(text) || item.nameEn.contains(text);
                  }).toList();

                  setState(() {
                    listProvincesFilter = list;
                  });
                },
              )),
        ],
      ),
    );
  }
}
