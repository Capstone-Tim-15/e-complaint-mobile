import 'package:flutter/material.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE64E45),
      alignment: Alignment.bottomCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // image
          Container(
            margin: const EdgeInsets.only(top: 200),
            child: Image.asset(
              'assets/images/intro1.png',
              width: 300,
              height: 300,
            ),
          ),
          SizedBox(
            height: 100,
          ),
          // text
          SizedBox(
            width: 239,
            //margin: const EdgeInsets.only(top: 80, right: 40, left: 40),
            child: const Text(
              "Mari Berpartisipasi dalam penyaluran pelayanan publik",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
