import 'package:ark_module_profile_prakerja/ark_module_profile_prakerja.dart';
import 'package:ark_module_profile_prakerja/utils/app_empty_entity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/app_constanta.dart';
import '../../../utils/app_dialog.dart';
import '../../core/exception_handling.dart';
import '../../core/failures.dart';
import '../../data/datasources/ark_profile_remote_datasource_impl.dart';
import '../../data/dto/provinsi_dto.dart';
import '../../data/repositories/ark_profile_repository_impl.dart';
import '../../domain/entities/city_entity.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/entities/provinsi_entity.dart';
import '../../domain/usecases/ark_profile_usecase.dart';

enum JenisKelamin { pria, wanita, defaultGender }

class ArkEditProfilePrakerjaController extends GetxController {
  late ArkProfileRemoteDataSourceImpl _dataSource;
  late ArkProfileRepositoryImpl _repository;
  late ArkProfileUseCase _usecase;

  late SharedPreferences _pref;

  final Rx<bool> _isLoading = true.obs;
  Rx<bool> get isLoading => _isLoading;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final Rx<String> _name = ''.obs;
  Rx<String> get name => _name;

  final Rx<String> _email = ''.obs;
  Rx<String> get email => _email;

  final Rx<String> _noHp = ''.obs;
  Rx<String> get noHp => _noHp;

  final Rx<String> _tanggalLahir = ''.obs;
  Rx<String> get tanggalLahir => _tanggalLahir;

  final Rx<String> _provinsiName = ''.obs;
  Rx<String> get provinsiName => _provinsiName;

  final Rx<String> _pendidikan = ''.obs;
  Rx<String> get pendidikan => _pendidikan;

  final Rx<String> _gender = ''.obs;
  Rx<String> get gender => _gender;

  final Rx<String> _profesi = ''.obs;
  Rx<String> get profesi => _profesi;

  final Rx<String> _token = "".obs;
  Rx<String> get token => _token;

  final Rx<String> _tokenPrakerja = "".obs;
  Rx<String> get tokenPrakerja => _tokenPrakerja;

  final Rx<String> _avatar = "".obs;
  Rx<String> get avatar => _avatar;

  final Rx<String> _txtTanggalLahir = ''.obs;
  Rx<String> get txtTanggalLahir => _txtTanggalLahir;

  final Rx<int> _userId = 0.obs;
  Rx<int> get userId => _userId;

  final Rx<JenisKelamin> _selectedGender = JenisKelamin.defaultGender.obs;
  Rx<JenisKelamin> get selectedGender => _selectedGender;

  final TextEditingController _tcName = TextEditingController();
  TextEditingController get tcName => _tcName;

  final TextEditingController _tcHp = TextEditingController();
  TextEditingController get tcHp => _tcHp;

  final TextEditingController _tcProfesiLainnya = TextEditingController();
  TextEditingController get tcProfesiLainnya => _tcProfesiLainnya;

  final Rx<ProfileEntity> _profile = emptyProfile.obs;
  Rx<ProfileEntity> get profile => _profile;

  final Rx<String> _userProvinsi = ''.obs;
  Rx<String> get userProvinsi => _userProvinsi;

  final RxList<ProvinsiDataEntity> _provinsi = <ProvinsiDataEntity>[].obs;
  RxList<ProvinsiDataEntity> get provinsi => _provinsi;

  final Rx<String> _txtProfesi = ''.obs;
  Rx<String> get txtProfesi => _txtProfesi;

  final Rx<String> _txtCity = ''.obs;
  Rx<String> get txtCity => _txtCity;

  final Rx<String> _txtPendidikan = ''.obs;
  Rx<String> get txtPendidikan => _txtPendidikan;

  final Rx<ProvinsiDataEntity> _newProvinsi =
      const ProvinsiDataEntity(id: -1, nama: '').obs;
  Rx<ProvinsiDataEntity> get newProvinsi => _newProvinsi;

  final Rx<CityEntity> _city = const CityEntity(kotaKabupaten: []).obs;
  Rx<CityEntity> get city => _city;

  final Rx<String> _baseUrlApiMember = "".obs;

  final _pC = Get.find<ArkProfilePrakerjaController>();

  @override
  void onInit() async {
    await _setup();
    await fetchProfile();
    await _storeDataToVariable();

    await getProvinsi();
    if (_userProvinsi.value.isNotEmpty) {
      final indexProv =
          _provinsi.indexWhere((e) => e.nama == _userProvinsi.value);
      if (indexProv >= 0) {
        final id = _provinsi[_provinsi.indexWhere((e) => e.nama
                .toLowerCase()
                .contains(_userProvinsi.value.toLowerCase()))]
            .id;
        await getCity(id);
        _newProvinsi.value = _provinsi[
            _provinsi.indexWhere((e) => e.nama == _userProvinsi.value)];
      } else {
        _txtCity.value = '';
        _newProvinsi.value = _provinsi[0];
      }
    } else {
      _newProvinsi.value = _provinsi[0];
    }
    await _changeLoading(false);
    super.onInit();
  }

  bool get isCompletedForm =>
      _tcName.text.isNotEmpty &&
      _tcHp.text.isNotEmpty &&
      _txtTanggalLahir.value.isNotEmpty &&
      _selectedGender.value != JenisKelamin.defaultGender &&
      _txtPendidikan.value.isNotEmpty &&
      _txtProfesi.value.isNotEmpty;

  Future _changeLoading(bool val) async {
    _isLoading.value = val;
  }

