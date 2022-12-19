import 'package:ark_module_profile_prakerja/ark_module_profile_prakerja.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_constanta.dart';
import '../../../utils/app_validator.dart';
import '../../domain/entities/provinsi_entity.dart';

class ArkEditProfilePrakerjaPage extends StatelessWidget {
  ArkEditProfilePrakerjaPage({Key? key}) : super(key: key);

  final _epC = Get.find<ArkEditProfilePrakerjaController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: [
            if (!_epC.isLoading.value)
              Padding(
                padding: const EdgeInsets.only(top: 20, right: 22),
                child: GestureDetector(
                  onTap: () {},
                  child: const Text(
                    "Simpan",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ],
          centerTitle: false,
          titleSpacing: 0,
          iconTheme: const IconThemeData(size: 15, color: kNewBlack2a),
          title: const Text(
            "Profil Saya",
            style: TextStyle(
              color: Color.fromRGBO(28, 29, 32, 1),
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        body: Obx(
          () {
            if (_epC.isLoading.value) {
              return Center(
                child: GetPlatform.isAndroid
                    ? const SizedBox(
                        width: 26,
                        height: 26,
                        child: CircularProgressIndicator(),
                      )
                    : const CupertinoActivityIndicator(),
              );
            }

            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50)),
                            child: Image.network(
                              _epC.avatar.value,
                              fit: BoxFit.fill,
                              width: 100,
                              height: 100,
                            ),
                          ),
                          Positioned(
                            bottom: -8,
                            right: -2,
                            child: Image.asset(
                              'assets/images/profile-pict.png',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Form(
                      key: _epC.formKey,
                      child: TextFormField(
                        controller: _epC.tcName,
                        // initialValue: _epC.name.value,
                        style: const TextStyle(
                          fontSize: 11.5,
                          color: Color(0xFF121315),
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF2BA0E7),
                              width: 0.8,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            gapPadding: 2,
                            borderSide: BorderSide(
                              color: Color(0xFFACAEB2),
                              width: 0.5,
                            ),
                          ),
                          border: OutlineInputBorder(
                            gapPadding: 2,
                          ),
                          labelText: ' Nama Lengkap ',
                          labelStyle: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF838589),
                            fontWeight: FontWeight.normal,
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => AppValidator.checkNama(value!),
                        onSaved: (value) {
                          _epC.name.value = value!;
                          _epC.tcName.text = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      enabled: false,
                      initialValue: _epC.email.value,
                      style:
                          const TextStyle(fontSize: 13.5, color: kNewBlack2b),
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: kNewBlack5b,
                        border: OutlineInputBorder(gapPadding: 2),
                        enabledBorder: OutlineInputBorder(
                          gapPadding: 2,
                          borderSide: BorderSide(
                            color: Color(0xFFACAEB2),
                            width: 0.5,
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                          gapPadding: 2,
                          borderSide: BorderSide(
                            color: Color(0xFFACAEB2),
                            width: 0.5,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        labelStyle: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF838589),
                          fontWeight: FontWeight.normal,
                        ),
                        labelText: ' Email ',
                      ),
                      minLines: 1,
                      maxLines: 4,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.length > 150) {
                          return '';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _epC.email.value = value!;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _epC.tcHp,
                      // initialValue: _epC.handPhone.value,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        fontSize: 11.5,
                        color: Color(0xFF121315),
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF2BA0E7),
                            width: 0.8,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          gapPadding: 2,
                          borderSide: BorderSide(
                            color: Color(0xFFACAEB2),
                            width: 0.5,
                          ),
                        ),
                        border: OutlineInputBorder(gapPadding: 2),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        labelStyle: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF838589),
                          fontWeight: FontWeight.normal,
                        ),
                        labelText: ' No. HP ',
                      ),
                      minLines: 1,
                      maxLines: 4,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) =>
                          AppValidator.checkNumberPhone(value!),
                      onSaved: (value) {
                        // _epC.handPhone.value = value!;
                      },
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        DatePicker.showDatePicker(
                          context,
                          theme: const DatePickerTheme(
                              backgroundColor: Colors.white),
                          showTitleActions: true,
                          minTime: DateTime(DateTime.now().year - 80, 1, 1),
                          maxTime: DateTime(DateTime.now().year - 15, 12, 31),
                          onConfirm: (date) {
                            final DateFormat formatter =
                                DateFormat('d MMMM yyyy', "id_ID");
                            final String formatted = formatter.format(date);
                            _epC.tanggalLahir.value = formatted;
                            _epC.txtTanggalLahir.value = formatted;
                          },
                          currentTime:
                              DateTime(DateTime.now().year - 15, 12, 31),
                          locale: LocaleType.id,
                        );
                      },
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: Get.size.width,
                            height: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFFACAEB2),
                                  width: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(4)),
                            child: Row(
                              children: [
                                Obx(
                                  () => Text(
                                    _epC.txtTanggalLahir.value == ''
                                        ? 'Tanggal Lahir'
                                        : _epC.txtTanggalLahir.value,
                                    style: TextStyle(
                                      fontSize: 11.5,
                                      color: _epC.txtTanggalLahir.value == ''
                                          ? const Color(0xFFACAEB2)
                                          : const Color(0xFF121315),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Icon(
                                  Icons.arrow_drop_down_outlined,
                                  color: Colors.grey.shade500,
                                  size: 30,
                                ),
                              ],
                            ),
                          ),
                          Obx(
                            () => _epC.txtTanggalLahir.value == ''
                                ? const SizedBox()
                                : Positioned(
                                    top: -7,
                                    child: Container(
                                      color: Colors.white,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: const Text(
                                        'Tanggal lahir',
                                        style: TextStyle(
                                          fontSize: 9.5,
                                          color: Color(0xFF838589),
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 5, bottom: 8),
                          child: Text(
                            'Jenis Kelamin',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 11.5,
                            ),
                          ),
                        ),
                        Obx(
                          () => Row(
                            children: [
                              const SizedBox(width: 2),
                              Radio<JenisKelamin>(
                                visualDensity: const VisualDensity(
                                  horizontal: VisualDensity.minimumDensity,
                                  vertical: VisualDensity.minimumDensity,
                                ),
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                onChanged: (JenisKelamin? val) =>
                                    _epC.fnOnChangedGender(val),
                                groupValue: _epC.selectedGender.value,
                                value: JenisKelamin.pria,
                              ),
                              const SizedBox(width: 5),
                              const Text(
                                'Laki-laki',
                                style: TextStyle(
                                  fontFamily: 'SourceSansPro',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(width: 30),
                              Radio<JenisKelamin>(
                                  visualDensity: const VisualDensity(
                                    horizontal: VisualDensity.minimumDensity,
                                    vertical: VisualDensity.minimumDensity,
                                  ),
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  onChanged: (JenisKelamin? val) =>
                                      _epC.fnOnChangedGender(val),
                                  groupValue: _epC.selectedGender.value,
                                  value: JenisKelamin.wanita),
                              const SizedBox(width: 5),
                              const Text(
                                'Perempuan',
                                style: TextStyle(
                                  fontFamily: 'SourceSansPro',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    const SizedBox(height: 20),
                    Obx(
                      () => _epC.isLoading.value
                          ? Container(
                              width: Get.size.width,
                              height: 50,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xFFACAEB2),
                                    width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Row(
                                children: [
                                  const Text(
                                    'Provinsi',
                                    style: TextStyle(
                                      fontSize: 11.5,
                                      color: Color(0xFFC0C2C6),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const Spacer(),
                                  Icon(
                                    Icons.arrow_drop_down_outlined,
                                    color: Colors.grey.shade500,
                                    size: 30,
                                  ),
                                ],
                              ),
                            )
                          : Stack(
                              clipBehavior: Clip.none,
                              children: [
                                DropdownButtonHideUnderline(
                                  child: Container(
                                    width: Get.size.width,
                                    height: 50,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color(0xFFACAEB2),
                                          width: 0.5,
                                        ),
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Obx(
                                      () => DropdownButton<ProvinsiDataEntity>(
                                        value: _epC.newProvinsi.value,
                                        icon: Icon(
                                          Icons.arrow_drop_down_outlined,
                                          color: Colors.grey.shade500,
                                          size: 30,
                                        ),
                                        style: const TextStyle(
                                          fontSize: 11.5,
                                          color: Color(0xFF121315),
                                          fontWeight: FontWeight.normal,
                                        ),
                                        items: _epC.provinsi.map((value) {
                                          return DropdownMenuItem<
                                              ProvinsiDataEntity>(
                                            value: value,
                                            child: Text(
                                              value.nama,
                                              style: TextStyle(
                                                fontSize: 11.5,
                                                color: value.id == -1
                                                    ? const Color(0xFFC0C2C6)
                                                    : const Color(0xFF121315),
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (value) =>
                                            _epC.onChangedProvinsi(value),
                                      ),
                                    ),
                                  ),
                                ),
                                _epC.isLoading.value ||
                                        _epC.newProvinsi.value.nama ==
                                            _epC.provinsi[0].nama
                                    ? const SizedBox()
                                    : Positioned(
                                        top: -7,
                                        child: Container(
                                          color: Colors.white,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4),
                                          child: const Text(
                                            'Provinsi',
                                            style: TextStyle(
                                              fontSize: 9.5,
                                              color: Color(0xFF838589),
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                    ),
                    const SizedBox(height: 20),
                    _epC.isLoading.value || _epC.txtCity.isEmpty
                        ? Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                width: Get.size.width,
                                height: 50,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                    color: kNewBlack5b,
                                    border: Border.all(
                                      color: const Color(0xFFACAEB2),
                                      width: 0.5,
                                    ),
                                    borderRadius: BorderRadius.circular(4)),
                                child: Row(
                                  children: [
                                    const Text(
                                      'Kota ',
                                      style: TextStyle(
                                        fontSize: 11.5,
                                        color: Color(0xFFACAEB2),
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    const Spacer(),
                                    Icon(
                                      Icons.arrow_drop_down_outlined,
                                      color: Colors.grey.shade500,
                                      size: 30,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Stack(
                            clipBehavior: Clip.none,
                            children: [
                              DropdownButtonHideUnderline(
                                  child: Container(
                                width: Get.size.width,
                                height: 50,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0xFFACAEB2),
                                      width: 0.5,
                                    ),
                                    borderRadius: BorderRadius.circular(4)),
                                child: Obx(
                                  () => DropdownButton<String>(
                                    value: _epC.txtCity.value == ''
                                        ? _epC.city.value.kotaKabupaten[0].nama
                                        : _epC.txtCity.value,
                                    icon: Icon(
                                      Icons.arrow_drop_down_outlined,
                                      color: Colors.grey.shade500,
                                      size: 30,
                                    ),
                                    style: const TextStyle(
                                      fontSize: 11.5,
                                      color: Color(0xFF121315),
                                      fontWeight: FontWeight.normal,
                                    ),
                                    items: _epC.city.value.kotaKabupaten
                                        .map((value) {
                                      return DropdownMenuItem<String>(
                                        value: value.nama,
                                        child: Text(
                                          value.nama,
                                          style: const TextStyle(
                                            fontSize: 11.5,
                                            color: Color(0xFF121315),
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      // _pC.city.value = value!;
                                      _epC.txtCity.value = value!;
                                    },
                                  ),
                                ),
                              )),
                              Positioned(
                                top: -7,
                                child: Container(
                                  color: Colors.white,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  child: const Text(
                                    'Kota',
                                    style: TextStyle(
                                      fontSize: 9.5,
                                      color: Color(0xFF838589),
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                    const SizedBox(height: 20),
                    Obx(
                      () => Stack(
                        clipBehavior: Clip.none,
                        children: [
                          DropdownButtonHideUnderline(
                              child: Container(
                            width: Get.size.width,
                            height: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFFACAEB2),
                                  width: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(4)),
                            child: Obx(
                              () => DropdownButton<String>(
                                value: _epC.txtPendidikan.isEmpty
                                    ? listPendidikan[0]
                                    : _epC.txtPendidikan.value,
                                icon: Icon(
                                  Icons.arrow_drop_down_outlined,
                                  color: Colors.grey.shade500,
                                  size: 30,
                                ),
                                style: const TextStyle(
                                  fontSize: 11.5,
                                  color: Color(0xFF121315),
                                  fontWeight: FontWeight.w500,
                                ),
                                items: listPendidikan.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                        fontSize: 11.5,
                                        color: value == listPendidikan[0]
                                            ? const Color(0xFFC0C2C6)
                                            : const Color(0xFF121315),
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  _epC.txtPendidikan.value = value ?? '';
                                },
                              ),
                            ),
                          )),
                          _epC.txtPendidikan.value == '' ||
                                  _epC.txtPendidikan.value == listPendidikan[0]
                              ? const SizedBox()
                              : Positioned(
                                  top: -7,
                                  child: Container(
                                    color: Colors.white,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: const Text(
                                      'Pendidikan Terakhir',
                                      style: TextStyle(
                                        color: Color(0xFF838589),
                                        fontSize: 9.5,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // //custom textformfield

                    // HIDE BUAT BESOK
                    Obx(
                      () => Stack(
                        clipBehavior: Clip.none,
                        children: [
                          DropdownButtonHideUnderline(
                            child: Container(
                              width: Get.size.width,
                              height: 50,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xFFACAEB2),
                                    width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(4)),
                              child: DropdownButton<String>(
                                value: _epC.txtProfesi.isEmpty
                                    ? listProfesi[0]
                                    : listProfesi
                                            .contains(_epC.txtProfesi.value)
                                        ? _epC.txtProfesi.value
                                        : listProfesi.last,
                                icon: Icon(
                                  Icons.arrow_drop_down_outlined,
                                  color: Colors.grey.shade500,
                                  size: 30,
                                ),
                                style: const TextStyle(
                                  fontSize: 11.5,
                                  color: Color(0xFF121315),
                                  fontWeight: FontWeight.w500,
                                ),
                                items: listProfesi.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                        fontSize: 11.5,
                                        color: value == listProfesi[0]
                                            ? const Color(0xFFC0C2C6)
                                            : const Color(0xFF121315),
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  // _pC.profesi.value = value!;
                                  _epC.txtProfesi.value = value!;
                                },
                              ),
                            ),
                          ),
                          _epC.txtProfesi.value == '' ||
                                  _epC.txtProfesi.value == listProfesi[0]
                              ? const SizedBox()
                              : Positioned(
                                  top: -7,
                                  child: Container(
                                    color: Colors.white,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: const Text(
                                      'Profesi',
                                      style: TextStyle(
                                        fontSize: 9.5,
                                        color: Color(0xFF838589),
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () => _epC.txtProfesi.value != 'Lainnya'
                          ? const SizedBox()
                          : TextFormField(
                              controller: _epC.tcProfesiLainnya,
                              style: const TextStyle(
                                fontSize: 11.5,
                                color: Color(0xFF121315),
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: const InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF2BA0E7),
                                    width: 0.8,
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFACAEB2),
                                    width: 0.5,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFACAEB2),
                                    width: 0.5,
                                  ),
                                ),
                                border: OutlineInputBorder(gapPadding: 2),
                                labelText: ' Profesi Lainnya ',
                                hintText: 'Tulis profesi lainnya..',
                                labelStyle: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) => _epC.txtProfesi.value ==
                                      'Lainnya'
                                  ? AppValidator.requiredField(value!,
                                      errorMsg:
                                          'Profesi lainnya tidak boleh kosong')
                                  : null,
                            ),
                    ),

                    // const SizedBox(height: 25),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
