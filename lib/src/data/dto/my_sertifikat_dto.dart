import 'package:ark_module_profile_prakerja/src/domain/entities/my_sertifikat_entity.dart';

class MySertifikatDTO extends MySertifikatEntity {
  MySertifikatDTO({
    required super.success,
    required super.certificates,
  });

  factory MySertifikatDTO.fromJson(Map<String, dynamic> json) =>
      MySertifikatDTO(
        success: json["success"],
        certificates: List<MySertifikatDataDTO>.from(
            json["certificates"].map((x) => MySertifikatDataDTO.fromJson(x))),
      );
}

class MySertifikatDataDTO extends MySertifikatDataEntity {
  MySertifikatDataDTO({
    required super.id,
    required super.courseName,
    required super.certDate,
    required super.certUrl,
    required super.certId,
    required super.remainingGen,
  });

  factory MySertifikatDataDTO.fromJson(Map<String, dynamic> json) =>
      MySertifikatDataDTO(
        id: json["id"] ?? 0,
        courseName: json["course_name"] ?? "",
        certDate: json["cert_date"] ?? "",
        certUrl: json["cert_url"] ?? "",
        certId: json["cert_id"] ?? "",
        remainingGen: json["remaining_gen"] ?? 0,
      );
}
