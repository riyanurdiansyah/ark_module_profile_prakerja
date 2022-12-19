import 'package:equatable/equatable.dart';

class CityEntity extends Equatable {
  const CityEntity({
    required this.kotaKabupaten,
  });

  final List<CityDataEntity> kotaKabupaten;

  @override
  List<Object?> get props => [kotaKabupaten];
}

class CityDataEntity {
  CityDataEntity({
    required this.id,
    required this.idProvinsi,
    required this.nama,
  });

  final int id;
  final String idProvinsi;
  final String nama;
}
