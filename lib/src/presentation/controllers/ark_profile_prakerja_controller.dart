import 'dart:developer';

import 'package:ark_module_profile_prakerja/src/core/exception_handling.dart';
import 'package:ark_module_profile_prakerja/src/core/failures.dart';
import 'package:ark_module_profile_prakerja/src/data/datasources/ark_profile_remote_datasource_impl.dart';
import 'package:ark_module_profile_prakerja/src/data/repositories/ark_profile_repository_impl.dart';
import 'package:ark_module_profile_prakerja/src/domain/entities/my_course_entity.dart';
import 'package:ark_module_profile_prakerja/src/domain/entities/my_sertifikat_entity.dart';
import 'package:ark_module_profile_prakerja/src/domain/entities/profile_entity.dart';
import 'package:ark_module_profile_prakerja/src/domain/usecases/ark_profile_usecase.dart';
import 'package:ark_module_profile_prakerja/utils/app_constanta.dart';
import 'package:ark_module_profile_prakerja/utils/app_empty_entity.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArkProfilePrakerjaController extends GetxController {
  late SharedPreferences _pref;

  final Rx<bool> _isLogin = false.obs;
  Rx<bool> get isLogin => _isLogin;

  final Rx<bool> _isLoadingGenerate = false.obs;
  Rx<bool> get isLoadingGenerate => _isLoadingGenerate;

  final Rx<bool> _isLoadingSertifikat = false.obs;
  Rx<bool> get isLoadingSertifikat => _isLoadingSertifikat;

  final Rx<bool> _isHaveErrorSertifikat = false.obs;
  Rx<bool> get isHaveErrorSertifikat => _isHaveErrorSertifikat;

  final Rx<String> _tokenPrakerja = "".obs;
  Rx<String> get tokenPrakerja => _tokenPrakerja;

  final Rx<String> _avatar = "".obs;
  Rx<String> get avatar => _avatar;

  final Rx<String> _email = "".obs;
  Rx<String> get email => _email;

  final Rx<int> _userId = 0.obs;
  Rx<int> get userId => _userId;

  late ArkProfileRemoteDataSourceImpl _dataSource;
  late ArkProfileRepositoryImpl _repository;
  late ArkProfileUseCase _usecase;

  final Rx<ProfileEntity> _profile = emptyProfile.obs;
  Rx<ProfileEntity> get profile => _profile;

  final Rx<MySertifikatEntity> _mySertifikat = emptyMySertifikat.obs;
  Rx<MySertifikatEntity> get mySertifikat => _mySertifikat;

  final RxList<MyCourseEntity> _myCourses = <MyCourseEntity>[].obs;
  RxList<MyCourseEntity> get myCourses => _myCourses;

  @override
  void onInit() async {
    await _setup();
    await fetchProfile();
    await fetchMyCourse();
    await fetchMySertifikat();
    super.onInit();
  }

  Future _setup() async {
    _dataSource = ArkProfileRemoteDataSourceImpl();
    _repository = ArkProfileRepositoryImpl(_dataSource);
    _usecase = ArkProfileUseCase(_repository);

    _pref = await SharedPreferences.getInstance();
    _isLogin.value = _pref.getBool("user_login") ?? false;
    _tokenPrakerja.value = _pref.getString("token_access_prakerja") ?? "";
    _avatar.value = _pref.getString('user_avatar') ?? '';
    _email.value = _pref.getString('user_email') ?? '';
    _userId.value = _pref.getString('user_id_prakerja') != null
        ? int.parse(_pref.getString('user_id_prakerja')!)
        : 0;
  }

  Future _changeLoadingSertifikat(bool val) async {
    _isLoadingSertifikat.value = val;
  }

  Future _changeHaveErrorSertifikat(bool val) async {
    _isHaveErrorSertifikat.value = val;
  }

  Future fetchProfile() async {
    final response = await _usecase.getProfile(tokenPrakerjaMigrate);
    response.fold((Failure fail) => ExceptionHandle.execute(fail), (data) {
      _profile.value = data;
    });
  }

  Future fetchMyCourse() async {
    final response = await _usecase.getMyCourse(tokenPrakerjaMigrate, 100);
    response.fold((Failure fail) async {
      ExceptionHandle.execute(fail);
    }, (data) async {
      _myCourses.value = data;
    });
  }

  Future fetchMySertifikat() async {
    _changeLoadingSertifikat(true);
    final response = await _usecase.getMySertifikat(_userId.value);
    response.fold((Failure fail) async {
      ExceptionHandle.execute(fail);
      log("KESINI");
      await _changeHaveErrorSertifikat(true);
      await _changeLoadingSertifikat(false);
    }, (data) async {
      _mySertifikat.value = data;
      await _changeHaveErrorSertifikat(false);
      await _changeLoadingSertifikat(false);
    });
  }
}
