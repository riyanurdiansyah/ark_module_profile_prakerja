import 'package:html/parser.dart';

const String tokenPrakerjaMigrate = "Q^kJMDm^f^@8sJaQ6Cgyit5VilnlCp*A%b4UUDU%";

String parseHtmlString(String htmlString) {
  final document = parse(htmlString);
  final String parsedString = parse(document.body!.text).documentElement!.text;

  return parsedString;
}
