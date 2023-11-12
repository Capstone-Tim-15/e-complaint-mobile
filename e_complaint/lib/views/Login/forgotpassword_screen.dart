// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Column(
            children: [
              Column(
                children: [
                  Text(
                    'Bantu kami',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF212121),
                      fontSize: 32,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                    ),
                  ),
                  Text(
                    'Menemukan Akunmu',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF212121),
                      fontSize: 32,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Masukkan Email, nomor telepon, atau username',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
                  ),
                  Text(
                    'yang bersangkutan dengan akunmu.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 100, top: 30, left: 100, right: 100),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 150, left: 100, right: 100),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/resetpwd');
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xFFEC7B73), // Warna teks (putih)
                    ),
                    child: Text('Selanjutnya'),
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