  void fnCheckStateUpdateProfile() async {
    if (_formKey.currentState!.validate()) {
      if (_txtProfesi.value == 'Lainnya' &&
          _tcProfesiLainnya.value.text.isEmpty) {
        AppDialog.dialogStateWithLottie(
          'fail-animation.json',
          'Profesi lainnya tidak boleh kosong',
        );
      } else {
        AppDialog.dialogLoading();
        final body = {
          "nama_lengkap": _tcName.text,
          "biodata": "",
          "profesi": _txtProfesi.value == 'Lainnya'
              ? _tcProfesiLainnya.text
              : _txtProfesi.value,
          "no_hp": _tcHp.text,
          "jenis_kelamin": _selectedGender.value == JenisKelamin.pria
              ? 'L'
              : _selectedGender.value == JenisKelamin.wanita
                  ? 'P'
                  : '',
          "tgl_lahir": _txtTanggalLahir.value,
          "kota": _txtCity.value,
          "provinsi": _newProvinsi.value.nama == 'Silahkan Pilih Provinsi'
              ? ''
              : _newProvinsi.value.nama,
          "pendidikan_terakhir": _txtPendidikan.value,
        };
        updateProfile(body);
        await updateProfilePrakerja(body);
      }
    }
  }

  Future updateProfilePrakerja(Map<String, dynamic> body) async {
    final response = await _usecase.updateProfilePrakerja(
        _baseUrlApiMember.value, _tokenPrakerja.value, body);
    response.fold(
      ///IF RESPONSE IS ERROR
      (fail) {
        ExceptionHandle.execute(fail);
        Get.back();
      },

      ///IF RESPONSE SUCCESS
      (data) async {
        await _pC.fetchProfile();
        Get.back();
        Get.back();
        AppDialog.dialogStateWithLottie(
            'success-animation.json', 'Profile berhasil diperbarui');
        Future.delayed(
          const Duration(seconds: 3),
          () {
            Get.back();
          },
        );
      },
    );
  }

  Future updateProfile(Map<String, dynamic> body) async {
    final response = await _usecase.updateProfile(_token.value, body);
    response.fold(
      ///IF RESPONSE IS ERROR
      (fail) {},

      ///IF RESPONSE SUCCESS
      (data) async {},
    );
  }

  Future _setup() async {
    _dataSource = ArkProfileRemoteDataSourceImpl();
    _repository = ArkProfileRepositoryImpl(_dataSource);
    _usecase = ArkProfileUseCase(_repository);

    _pref = await SharedPreferences.getInstance();
    _token.value = _pref.getString("token_access") ?? "";
    _tokenPrakerja.value = _pref.getString("token_access_prakerja") ?? "";
    _avatar.value = _pref.getString('user_avatar') ?? '';
    _email.value = _pref.getString('user_email') ?? '';
    _userId.value = _pref.getString('user_id_prakerja') != null
        ? int.parse(_pref.getString('user_id_prakerja')!)
        : 0;
    _baseUrlApiMember.value = _pref.getString('prakerja_api_member_url')!;
  }

  void fnOnChangedGender(JenisKelamin? val) {
    _selectedGender.value = val!;
  }

  Future fetchProfile() async {
    final response = await _usecase.getProfile(
        _baseUrlApiMember.value, _tokenPrakerja.value);
    response.fold((Failure fail) => ExceptionHandle.execute(fail), (data) {
      _profile.value = data;
    });
  }

  Future _storeDataToVariable() async {
    _userProvinsi.value = _profile.value.data.provinsi;
    _tcHp.text = _profile.value.data.noHp;
    _tcName.text = _profile.value.data.fullname;
    _txtProfesi.value = listProfesi.contains(_profile.value.data.profession)
        ? _profile.value.data.profession
        : listProfesi.last;

    _tcProfesiLainnya.text =
        listProfesi.contains(_profile.value.data.profession)
            ? ''
            : _profile.value.data.profession;
    _txtCity.value = _profile.value.data.kota;
    _txtTanggalLahir.value = _profile.value.data.tglLahir;
    _txtPendidikan.value = _profile.value.data.pendidikanTerakhir;
    if (_profile.value.data.jenisKelamin == 'L') {
      _selectedGender.value = JenisKelamin.pria;
    } else if (_profile.value.data.jenisKelamin == 'P') {
      _selectedGender.value = JenisKelamin.wanita;
    } else {
      _selectedGender.value = JenisKelamin.defaultGender;
    }
  }

  Future getProvinsi() async {
    final response = await _usecase.getProvinsi();
    response.fold(
      ///IF RESPONSE IS ERROR
      (fail) => ExceptionHandle.execute(fail),

      ///IF RESPONSE SUCCESS
      (data) {
        _provinsi.value = data.provinsi;
        _provinsi.insert(
            0, const ProvinsiDataDTO(id: -1, nama: 'Silahkan Pilih Provinsi'));
      },
    );
  }

  Future getCity(int id) async {
    final response = await _usecase.getCity(id);
    response.fold(
      ///IF RESPONSE IS ERROR
      (fail) => ExceptionHandle.execute(fail),

      ///IF RESPONSE SUCCESS
      (data) {
        _city.value = data;
      },
    );
  }

  void onChangedProvinsi(ProvinsiDataEntity? value) {
    _newProvinsi.value = value!;
    _txtCity.value = '';
    if (value.nama != 'Silahkan Pilih Provinsi') {
      getCity(_newProvinsi.value.id);
    }
  }
}
