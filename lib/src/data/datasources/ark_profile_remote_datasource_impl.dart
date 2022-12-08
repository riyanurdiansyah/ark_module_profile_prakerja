import 'dart:convert';
import 'dart:developer';

import 'package:ark_module_profile_prakerja/src/data/datasources/ark_profile_remote_datasource.dart';
import 'package:ark_module_profile_prakerja/src/data/dto/my_aktifitas_dto.dart';
import 'package:ark_module_profile_prakerja/src/data/dto/my_course_dto.dart';
import 'package:ark_module_profile_prakerja/src/data/dto/my_nilai_dto.dart';
import 'package:ark_module_profile_prakerja/src/data/dto/my_sertifikat_dto.dart';
import 'package:ark_module_profile_prakerja/src/data/dto/profile_dto.dart';
import 'package:ark_module_profile_prakerja/utils/app_constanta.dart';
import 'package:ark_module_profile_prakerja/utils/app_url.dart';
import 'package:dio/dio.dart';
import '../../core/dio_options.dart';
import '../../core/exception_handling.dart';
import '../../core/interceptor.dart';

class ArkProfileRemoteDataSourceImpl implements ArkProfileRemoteDataSource {
  late Dio dio;
  ArkProfileRemoteDataSourceImpl({Dio? dio}) {
    this.dio = dio ?? Dio();
  }

  @override
  Future<ProfileDTO> getProfile(String token) async {
    await dioInterceptor(dio, token);

    final response = await dio.get(
      apiProfileUrl,
      queryParameters: {
        "tab": "profile",
      },
      options: dioOptions(),
    );
    log("RESPONSE PROFILE : ${response.data}");
    int code = response.statusCode ?? 500;
    if (code == 200) {
      return ProfileDTO.fromJson(response.data);
    }
    return ExceptionHandleResponseAPI.execute(
      code,
      response,
      'Error GET PROFILE... failed connect to server',
    );
  }

  @override
  Future<List<MyCourseDTO>> getMyCourse(String token, int perPage) async {
    await dioInterceptor(dio, token);

    final response = await dio.get(
      apiProfileUrl,
      queryParameters: {
        "tab": "courses",
        "per_page": perPage,
      },
      options: dioOptions(),
    );
    log("RESPONSE MY COURSE : ${response.data}");
    final data = json.encode(response.data);
    int code = response.statusCode ?? 500;
    if (code == 200) {
      return myCourseJsonToList(data);
    }
    return ExceptionHandleResponseAPI.execute(
      code,
      response,
      'Error GET MY COURSE... failed connect to server',
    );
  }

  @override
  Future<MySertifikatDTO> getMySertifikat(int userId) async {
    final response = await dio.get(
      "$apiSertifikatUrl/$userId",
      options: dioOptions(),
    );
    log("RESPONSE MY SERTIFIKAT : ${response.data}");
    log("RESPONSE MY SERTIFIKAT : ${"$apiSertifikatUrl/$userId"}");
    int code = response.statusCode ?? 500;
    if (code == 200) {
      return MySertifikatDTO.fromJson(response.data);
    }
    return ExceptionHandleResponseAPI.execute(
      code,
      response,
      'Error GET MY SERTIFIKAT... failed connect to server',
    );
  }

  @override
  Future<List<MyNilaiDTO>> getMyNilai(String token) async {
    await dioInterceptor(dio, token);

    final response = await dio.get(
      apiProfileUrl,
      queryParameters: {
        "tab": "result_quizes",
      },
      options: dioOptions(),
    );
    log("RESPONSE MY NILAI : ${response.data}");
    final data = json.encode(response.data);
    int code = response.statusCode ?? 500;
    if (code == 200) {
      return myNilaiFromJsonToList(data);
    }
    return ExceptionHandleResponseAPI.execute(
      code,
      response,
      'Error GET MY NILAI... failed connect to server',
    );
  }

  @override
  Future<List<MyAktifitasDTO>> getMyAktifitas(String token) async {
    await dioInterceptor(dio, token);

    final response = await dio.get(
      apiProfileUrl,
      queryParameters: {
        "tab": "activity",
      },
      options: dioOptions(),
    );
    log("RESPONSE MY AKTIFITAS : ${response.data}");
    final data = json.encode(response.data);
    int code = response.statusCode ?? 500;
    if (code == 200) {
      return myAktifitasFromJsonToList(data);
    }
    return ExceptionHandleResponseAPI.execute(
      code,
      response,
      'Error GET MY AKTIFITAS... failed connect to server',
    );
  }

  @override
  Future<bool> saveGenerateSertifikat(String token, String courseId) async {
    await dioInterceptor(dio, token);
    final response = await dio.get(
      "$saveGenerateSertifUrl/$courseId",
      options: dioOptions(),
    );
    log("RESPONSE MY SAVE GEN : ${response.data}");
    int code = response.statusCode ?? 500;
    if (code == 200) {
      return response.data['success'] ?? true;
    }
    return ExceptionHandleResponseAPI.execute(
      code,
      response,
      'Error GET MY SAVE GENERATE SERTIF... failed connect to server',
    );
  }

  @override
  Future<String> generateSertifikat(int userId, int courseId) async {
    await dioInterceptor(dio, tokenPrakerjaMigrate);
    final response = await dio.get(
      "https://stag-prakerja-apimember-fgt.arkademi.com/api/arkademi/generate_certificate/39636/15540551",
      options: dioOptions(),
    );
    log("RESPONSE GENERATE SERTIFIKAT : ${response.data}");
    int code = response.statusCode ?? 500;
    if (code == 200) {
      return "";
    }
    return ExceptionHandleResponseAPI.execute(
      code,
      response,
      'Error Generate Sertifikat... failed connect to server',
    );
  }
}
