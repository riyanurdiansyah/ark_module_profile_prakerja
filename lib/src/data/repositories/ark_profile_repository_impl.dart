import 'dart:developer';

import 'package:ark_module_profile_prakerja/src/data/datasources/ark_profile_remote_datasource.dart';
import 'package:ark_module_profile_prakerja/src/domain/entities/my_aktifitas_entity.dart';
import 'package:ark_module_profile_prakerja/src/domain/entities/my_course_entity.dart';
import 'package:ark_module_profile_prakerja/src/domain/entities/my_nilai_entity.dart';
import 'package:ark_module_profile_prakerja/src/domain/entities/my_sertifikat_entity.dart';
import 'package:ark_module_profile_prakerja/src/domain/entities/profile_entity.dart';
import 'package:ark_module_profile_prakerja/src/core/failures.dart';
import 'package:ark_module_profile_prakerja/src/domain/repositories/ark_profile_repository.dart';
import 'package:dartz/dartz.dart';

import '../../core/exception_handling.dart';
import '../../domain/entities/city_entity.dart';
import '../../domain/entities/provinsi_entity.dart';

class ArkProfileRepositoryImpl implements ArkProfileRepository {
  ArkProfileRemoteDataSource dataSource;
  ArkProfileRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, ProfileEntity>> getProfile(
      String baseUrl, String token) async {
    try {
      final response = await dataSource.getProfile(baseUrl, token);
      return Right(response);
    } catch (e) {
      log("ERROR PROFILE REPO GET PROFILE : ${e.toString()}");
      return Left(ExceptionHandleResponse().execute(e));
    }
  }

  @override
  Future<Either<Failure, List<MyCourseEntity>>> getMyCourse(
      String baseUrl, String token, int perPage) async {
    try {
      final response = await dataSource.getMyCourse(baseUrl, token, perPage);
      return Right(response);
    } catch (e) {
      log("ERROR PROFILE REPO GET MY COURSE : ${e.toString()}");
      return Left(ExceptionHandleResponse().execute(e));
    }
  }

  @override
  Future<Either<Failure, MySertifikatEntity>> getMySertifikat(
      String baseUrl, int userId) async {
    try {
      final response = await dataSource.getMySertifikat(baseUrl, userId);
      return Right(response);
    } catch (e) {
      log("ERROR PROFILE REPO GET MY SERTIFIKAT : ${e.toString()}");
      return Left(ExceptionHandleResponse().execute(e));
    }
  }

  @override
  Future<Either<Failure, List<MyNilaiEntity>>> getMyNilai(
      String baseUrl, String token) async {
    try {
      final response = await dataSource.getMyNilai(baseUrl, token);
      return Right(response);
    } catch (e) {
      log("ERROR PROFILE REPO GET MY NILAI : ${e.toString()}");
      return Left(ExceptionHandleResponse().execute(e));
    }
  }

  @override
  Future<Either<Failure, List<MyAktifitasEntity>>> getMyAktifitas(
      String baseUrl, String token) async {
    try {
      final response = await dataSource.getMyAktifitas(baseUrl, token);
      return Right(response);
    } catch (e) {
      log("ERROR PROFILE REPO GET MY AKTIFITAS : ${e.toString()}");
      return Left(ExceptionHandleResponse().execute(e));
    }
  }

  @override
  Future<Either<Failure, bool>> saveGenerateSertifikat(
      String baseUrl, String token, String courseId) async {
    try {
      final response =
          await dataSource.saveGenerateSertifikat(baseUrl, token, courseId);
      return Right(response);
    } catch (e) {
      log("ERROR PROFILE REPO SAVE GEN SERTIFIKAT : ${e.toString()}");
      return Left(ExceptionHandleResponse().execute(e));
    }
  }

  @override
  Future<Either<Failure, String>> generateSertifikat(
      String baseUrl, int userId, int courseId) async {
    try {
      final response =
          await dataSource.generateSertifikat(baseUrl, userId, courseId);
      return Right(response);
    } catch (e) {
      log("ERROR PROFILE REPO GENERATE SERTIFIKAT : ${e.toString()}");
      return Left(ExceptionHandleResponse().execute(e));
    }
  }

  @override
  Future<Either<Failure, ProvinsiEntity>> getProvinsi() async {
    try {
      final provinsi = await dataSource.getProvinsi();
      return Right(provinsi);
    } catch (e) {
      return Left(ExceptionHandleResponse().execute(e));
    }
  }

  @override
  Future<Either<Failure, CityEntity>> getCity(int id) async {
    try {
      final city = await dataSource.getCity(id);
      return Right(city);
    } catch (e) {
      return Left(ExceptionHandleResponse().execute(e));
    }
  }
}
