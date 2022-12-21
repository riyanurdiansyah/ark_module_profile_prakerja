import 'package:ark_module_profile_prakerja/src/core/failures.dart';
import 'package:ark_module_profile_prakerja/src/domain/entities/my_aktifitas_entity.dart';
import 'package:ark_module_profile_prakerja/src/domain/entities/my_course_entity.dart';
import 'package:ark_module_profile_prakerja/src/domain/entities/my_nilai_entity.dart';
import 'package:ark_module_profile_prakerja/src/domain/entities/my_sertifikat_entity.dart';
import 'package:ark_module_profile_prakerja/src/domain/entities/profile_entity.dart';
import 'package:dartz/dartz.dart';

import '../entities/city_entity.dart';
import '../entities/provinsi_entity.dart';

abstract class ArkProfileRepository {
  Future<Either<Failure, ProfileEntity>> getProfile(
      String baseUrl, String token);

  Future<Either<Failure, List<MyCourseEntity>>> getMyCourse(
      String baseUrl, String token, int perPage);

  Future<Either<Failure, MySertifikatEntity>> getMySertifikat(
      String baseUrl, int userId);

  Future<Either<Failure, List<MyNilaiEntity>>> getMyNilai(
      String baseUrl, String token);

  Future<Either<Failure, List<MyAktifitasEntity>>> getMyAktifitas(
      String baseUrl, String token);

  Future<Either<Failure, bool>> saveGenerateSertifikat(
      String baseUrl, String token, String courseId);

  Future<Either<Failure, String>> generateSertifikat(
      String baseUrl, int userId, int courseId);

  Future<Either<Failure, ProvinsiEntity>> getProvinsi();

  Future<Either<Failure, CityEntity>> getCity(int id);

  Future<Either<Failure, bool>> updateProfilePrakerja(
      String baseUrl, String token, Map<String, dynamic> body);

  Future<Either<Failure, bool>> updateProfile(
      String token, Map<String, dynamic> profile);
}
