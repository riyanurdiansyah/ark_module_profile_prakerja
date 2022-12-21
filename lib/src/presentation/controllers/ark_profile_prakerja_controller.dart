import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:ark_module_profile_prakerja/src/core/exception_handling.dart';
import 'package:ark_module_profile_prakerja/src/core/failures.dart';
import 'package:ark_module_profile_prakerja/src/data/datasources/ark_profile_remote_datasource_impl.dart';
import 'package:ark_module_profile_prakerja/src/data/repositories/ark_profile_repository_impl.dart';
import 'package:ark_module_profile_prakerja/src/domain/entities/my_aktifitas_entity.dart';
import 'package:ark_module_profile_prakerja/src/domain/entities/my_course_entity.dart';
import 'package:ark_module_profile_prakerja/src/domain/entities/my_nilai_entity.dart';
import 'package:ark_module_profile_prakerja/src/domain/entities/my_sertifikat_entity.dart';
import 'package:ark_module_profile_prakerja/src/domain/entities/profile_entity.dart';
import 'package:ark_module_profile_prakerja/src/domain/usecases/ark_profile_usecase.dart';
import 'package:ark_module_profile_prakerja/utils/app_dialog.dart';
import 'package:ark_module_profile_prakerja/utils/app_empty_entity.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArkProfilePrakerjaController extends GetxController {
  late SharedPreferences _pref;

  final Rx<bool> _isLogin = false.obs;
  Rx<bool> get isLogin => _isLogin;

  final Rx<bool> _isLoadingGenerate = false.obs;
  Rx<bool> get isLoadingGenerate => _isLoadingGenerate;

  final Rx<bool> _isLoadingSertifikat = false.obs;
  Rx<bool> get isLoadingSertifikat => _isLoadingSertifikat;

  final Rx<bool> _isLoadingNilai = false.obs;
  Rx<bool> get isLoadingNilai => _isLoadingNilai;

  final Rx<bool> _isLoadingAktifitas = false.obs;
  Rx<bool> get isLoadingAktifitas => _isLoadingAktifitas;

  final Rx<bool> _isHaveErrorNilai = false.obs;
  Rx<bool> get isHaveErrorNilai => _isHaveErrorNilai;

  final Rx<bool> _isHaveErrorSertifikat = false.obs;
  Rx<bool> get isHaveErrorSertifikat => _isHaveErrorSertifikat;

  final Rx<bool> _isHaveErrorAktifitas = false.obs;
  Rx<bool> get isHaveErrorAktifitas => _isHaveErrorAktifitas;

  final Rx<String> _tokenPrakerja = "".obs;
  Rx<String> get tokenPrakerja => _tokenPrakerja;

  final Rx<String> _avatar = "".obs;
  Rx<String> get avatar => _avatar;

  final Rx<String> _email = "".obs;
  Rx<String> get email => _email;

  final Rx<int> _userId = 0.obs;
  Rx<int> get userId => _userId;

  final Rx<String> _version = "".obs;
  Rx<String> get version => _version;

  late ArkProfileRemoteDataSourceImpl _dataSource;
  late ArkProfileRepositoryImpl _repository;
  late ArkProfileUseCase _usecase;

  final Rx<ProfileEntity> _profile = emptyProfile.obs;
  Rx<ProfileEntity> get profile => _profile;

  final Rx<MySertifikatEntity> _mySertifikat = emptyMySertifikat.obs;
  Rx<MySertifikatEntity> get mySertifikat => _mySertifikat;

  final RxList<MyCourseEntity> _myCourses = <MyCourseEntity>[].obs;
  RxList<MyCourseEntity> get myCourses => _myCourses;

  final RxList<MyNilaiEntity> _myNilais = <MyNilaiEntity>[].obs;
  RxList<MyNilaiEntity> get myNilais => _myNilais;

  final RxList<MyAktifitasEntity> _myAktifitas = <MyAktifitasEntity>[].obs;
  RxList<MyAktifitasEntity> get myAktifitas => _myAktifitas;

  final RxList<bool> _listStatusGenerate = <bool>[].obs;
  RxList<bool> get listStatusGenerate => _listStatusGenerate;

  final ReceivePort _port = ReceivePort();

  final _googleSignIn = GoogleSignIn();
  final _googleSignInIos = GoogleSignIn(
    hostedDomain: "https://apps.arkademi.com",
    clientId:
        '265001851813-uvseu68037o8lpo126p679sbm3sesns6.apps.googleusercontent.com',
  );

  final Rx<String> _baseUrlWp = "".obs;
  final Rx<String> _baseUrlApiCourse = "".obs;
  final Rx<String> _baseUrlApiMember = "".obs;

  @override
  void onInit() async {
    _getVersion();
    _downloadListener();
    await _setup();
    await fetchProfile();
    await fetchMyCourse();
    await fetchMySertifikat();
    await fetchMyNilai();
    await fetchMyAktifitas();
    super.onInit();
  }

  @override
  void onClose() {
    _port.close();
    IsolateNameServer.removePortNameMapping('downloader_cert');
    super.onClose();
  }

  Future<void> _getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _version.value = packageInfo.version;
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

    _baseUrlWp.value = _pref.getString("prakerja_api_wp_url")!;
    _baseUrlApiCourse.value = _pref.getString("prakerja_api_course_url")!;
    _baseUrlApiMember.value = _pref.getString("prakerja_api_member_url")!;

    log("CHECK TOKEN : ${_tokenPrakerja.value}");
  }

  Future _changeLoadingSertifikat(bool val) async {
    _isLoadingSertifikat.value = val;
  }

  Future _changeLoadingNilai(bool val) async {
    _isLoadingNilai.value = val;
  }

  Future _changeLoadingAktifitas(bool val) async {
    _isLoadingAktifitas.value = val;
  }

  Future _changeHaveErrorSertifikat(bool val) async {
    _isHaveErrorSertifikat.value = val;
  }

  Future _changeHaveErrorAktifitas(bool val) async {
    _isHaveErrorAktifitas.value = val;
  }

  Future _changeHaveErrorNilai(bool val) async {
    _isHaveErrorNilai.value = val;
  }

  Future fetchProfile() async {
    final response = await _usecase.getProfile(
        _baseUrlApiMember.value, _tokenPrakerja.value);
    response.fold((Failure fail) => ExceptionHandle.execute(fail), (data) {
      _profile.value = data;
    });
  }

  Future saveGenerateSertifikat(int index) async {
    _listStatusGenerate[index] = true;
    final response = await _usecase.saveGenerateSertifikat(
        _baseUrlApiMember.value,
        _tokenPrakerja.value,
        _mySertifikat.value.certificates[index].id.toString());
    response.fold((Failure fail) => ExceptionHandle.execute(fail),
        (data) async {
      if (data == true) {
        await generateSertifikat(_mySertifikat.value.certificates[index].id);
      }
    });
  }

  Future generateSertifikat(int courseId) async {
    final response = await _usecase.generateSertifikat(
        _baseUrlApiMember.value, _userId.value, courseId);
    response.fold((Failure fail) async {
      ExceptionHandle.execute(fail);
    }, (data) async {
      // _myCourses.value = data;
    });
  }

  Future fetchMyCourse() async {
    final response = await _usecase.getMyCourse(
        _baseUrlApiMember.value, _tokenPrakerja.value, 100);
    response.fold((Failure fail) async {
      ExceptionHandle.execute(fail);
    }, (data) async {
      _myCourses.value = data;
    });
  }

  Future fetchMyNilai() async {
    _changeLoadingNilai(true);
    final response = await _usecase.getMyNilai(
        _baseUrlApiMember.value, _tokenPrakerja.value);
    response.fold((Failure fail) async {
      ExceptionHandle.execute(fail);
      await _changeHaveErrorNilai(true);
      await _changeLoadingNilai(false);
    }, (data) async {
      _myNilais.value = data;
      await _changeHaveErrorNilai(false);
      await _changeLoadingNilai(false);
    });
  }

  Future fetchMySertifikat() async {
    _changeLoadingSertifikat(true);
    log("ID : ${_userId.value}");
    final response =
        await _usecase.getMySertifikat(_baseUrlApiMember.value, _userId.value);
    response.fold((Failure fail) async {
      ExceptionHandle.execute(fail);
      await _changeHaveErrorSertifikat(true);
      await _changeLoadingSertifikat(false);
    }, (data) async {
      _mySertifikat.value = data;
      _listStatusGenerate.value = List.filled(data.certificates.length, false);
      await _changeHaveErrorSertifikat(false);
      await _changeLoadingSertifikat(false);
    });
  }

  Future fetchMyAktifitas() async {
    _changeLoadingAktifitas(true);
    final response = await _usecase.getMyAktifitas(
        _baseUrlApiMember.value, _tokenPrakerja.value);
    response.fold((Failure fail) async {
      ExceptionHandle.execute(fail);
      await _changeHaveErrorAktifitas(true);
      await _changeLoadingAktifitas(false);
    }, (data) async {
      _myAktifitas.value = data;
      await _changeHaveErrorAktifitas(false);
      await _changeLoadingAktifitas(false);
    });
  }

  Future<String?> findLocalPath() async {
    String? externalStorageDirPath;
    if (GetPlatform.isAndroid) {
      final directory = await getExternalStorageDirectory();
      externalStorageDirPath = directory?.path;
    } else if (GetPlatform.isIOS) {
      externalStorageDirPath = (await getApplicationDocumentsDirectory()).path;
    }
    return externalStorageDirPath;
  }

  Future _downloadListener() async {
    IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_cert');
    _port.listen((dynamic data) {
      DownloadTaskStatus status = data[1];
      log("PROGRESS DOWNLOAD : ${data[2]}");
      if (status == DownloadTaskStatus.complete && data[2] == 100) {
        AppDialog.dialogDownloadSertif();
      }
    });

    FlutterDownloader.registerCallback(_downloadCallback);
  }

  static void _downloadCallback(
    String id,
    DownloadTaskStatus status,
    int progress,
  ) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_cert');
    send!.send([id, status, progress]);
  }

  Future checkPermission(String url) async {
    final status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    if (await Permission.speech.isPermanentlyDenied) {
      openAppSettings();
    }

    if (status.isGranted) {
      downloadSertifikat(url);
    }
  }

  Future downloadSertifikat(String url) async {
    final storageDir = await findLocalPath();
    final savedDir = Directory(storageDir!);

    final hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }

    await FlutterDownloader.enqueue(
      url: url,
      savedDir: storageDir,
      showNotification: true,
      openFileFromNotification: true,
      saveInPublicStorage: true,
    );
  }

  ///MENAMPILKAN DIALOG LOGOUT
  void confirmLogout() {
    log("LOGOUT FROM ARK");
    AppDialog.dialogWithQuestion(
      'Keluar',
      'Anda yakin ingin keluar?',
      'Batal',
      'Lanjut',
      () => logout(),
    );
  }

  Future<void> logout() async {
    try {
      GetPlatform.isAndroid
          ? await _googleSignIn.signOut()
          : await _googleSignInIos.signOut();
      await FacebookAuth.instance.logOut();
      await _pref.clear();
      Get.back();
      Get.offAllNamed("/main");
    } catch (e) {
      log("ERROR LOGOUT : $e");
    }
  }
}
