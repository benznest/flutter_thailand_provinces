import 'package:flutter_thailand_provinces/dao/amphure_dao.dart';
import 'package:flutter_thailand_provinces/flutter_thailand_provinces.dart';
import 'package:sqflite/sqflite.dart';

class AmphureProvider {

  static const String TABLE_AMPHURES = "amphures";

  static Future<List<AmphureDao>> all({int provinceId = 0}) async {
    String where;
    List<dynamic> whereArgs;
    if (provinceId > 0) {
      where = "province_id = ?";
      whereArgs = ["$provinceId"];
    }

    List<Map<String, dynamic>> mapResult = await ThailandProvincesDatabase.db.query(TABLE_AMPHURES, where: where, whereArgs: whereArgs);
    List<AmphureDao> listAmphures = mapAmphuresList(mapResult);

    return listAmphures;
  }

  static Future<List<AmphureDao>> searchInProvince({int provinceId = 1, String keyword = ""}) async {
    List<Map<String, dynamic>> mapResult = await ThailandProvincesDatabase.db
        .query(TABLE_AMPHURES, where: "(province_id = ?) AND ( name_th LIKE ? OR name_en LIKE ? )", whereArgs: ["$provinceId", "%$keyword%", "%$keyword%"]);

    List<AmphureDao> listAmphures = mapAmphuresList(mapResult);

    return listAmphures;
  }

  static List<AmphureDao> mapAmphuresList(List<Map<String, dynamic>> mapResult) {
    List<AmphureDao> listAmphures = List();
    for (Map mapRow in mapResult) {
      listAmphures.add(AmphureDao.fromJson(mapRow));
    }
    return listAmphures;
  }
}
