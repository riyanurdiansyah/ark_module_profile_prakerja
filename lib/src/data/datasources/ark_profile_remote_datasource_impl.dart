import 'dart:convert';
import 'dart:developer';

import 'package:ark_module_profile_prakerja/src/data/datasources/ark_profile_remote_datasource.dart';
import 'package:ark_module_profile_prakerja/src/data/dto/my_course_dto.dart';
import 'package:ark_module_profile_prakerja/src/data/dto/my_nilai_dto.dart';
import 'package:ark_module_profile_prakerja/src/data/dto/my_sertifikat_dto.dart';
import 'package:ark_module_profile_prakerja/src/data/dto/profile_dto.dart';
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
}
