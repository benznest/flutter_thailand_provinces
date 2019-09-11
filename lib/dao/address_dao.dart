import 'package:flutter_thailand_provinces/dao/amphure_dao.dart';
import 'package:flutter_thailand_provinces/dao/district_dao.dart';
import 'package:flutter_thailand_provinces/dao/province_dao.dart';

class AddressDao {
  ProvinceDao province;
  AmphureDao amphure;
  DistrictDao district;

  AddressDao({this.province, this.amphure, this.district});

  Map<String, dynamic> toJson() {
    return {
      "province": this.province.toJson(),
      "amphure": this.amphure.toJson(),
      "district": this.district.toJson(),
    };
  }
}
