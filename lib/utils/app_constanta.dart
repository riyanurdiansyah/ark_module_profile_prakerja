// ignore: depend_on_referenced_packages
import 'package:html/parser.dart';
import 'package:intl/intl.dart';

// const String tokenPrakerjaMigrate = "Q^kJMDm^f^@8sJaQ6Cgyit5VilnlCp*A%b4UUDU%";

const double width320Pixel = 321;
const double width360Pixel = 361;

String parseHtmlString(String htmlString) {
  final document = parse(htmlString);
  final String parsedString = parse(document.body!.text).documentElement!.text;

  return parsedString;
}

String readTimestamp(int timestamp) {
  var date = DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000000);
  // if (timestamp != null) {
  var time = DateFormat.yMMMd().format(date);
  // }
  return time;
}

List<String> prakerjaInfo = [
  'Siswa yang menyelesaikan seluruh materi pelatihan dan melampaui nilai minimal kelulusan kuis, akan mendapatkan sertifikat penyelesaian berupa sertifikat elektronik.',
  'Siswa yang menyelesaikan seluruh materi pelatihan, melampaui nilai minimal kelulusan kuis serta melampaui nilai minimal kelulusan post test pada percobaan pertama, akan mendapatkan sertifikat kompetensi lulusan berupa sertifikat elektronik.',
  'Sehingga jika siswa menyelesaikan seluruh materi serta lulus pada kuis dan post-test, akan mendapatkan dua sertifikat, yaitu sertifikat penyelesaian dan sertifikat kompetensi lulusan.',
  'Silahkan masuk ke menu "Sertifikat" untuk mengakses sertifikat Anda.',
  'Sertifikat Prakerja akan dikirimkan kepada PMO melalui marketplace 1x24 jam hari kerja untuk ditampilkan pada Dashboard Prakerja siswa.',
];

List<String> listProfesi = [
  'Silahkan Pilih Profesi',
  'Karyawan Swasta',
  'PNS & BUMN',
  'Profesional',
  'Wiraswasta',
  'Pelajar/Mahasiswa',
  'Belum Bekerja',
  'Lainnya',
];

List<String> listPendidikan = [
  "Silahkan Pilih Pendidikan",
  "SD",
  "SMP",
  "SMA",
  "S1",
  "S2",
];
