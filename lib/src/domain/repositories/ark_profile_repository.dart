import 'package:ark_module_profile_prakerja/src/core/failures.dart';
import 'package:ark_module_profile_prakerja/src/domain/entities/my_aktifitas_entity.dart';
import 'package:ark_module_profile_prakerja/src/domain/entities/my_course_entity.dart';
import 'package:ark_module_profile_prakerja/src/domain/entities/my_nilai_entity.dart';
import 'package:ark_module_profile_prakerja/src/domain/entities/my_sertifikat_entity.dart';
import 'package:ark_module_profile_prakerja/src/domain/entities/profile_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ArkProfileRepository {
  Future<Either<Failure, ProfileEntity>> getProfile(String token);

  Future<Either<Failure, List<MyCourseEntity>>> getMyCourse(
      String token, int perPage);

  Future<Either<Failure, MySertifikatEntity>> getMySertifikat(int userId);

  Future<Either<Failure, List<MyNilaiEntity>>> getMyNilai(String token);

  Future<Either<Failure, List<MyAktifitasEntity>>> getMyAktifitas(String token);

  Future<Either<Failure, bool>> saveGenerateSertifikat(
      String token, String courseId);

  Future<Either<Failure, String>> generateSertifikat(int userId, int courseId);
}
