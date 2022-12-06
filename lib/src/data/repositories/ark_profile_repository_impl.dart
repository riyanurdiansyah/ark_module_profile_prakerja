import 'dart:developer';

import 'package:ark_module_profile_prakerja/src/data/datasources/ark_profile_remote_datasource.dart';
import 'package:ark_module_profile_prakerja/src/domain/entities/my_course_entity.dart';
import 'package:ark_module_profile_prakerja/src/domain/entities/my_sertifikat_entity.dart';
import 'package:ark_module_profile_prakerja/src/domain/entities/profile_entity.dart';
import 'package:ark_module_profile_prakerja/src/core/failures.dart';
import 'package:ark_module_profile_prakerja/src/domain/repositories/ark_profile_repository.dart';
import 'package:dartz/dartz.dart';

import '../../core/exception_handling.dart';

class ArkProfileRepositoryImpl implements ArkProfileRepository {
  ArkProfileRemoteDataSource dataSource;
  ArkProfileRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, ProfileEntity>> getProfile(String token) async {
    try {
      final response = await dataSource.getProfile(token);
      return Right(response);
    } catch (e) {
      log("ERROR PROFILE REPO GET PROFILE : ${e.toString()}");
      return Left(ExceptionHandleResponse().execute(e));
    }
  }

  @override
  Future<Either<Failure, List<MyCourseEntity>>> getMyCourse(
      String token, int perPage) async {
    try {
      final response = await dataSource.getMyCourse(token, perPage);
      return Right(response);
    } catch (e) {
      log("ERROR PROFILE REPO GET MY COURSE : ${e.toString()}");
      return Left(ExceptionHandleResponse().execute(e));
    }
  }

  @override
  Future<Either<Failure, MySertifikatEntity>> getMySertifikat(
      int userId) async {
    try {
      final response = await dataSource.getMySertifikat(userId);
      return Right(response);
    } catch (e) {
      log("ERROR PROFILE REPO GET MY SERTIFIKAT : ${e.toString()}");
      return Left(ExceptionHandleResponse().execute(e));
    }
  }
}
