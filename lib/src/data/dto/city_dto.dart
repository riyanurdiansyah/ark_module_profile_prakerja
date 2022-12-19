import '../../domain/entities/city_entity.dart';

class CityDTO extends CityEntity {
  const CityDTO({
    required super.kotaKabupaten,
  });

  factory CityDTO.fromJson(Map<String, dynamic> json) => CityDTO(
        kotaKabupaten: List<CityDataDTO>.from(
            json["kota_kabupaten"].map((x) => CityDataDTO.fromJson(x))),
      );
}

class CityDataDTO extends CityDataEntity {
  CityDataDTO({
    required super.id,
    required super.idProvinsi,
    required super.nama,
  });

  factory CityDataDTO.fromJson(Map<String, dynamic> json) => CityDataDTO(
        id: json["id"],
        idProvinsi: json["id_provinsi"],
        nama: json["nama"],
      );
}
