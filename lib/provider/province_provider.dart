import 'package:flutter_thailand_provinces/dao/amphure_dao.dart';
import 'package:flutter_thailand_provinces/dao/province_dao.dart';
import 'package:flutter_thailand_provinces/flutter_thailand_provinces.dart';
import 'package:flutter_thailand_provinces/provider/address_provider.dart';
import 'package:sqflite/sqflite.dart';

class ProvinceProvider {
  static const String TABLE_PROVINCES = "provinces";

  static Future<List<ProvinceDao>> all() async {

    List<Map<String, dynamic>> mapResult = await ThailandProvincesDatabase.db.query(TABLE_PROVINCES);

    List<ProvinceDao> listProvinces = mapProvinceList(mapResult);

    return listProvinces;
  }

  static List<ProvinceDao> mapProvinceList(List<Map<String, dynamic>> mapResult) {
    List<ProvinceDao> listProvinces = List();
    for (Map mapRow in mapResult) {
      listProvinces.add(ProvinceDao.fromJson(mapRow));
    }
    return listProvinces;
  }

  static Future<List<ProvinceDao>> search({String keyword = ""}) async {
    List<Map<String, dynamic>> mapResult =
        await ThailandProvincesDatabase.db.query(TABLE_PROVINCES, where: "name_th LIKE ? OR name_en LIKE ?", whereArgs: ["%$keyword%", "%$keyword%"]);

    List<ProvinceDao> listProvinces = mapProvinceList(mapResult);

    return listProvinces;
  }
}
