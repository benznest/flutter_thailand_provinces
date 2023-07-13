class AmphureDao {
  int id;
  String? code;
  String? nameTh;
  String? nameEn;
  int provinceId;

  AmphureDao({
    required this.id,
    this.code,
    this.nameTh,
    this.nameEn,
    required this.provinceId,
  });

  factory AmphureDao.fromJson(Map<String, dynamic> json) {
    return AmphureDao(
      id: int.parse(json["id"]),
      code: json["code"],
      nameTh: json["name_th"],
      nameEn: json["name_en"],
      provinceId: int.parse(json["province_id"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "code": this.code,
      "name_th": this.nameTh,
      "name_en": this.nameEn,
      "province_id": this.provinceId,
    };
  }
}
