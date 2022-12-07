// ignore: depend_on_referenced_packages
import 'package:html/parser.dart';
import 'package:intl/intl.dart';

const String tokenPrakerjaMigrate = "Q^kJMDm^f^@8sJaQ6Cgyit5VilnlCp*A%b4UUDU%";

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
