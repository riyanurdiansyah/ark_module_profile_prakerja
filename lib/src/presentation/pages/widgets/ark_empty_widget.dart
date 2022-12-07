import 'package:flutter/material.dart';

class ArkEmptyWidget extends StatelessWidget {
  const ArkEmptyWidget({Key? key, required this.onTap}) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      // padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/images/empty_state.png',
                width: 100, height: 100),
            const SizedBox(height: 10),
            const Text(
              'Gabung pelatihan sekarang dan tingkatkan\nkeahlianmu!',
              style: TextStyle(
                  fontWeight: FontWeight.w500, fontSize: 12, height: 1.6),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 35),
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //     padding:
            //         const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
            //     elevation: 1,
            //     primary: Colors.white,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(6),
            //       side: const BorderSide(
            //         width: 0.5,
            //         color: Color.fromRGBO(8, 114, 199, 1),
            //       ),
            //     ),
            //   ),
            //   onPressed: () => onTap(),
            //   child: const Text(
            //     'Eksplor Pelatihan',
            //     style: TextStyle(
            //       fontSize: 13,
            //       fontWeight: FontWeight.bold,
            //       color: Color.fromRGBO(8, 114, 199, 1),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
