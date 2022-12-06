import 'package:ark_module_profile_prakerja/src/data/dto/my_course_dto.dart';
import 'package:ark_module_profile_prakerja/src/data/dto/my_sertifikat_dto.dart';
import 'package:ark_module_profile_prakerja/src/data/dto/profile_dto.dart';

abstract class ArkProfileRemoteDataSource {
  Future<ProfileDTO> getProfile(String token);

  Future<List<MyCourseDTO>> getMyCourse(String token, int perPage);

  Future<MySertifikatDTO> getMySertifikat(int userId);
}