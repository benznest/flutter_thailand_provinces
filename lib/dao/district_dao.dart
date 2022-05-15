class DistrictDao {
  int id;
  String? zipCode;
  String? nameTh;
  String? nameEn;
  int amphureId;

  DistrictDao({
    required this.id,
    this.zipCode,
    this.nameTh,
    this.nameEn,
    required this.amphureId,
  });

  factory DistrictDao.fromJson(Map<String, dynamic> json) {
    return DistrictDao(
      id: int.parse(json["id"]),
      zipCode: json["zip_code"],
      nameTh: json["name_th"],
      nameEn: json["name_en"],
      amphureId: int.parse(json["amphure_id"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "zip_code": this.zipCode,
      "name_th": this.nameTh,
      "name_en": this.nameEn,
      "amphure_id": this.amphureId,
    };
  }
}
