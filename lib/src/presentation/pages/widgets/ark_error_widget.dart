import 'package:flutter/material.dart';

class ArkErrorWidget extends StatelessWidget {
  const ArkErrorWidget({Key? key, required this.onRefresh}) : super(key: key);

  final Function onRefresh;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline_rounded,
            size: 55,
            color: Colors.red,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "Gagal memuat data... silahkan coba lagi",
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          OutlinedButton(
            onPressed: () async => await onRefresh(),
            child: const Text("Refresh"),
          ),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}
