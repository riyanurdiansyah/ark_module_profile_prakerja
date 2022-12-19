import '../../domain/entities/provinsi_entity.dart';

class ProvinsiDTO extends ProvinsiEntity {
  const ProvinsiDTO({
    required super.provinsi,
  });

  factory ProvinsiDTO.fromJson(Map<String, dynamic> json) => ProvinsiDTO(
        provinsi: List<ProvinsiDataDTO>.from(
            json["provinsi"].map((x) => ProvinsiDataDTO.fromJson(x))),
      );
}

class ProvinsiDataDTO extends ProvinsiDataEntity {
  const ProvinsiDataDTO({
    required super.id,
    required super.nama,
  });

  factory ProvinsiDataDTO.fromJson(Map<String, dynamic> json) =>
      ProvinsiDataDTO(
        id: json["id"],
        nama: json["nama"],
      );
}
