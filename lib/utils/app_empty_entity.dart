import 'package:ark_module_profile_prakerja/src/domain/entities/my_sertifikat_entity.dart';
import 'package:ark_module_profile_prakerja/src/domain/entities/profile_entity.dart';

final ProfileEntity emptyProfile = ProfileEntity(
  status: false,
  tab: "profile",
  data: emptyProfileData,
);

final ProfileDataEntity emptyProfileData = ProfileDataEntity(
  fullname: "",
  location: "",
  bio: "",
  facebook: "",
  twitter: "",
  specialist: "",
  bankAccountNo: "",
  bankName: "",
  payoutTime: "",
  minPayoutUser: "",
  profession: "",
  tglLahir: "",
  provinsi: "",
  kota: "",
  jenisKelamin: "",
  noHp: "",
  pendidikanTerakhir: "",
);

final MySertifikatEntity emptyMySertifikat = MySertifikatEntity(
  success: false,
  certificates: [],
);
