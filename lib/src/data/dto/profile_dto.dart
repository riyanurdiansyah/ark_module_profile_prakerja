import 'package:ark_module_profile_prakerja/src/domain/entities/profile_entity.dart';

class ProfileDTO extends ProfileEntity {
  ProfileDTO({
    required super.status,
    required super.tab,
    required super.data,
  });

  factory ProfileDTO.fromJson(Map<String, dynamic> json) => ProfileDTO(
        status: json["status"],
        tab: json["tab"],
        data: ProfileDataDTO.fromJson(json["data"]),
      );
}

class ProfileDataDTO extends ProfileDataEntity {
  ProfileDataDTO({
    required super.fullname,
    required super.location,
    required super.bio,
    required super.facebook,
    required super.twitter,
    required super.specialist,
    required super.bankAccountNo,
    required super.bankName,
    required super.payoutTime,
    required super.minPayoutUser,
    required super.profession,
    required super.tglLahir,
    required super.provinsi,
    required super.kota,
    required super.jenisKelamin,
    required super.noHp,
    required super.pendidikanTerakhir,
  });

  factory ProfileDataDTO.fromJson(Map<String, dynamic> json) => ProfileDataDTO(
        fullname: json["fullname"],
        location: json["location"],
        bio: json["bio"],
        facebook: json["facebook"],
        twitter: json["twitter"],
        specialist: json["specialist"],
        bankAccountNo: json["bank_account_no"],
        bankName: json["bank_name"],
        payoutTime: json["payout_time"],
        minPayoutUser: json["min_payout_user"],
        profession: json["profession"],
        tglLahir: json["tgl_lahir"],
        provinsi: json["provinsi"],
        kota: json["kota"],
        jenisKelamin: json["jenis_kelamin"],
        noHp: json["no_hp"],
        pendidikanTerakhir: json["pendidikan_terakhir"],
      );
}
