import 'package:flutter_thailand_provinces/dao/address_dao.dart';
import 'package:flutter_thailand_provinces/dao/province_dao.dart';
import 'package:flutter_thailand_provinces/dao/amphure_dao.dart';
import 'package:flutter_thailand_provinces/dao/district_dao.dart';
import 'package:flutter_thailand_provinces/flutter_thailand_provinces.dart';
import 'package:flutter_thailand_provinces/my_utils.dart';
import 'package:flutter_thailand_provinces/provider/province_provider.dart';
import 'package:flutter_thailand_provinces/provider/amphure_provider.dart';
import 'package:flutter_thailand_provinces/provider/district_provider.dart';

class AddressProvider {
  static const String _BASE_SQL = ""
      " SELECT "
      "      P.id           AS p_id, "
      "      P.code         AS p_code, "
      "      P.name_th      AS p_name_th, "
      "      P.name_en      AS p_name_en, "
      "      P.geography_id AS p_geography_id, "
      "      A.id           AS a_id , "
      "      A.code         AS a_code , "
      "      A.name_th      AS a_name_th , "
      "      A.name_en      AS a_name_en , "
      "      A.province_id  AS a_province_id , "
      "      D.id           AS d_id ,"
      "      D.zip_code     AS d_zip_code , "
      "      D.name_th      AS d_name_th , "
      "      D.name_en      AS d_name_en , "
      "      D.amphure_id   AS d_amphure_id "
      " FROM  ${ProvinceProvider.TABLE_PROVINCES} P "
      "       JOIN  ${AmphureProvider.TABLE_AMPHURES}  A ON A.province_id = P.id "
      "       JOIN  ${DistrictProvider.TABLE_DISTRICT} D ON D.amphure_id  = A.id ";

  static Future<List<AddressDao>> all({int provinceId = 0}) async {
    String sql = _BASE_SQL;
    if (provinceId > 0) {
      sql = sql + " WHERE  P.id = ? ";
    }
    List<Map<String, dynamic>> mapResult = await ThailandProvincesDatabase.db.rawQuery(sql, ["$provinceId"]);

    List<AddressDao> listAddress = mapAddressList(mapResult);
    return listAddress;
  }

  static Future<List<AddressDao>> search({String keyword = ""}) async {
    String sql = _BASE_SQL +
        " WHERE  "
            " P.name_en LIKE ? OR P.name_th LIKE ? OR "
            " A.name_en LIKE ? OR A.name_th LIKE ? OR "
            " D.name_en LIKE ? OR D.name_th LIKE ? OR "
            " D.zip_code LIKE ? "
            " ";
    List<Map<String, dynamic>> mapResult = await ThailandProvincesDatabase.db.rawQuery(sql, [
      "%$keyword%",
      "%$keyword%",
      "%$keyword%",
      "%$keyword%",
      "%$keyword%",
      "%$keyword%",
      "%$keyword%",
    ]);

    List<AddressDao> listAddress = mapAddressList(mapResult);
    return listAddress;
  }

  static Future<List<AddressDao>> searchInProvince({int provinceId = 1, String keyword = ""}) async {
    String sql = _BASE_SQL +
        " WHERE  "
            " P.id = ? AND ( "
            " P.name_en LIKE ? OR P.name_th LIKE ? OR "
            " A.name_en LIKE ? OR A.name_th LIKE ? OR "
            " D.name_en LIKE ? OR D.name_th LIKE ? OR "
            " D.zip_code LIKE ? "
            " ) ";
    List<Map<String, dynamic>> mapResult = await ThailandProvincesDatabase.db.rawQuery(sql, [
      "$provinceId"
      "%$keyword%",
      "%$keyword%",
      "%$keyword%",
      "%$keyword%",
      "%$keyword%",
      "%$keyword%",
      "%$keyword%",
    ]);

    List<AddressDao> listAddress = mapAddressList(mapResult);
    return listAddress;
  }

  static List<AddressDao> mapAddressList(List<Map<String, dynamic>> mapResult) {
    List<AddressDao> listAddress = List();
    if (mapResult.isNotEmpty) {
      for (Map map in mapResult) {
        AddressDao address = AddressDao(
            province:
                ProvinceDao(id: int.parse(map["p_id"]), code: map["p_code"], nameTh: map["p_name_th"], nameEn: map["p_name_en"], geographyId: int.parse(map["p_geography_id"])),
            amphure: AmphureDao(id: int.parse(map["a_id"]), code: map["a_code"], nameTh: map["a_name_th"], nameEn: map["a_name_en"], provinceId: int.parse(map["a_province_id"])),
            district:
                DistrictDao(id: int.parse(map["d_id"]), nameTh: map["d_name_th"], nameEn: map["d_name_en"], zipCode: map["d_zip_code"], amphureId: int.parse(map["d_amphure_id"])));
        listAddress.add(address);
      }
    }

    return listAddress;
  }
}
