import 'package:ark_module_profile_prakerja/src/core/failures.dart';
import 'package:ark_module_profile_prakerja/src/domain/entities/my_course_entity.dart';
import 'package:ark_module_profile_prakerja/src/domain/entities/my_nilai_entity.dart';
import 'package:ark_module_profile_prakerja/src/domain/entities/my_sertifikat_entity.dart';
import 'package:ark_module_profile_prakerja/src/domain/entities/profile_entity.dart';
import 'package:ark_module_profile_prakerja/src/domain/repositories/ark_profile_repository.dart';
import 'package:dartz/dartz.dart';

class ArkProfileUseCase {
  final ArkProfileRepository _repository;
  ArkProfileUseCase(this._repository);

  Future<Either<Failure, ProfileEntity>> getProfile(String token) async =>
      await _repository.getProfile(token);

  Future<Either<Failure, List<MyCourseEntity>>> getMyCourse(
          String token, int perPage) async =>
      await _repository.getMyCourse(token, perPage);

  Future<Either<Failure, MySertifikatEntity>> getMySertifikat(
          int userId) async =>
      await _repository.getMySertifikat(userId);

  Future<Either<Failure, List<MyNilaiEntity>>> getMyNilai(String token) async =>
      await _repository.getMyNilai(token);
}
