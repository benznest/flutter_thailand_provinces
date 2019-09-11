import 'package:flutter_thailand_provinces/dao/district_dao.dart';
import 'package:flutter_thailand_provinces/flutter_thailand_provinces.dart';

class DistrictProvider {
  static const String TABLE_DISTRICT = "districts";

  static Future<List<DistrictDao>> all({int amphureId = 0}) async {
    String where;
    List<dynamic> whereArgs;
    if (amphureId > 0) {
      where = "amphure_id = ?";
      whereArgs = ["$amphureId"];
    }

    List<Map<String, dynamic>> mapResult = await ThailandProvincesDatabase.db
        .query(TABLE_DISTRICT, where: where, whereArgs: whereArgs);

    List<DistrictDao> listDistrict = mapDistrictList(mapResult);

    return listDistrict;
  }

  static List<DistrictDao> mapDistrictList(
      List<Map<String, dynamic>> mapResult) {
    List<DistrictDao> listDistrict = List();
    for (Map mapRow in mapResult) {
      listDistrict.add(DistrictDao.fromJson(mapRow));
    }
    return listDistrict;
  }

  static Future<List<DistrictDao>> searchInAmphure(
      {int amphureId = 1, String keyword = ""}) async {
    List<Map<String, dynamic>> mapResult = await ThailandProvincesDatabase.db
        .query(TABLE_DISTRICT,
            where: "(amphure_id = ?) AND ( name_th LIKE ? OR name_en LIKE ? )",
            whereArgs: ["$amphureId", "%$keyword%", "%$keyword%"]);

    List<DistrictDao> listDistrict = mapDistrictList(mapResult);

    return listDistrict;
  }
}
