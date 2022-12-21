import 'dart:convert';
import 'dart:developer';

import 'package:ark_module_profile_prakerja/src/data/datasources/ark_profile_remote_datasource.dart';
import 'package:ark_module_profile_prakerja/src/data/dto/my_aktifitas_dto.dart';
import 'package:ark_module_profile_prakerja/src/data/dto/my_course_dto.dart';
import 'package:ark_module_profile_prakerja/src/data/dto/my_nilai_dto.dart';
import 'package:ark_module_profile_prakerja/src/data/dto/my_sertifikat_dto.dart';
import 'package:ark_module_profile_prakerja/src/data/dto/profile_dto.dart';
import 'package:ark_module_profile_prakerja/utils/app_url.dart';
import 'package:dio/dio.dart';
import '../../core/dio_options.dart';
import '../../core/exception_handling.dart';
import '../../core/interceptor.dart';
import '../dto/city_dto.dart';
import '../dto/provinsi_dto.dart';

class ArkProfileRemoteDataSourceImpl implements ArkProfileRemoteDataSource {
  late Dio dio;
  ArkProfileRemoteDataSourceImpl({Dio? dio}) {
    this.dio = dio ?? Dio();
  }

  @override
  Future<ProfileDTO> getProfile(String baseUrl, String token) async {
    await dioInterceptor(dio, token);

    final response = await dio.get(
      "$baseUrl/api/v1/prakerja/profile",
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
  Future<List<MyCourseDTO>> getMyCourse(
      String baseUrl, String token, int perPage) async {
    await dioInterceptor(dio, token);

    final response = await dio.get(
      "$baseUrl/api/v1/prakerja/profile",
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
  Future<MySertifikatDTO> getMySertifikat(String baseUrl, int userId) async {
    final response = await dio.get(
      "$baseUrl/api/arkademi/get_user_certificate/$userId",
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
  Future<List<MyNilaiDTO>> getMyNilai(String baseUrl, String token) async {
    await dioInterceptor(dio, token);

    final response = await dio.get(
      "$baseUrl/api/v1/prakerja/profile",
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
  Future<List<MyAktifitasDTO>> getMyAktifitas(
      String baseUrl, String token) async {
    await dioInterceptor(dio, token);

    final response = await dio.get(
      "$baseUrl/api/v1/prakerja/profile",
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
  Future<bool> saveGenerateSertifikat(
      String baseUrl, String token, String courseId) async {
    await dioInterceptor(dio, token);
    final response = await dio.get(
      "$baseUrl/wp-json/api/arkademi/save_cert_gen_counter/$courseId",
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
  Future<String> generateSertifikat(
      String baseUrl, int userId, int courseId) async {
    final response = await dio.get(
      "$baseUrl/api/arkademi/generate_certificate/$userId/$courseId",
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

  @override
  Future<ProvinsiDTO> getProvinsi() async {
    final response = await dio.get(provinsiUrl);
    log("RESPONSE GET PROVINSI : ${response.data}");
    int code = response.statusCode ?? 500;
    if (code == 200) {
      return ProvinsiDTO.fromJson(response.data);
    }
    return ExceptionHandleResponseAPI.execute(
      code,
      response,
      'Error Get Provinsi... failed connect to server',
    );
  }

  @override
  Future<CityDTO> getCity(int id) async {
    final response = await dio.get(
      cityUrl,
      queryParameters: {
        "id_provinsi": id,
      },
    );
    log("RESPONSE GET CITY : ${response.data}");
    int code = response.statusCode ?? 500;
    if (code == 200) {
      return CityDTO.fromJson(response.data);
    }
    return ExceptionHandleResponseAPI.execute(
      code,
      response,
      'Error Get Provinsi... failed connect to server',
    );
  }

  @override
  Future<bool> updateProfilePrakerja(
      String baseUrl, String token, Map<String, dynamic> body) async {
    await dioInterceptor(dio, token);
    final response = await dio.put(
      "$baseUrl/api/v1/prakerja/auth/update/profile",
      data: body,
    );
    log("RESPONSE UPDATE PROFILE PRAKERJA : ${response.data}");
    int code = response.statusCode ?? 500;
    if (code == 200) {
      return true;
    }
    return ExceptionHandleResponseAPI.execute(
      code,
      response,
      'Error Update Profile Prakerja... failed connect to server',
    );
  }

  @override
  Future<bool> updateProfile(String token, Map<String, dynamic> body) async {
    await dioInterceptor(dio, token);
    final response = await dio.put(updateProfileRegularUrl, data: body);
    int code = response.statusCode ?? 500;
    if (code == 200) {
      return true;
    }
    return ExceptionHandleResponseAPI.execute(
      code,
      response,
      'Error Update Profile... failed connect to server',
    );
  }
}
