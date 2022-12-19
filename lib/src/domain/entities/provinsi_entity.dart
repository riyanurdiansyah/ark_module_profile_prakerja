import 'package:equatable/equatable.dart';

class ProvinsiEntity extends Equatable {
  const ProvinsiEntity({
    required this.provinsi,
  });

  final List<ProvinsiDataEntity> provinsi;

  @override
  List<Object?> get props => [provinsi];
}

class ProvinsiDataEntity extends Equatable {
  const ProvinsiDataEntity({
    required this.id,
    required this.nama,
  });

  final int id;
  final String nama;

  @override
  List<Object?> get props => [id, nama];
}
