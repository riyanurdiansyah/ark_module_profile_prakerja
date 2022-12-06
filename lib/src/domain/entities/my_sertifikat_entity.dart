class MySertifikatEntity {
  MySertifikatEntity({
    required this.success,
    required this.certificates,
  });

  final bool success;
  final List<MySertifikatDataEntity> certificates;

  MySertifikatEntity copyWith({
    bool? success,
    List<MySertifikatDataEntity>? certificates,
  }) =>
      MySertifikatEntity(
        success: success ?? this.success,
        certificates: certificates ?? this.certificates,
      );
}

class MySertifikatDataEntity {
  MySertifikatDataEntity({
    required this.id,
    required this.courseName,
    required this.certDate,
    required this.certUrl,
    required this.certId,
    required this.remainingGen,
  });

  final int id;
  final String courseName;
  final String certDate;
  final String certUrl;
  final String certId;
  final int remainingGen;

  MySertifikatDataEntity copyWith({
    int? id,
    String? courseName,
    String? certDate,
    String? certUrl,
    String? certId,
    int? remainingGen,
  }) =>
      MySertifikatDataEntity(
        id: id ?? this.id,
        courseName: courseName ?? this.courseName,
        certDate: certDate ?? this.certDate,
        certUrl: certUrl ?? this.certUrl,
        certId: certId ?? this.certId,
        remainingGen: remainingGen ?? this.remainingGen,
      );
}
