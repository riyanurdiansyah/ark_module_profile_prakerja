import 'package:ark_module_profile_prakerja/src/core/failures.dart';
import 'package:ark_module_profile_prakerja/src/domain/entities/my_aktifitas_entity.dart';
import 'package:ark_module_profile_prakerja/src/domain/entities/my_course_entity.dart';
import 'package:ark_module_profile_prakerja/src/domain/entities/my_nilai_entity.dart';
import 'package:ark_module_profile_prakerja/src/domain/entities/my_sertifikat_entity.dart';
import 'package:ark_module_profile_prakerja/src/domain/entities/profile_entity.dart';
import 'package:ark_module_profile_prakerja/src/domain/repositories/ark_profile_repository.dart';
import 'package:dartz/dartz.dart';
import '../entities/city_entity.dart';
import '../entities/provinsi_entity.dart';

class ArkProfileUseCase {
  final ArkProfileRepository _repository;
  ArkProfileUseCase(this._repository);

  Future<Either<Failure, ProfileEntity>> getProfile(
          String baseUrl, String token) async =>
      await _repository.getProfile(baseUrl, token);

  Future<Either<Failure, List<MyCourseEntity>>> getMyCourse(
          String baseUrl, String token, int perPage) async =>
      await _repository.getMyCourse(baseUrl, token, perPage);

  Future<Either<Failure, MySertifikatEntity>> getMySertifikat(
          String baseUrl, int userId) async =>
      await _repository.getMySertifikat(baseUrl, userId);

  Future<Either<Failure, List<MyNilaiEntity>>> getMyNilai(
          String baseUrl, String token) async =>
      await _repository.getMyNilai(baseUrl, token);

  Future<Either<Failure, List<MyAktifitasEntity>>> getMyAktifitas(
          String baseUrl, String token) async =>
      await _repository.getMyAktifitas(baseUrl, token);

  Future<Either<Failure, bool>> saveGenerateSertifikat(
          String baseUrl, String token, String courseId) async =>
      await _repository.saveGenerateSertifikat(baseUrl, token, courseId);

  Future<Either<Failure, String>> generateSertifikat(
          String baseUrl, int userId, int courseId) async =>
      await _repository.generateSertifikat(baseUrl, userId, courseId);

  Future<Either<Failure, ProvinsiEntity>> getProvinsi() async =>
      await _repository.getProvinsi();

  Future<Either<Failure, CityEntity>> getCity(int id) async =>
      await _repository.getCity(id);

  Future<Either<Failure, bool>> updateProfilePrakerja(
          String baseUrl, String token, Map<String, dynamic> body) async =>
      await _repository.updateProfilePrakerja(baseUrl, token, body);

  Future<Either<Failure, bool>> updateProfile(
          String token, Map<String, dynamic> body) async =>
      await _repository.updateProfile(token, body);
}
