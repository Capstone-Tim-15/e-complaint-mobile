import 'package:flutter/material.dart';

class IntroPage4 extends StatelessWidget {
  const IntroPage4({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffffffff),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Text Button Masuk Top Right
          Container(
            margin: const EdgeInsets.only(top: 70, right: 20),
            alignment: Alignment.topRight,
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: const Text(
                "Masuk",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  height: 0.10,
                  letterSpacing: 0.10,
                ),
              ),
            ),
          ),
          //Text logo
          Container(
            margin: const EdgeInsets.only(top: 50, bottom: 110),
            child: Image.asset(
              'assets/images/text_gov.png',
              width: 300,
            ),
          ),
          Container(
            // margin: const EdgeInsets.only(top: 100),
            child: Image.asset(
              'assets/images/intro4.png',
              width: 350,
            ),
          ),
          // button register
          Container(
            margin: const EdgeInsets.only(top: 120),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              style: ElevatedButton.styleFrom(
                  primary: const Color(0xFFEC7B73),
                  padding: const EdgeInsets.symmetric(horizontal: 140),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(150, 40)),
              child: const Text(
                "Register",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
