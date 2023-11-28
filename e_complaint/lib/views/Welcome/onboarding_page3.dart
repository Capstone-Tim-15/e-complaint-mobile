import 'package:flutter/material.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFE64E45),
      alignment: Alignment(0, 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // image
          Container(
            margin: const EdgeInsets.only(top: 100),
            child: Image.asset(
              'assets/images/intro3.png',
              width: 400,
              height: 400,
            ),
          ),
          // text
          SizedBox(
            height: 100,
          ),
          SizedBox(
            width: 299,
            //margin: const EdgeInsets.only(top: 80, right: 40, left: 40),
            child: const Text(
              "Sampaikan aspirasi Anda dengan mengajukan keluhan",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                height: 0,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
