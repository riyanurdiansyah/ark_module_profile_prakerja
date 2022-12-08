import 'package:dio/dio.dart';

Options dioOptions({
  Map<String, dynamic>? headers,
}) {
  return Options(
    followRedirects: false,
    validateStatus: (status) => true,
    headers: headers ??
        {
          "Accept": "*/*",
          "Content-Type": "application/json",
        },
  );
}
