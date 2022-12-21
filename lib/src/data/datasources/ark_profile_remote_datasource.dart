import 'package:ark_module_profile_prakerja/src/data/dto/my_aktifitas_dto.dart';
import 'package:ark_module_profile_prakerja/src/data/dto/my_course_dto.dart';
import 'package:ark_module_profile_prakerja/src/data/dto/my_nilai_dto.dart';
import 'package:ark_module_profile_prakerja/src/data/dto/my_sertifikat_dto.dart';
import 'package:ark_module_profile_prakerja/src/data/dto/profile_dto.dart';

import '../dto/city_dto.dart';
import '../dto/provinsi_dto.dart';

abstract class ArkProfileRemoteDataSource {
  Future<ProfileDTO> getProfile(String baseUrl, String token);

  Future<List<MyCourseDTO>> getMyCourse(
      String baseUrl, String token, int perPage);

  Future<MySertifikatDTO> getMySertifikat(String baseUrl, int userId);

  Future<List<MyNilaiDTO>> getMyNilai(String baseUrl, String token);

  Future<List<MyAktifitasDTO>> getMyAktifitas(String baseUrl, String token);

  Future<bool> saveGenerateSertifikat(
      String baseUrl, String token, String courseId);

  Future<String> generateSertifikat(String baseUrl, int userId, int courseId);

  Future<ProvinsiDTO> getProvinsi();

  Future<CityDTO> getCity(int id);

  Future<bool> updateProfilePrakerja(
      String baseUrl, String token, Map<String, dynamic> body);

  Future<bool> updateProfile(String token, Map<String, dynamic> body);
}
