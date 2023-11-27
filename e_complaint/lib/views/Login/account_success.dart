import 'package:flutter/material.dart';

class AccountSuccess extends StatelessWidget {
  const AccountSuccess({super.key});

  TextStyle getTextStyle() {
    return const TextStyle(
      fontFamily: "Nunito",
      fontSize: 28,
      fontWeight: FontWeight.w600,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFF8FAFA),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              const SizedBox(
                height: 180,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Selamat!!",
                    style: getTextStyle(),
                  ),
                  Text(
                    "Akun anda berhasil dibuat",
                    style: getTextStyle(),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                width: 330,
                child: Image.asset("assets/images/create_account_success.png"),
              ),
              const SizedBox(
                height: 135,
              ),
              Container(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
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
                      )),
                  child: const Text(
                    "Halaman Utama",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
