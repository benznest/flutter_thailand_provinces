class ProvinceDao {
  int id;
  String code;
  String nameTh;
  String nameEn;
  int geographyId;

  ProvinceDao({this.id, this.code, this.nameTh, this.nameEn, this.geographyId});

  factory ProvinceDao.fromJson(Map<String, dynamic> json) {
    return ProvinceDao(
      id: int.parse(json["id"]),
      code: json["code"],
      nameTh: json["name_th"],
      nameEn: json["name_en"],
      geographyId: int.parse(json["geography_id"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "code": this.code,
      "name_th": this.nameTh,
      "name_en": this.nameEn,
      "geography_id": this.geographyId,
    };
  }
}
