class ProfileEntity {
  ProfileEntity({
    required this.status,
    required this.tab,
    required this.data,
  });

  final bool status;
  final String tab;
  final ProfileDataEntity data;

  ProfileEntity copyWith({
    bool? status,
    String? tab,
    ProfileDataEntity? data,
  }) =>
      ProfileEntity(
        status: status ?? this.status,
        tab: tab ?? this.tab,
        data: data ?? this.data,
      );
}

class ProfileDataEntity {
  ProfileDataEntity({
    required this.fullname,
    required this.location,
    required this.bio,
    required this.facebook,
    required this.twitter,
    required this.specialist,
    required this.bankAccountNo,
    required this.bankName,
    required this.payoutTime,
    required this.minPayoutUser,
    required this.profession,
    required this.tglLahir,
    required this.provinsi,
    required this.kota,
    required this.jenisKelamin,
    required this.noHp,
    required this.pendidikanTerakhir,
  });

  final String fullname;
  final String location;
  final String bio;
  final String facebook;
  final String twitter;
  final String specialist;
  final String bankAccountNo;
  final String bankName;
  final String payoutTime;
  final String minPayoutUser;
  final String profession;
  final String tglLahir;
  final String provinsi;
  final String kota;
  final String jenisKelamin;
  final String noHp;
  final String pendidikanTerakhir;

  ProfileDataEntity copyWith({
    String? fullname,
    String? location,
    String? bio,
    String? facebook,
    String? twitter,
    String? specialist,
    String? bankAccountNo,
    String? bankName,
    String? payoutTime,
    String? minPayoutUser,
    String? profession,
    String? tglLahir,
    String? provinsi,
    String? kota,
    String? jenisKelamin,
    String? noHp,
    String? pendidikanTerakhir,
  }) =>
      ProfileDataEntity(
        fullname: fullname ?? this.fullname,
        location: location ?? this.location,
        bio: bio ?? this.bio,
        facebook: facebook ?? this.facebook,
        twitter: twitter ?? this.twitter,
        specialist: specialist ?? this.specialist,
        bankAccountNo: bankAccountNo ?? this.bankAccountNo,
        bankName: bankName ?? this.bankName,
        payoutTime: payoutTime ?? this.payoutTime,
        minPayoutUser: minPayoutUser ?? this.minPayoutUser,
        profession: profession ?? this.profession,
        tglLahir: tglLahir ?? this.tglLahir,
        provinsi: provinsi ?? this.provinsi,
        kota: kota ?? this.kota,
        jenisKelamin: jenisKelamin ?? this.jenisKelamin,
        noHp: noHp ?? this.noHp,
        pendidikanTerakhir: pendidikanTerakhir ?? this.pendidikanTerakhir,
      );
}
