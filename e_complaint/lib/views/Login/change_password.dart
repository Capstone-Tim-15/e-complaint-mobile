import 'package:flutter/material.dart';

class PasswordSucces extends StatelessWidget {
  const PasswordSucces({super.key});

  TextStyle getTextStyle() {
    return const TextStyle(
      fontFamily: "Nunito",
      fontSize: 28,
      fontWeight: FontWeight.w700,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFF8FAFA),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              const SizedBox(
                height: 180,
              ),
              Text(
                "Kata sandi berhasil diubah!!",
                style: getTextStyle(),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 90,
              ),
              SizedBox(
                width: 300,
                child: Image.asset("assets/images/change_password_success.png"),
              ),
              const SizedBox(
                height: 88,
              ),
              Container(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigator
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEC7B73),
                    fixedSize: const Size(170, 45),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.2,
                    ),
                  ),
                  child: const Text("Login"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
