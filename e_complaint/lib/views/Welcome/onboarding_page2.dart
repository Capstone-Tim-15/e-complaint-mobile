import 'package:flutter/material.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFE64E45),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // image
          Container(
            margin: const EdgeInsets.only(top: 180),
            child: Image.asset(
              'assets/images/intro2.png',
              width: 300,
              height: 300,
            ),
          ),
          // text
          Container(
            margin: const EdgeInsets.only(top: 98, right: 40, left: 40),
            child: const Text(
              "Laporkan masalah dan ajukan pengaduan masalah yang Anda alami",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
