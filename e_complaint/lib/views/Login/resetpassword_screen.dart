// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 100, left: 20, right: 20),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Create a password\nnew',
              style: TextStyle(
                color: Color(0xFF212121),
                fontSize: 36,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w600,
                height: 1,
              ),
            ), // Menggunakan "\n" untuk baris baru
            SizedBox(height: 20),
            SizedBox(
              width: 324,
              child: Text(
                'Pastikan password anda memiliki 8 karakter atau lebih. Coba masukkan nomer, huruf, dan tanda       baca untuk kata sandi yang kuat. ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w500,
                  //height: 0.10,
                  //letterSpacing: 0.10,
                ),
              ),
            ),
            SizedBox(
              width: 324,
              child: Text(
                'Anda akan dikeluarkan dari semua device secara otomatis setelah mengganti password baru. ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w500,
                  //height: 0.10,
                  //letterSpacing: 0.10,)
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField()
          ],
        ),
      ),
    );
  }
}
