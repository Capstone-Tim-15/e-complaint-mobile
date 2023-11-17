// ignore_for_file: prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HalamanDaftar extends StatefulWidget {
  const HalamanDaftar({super.key});

  @override
  State<HalamanDaftar> createState() => _HalamanDaftarState();
}

class _HalamanDaftarState extends State<HalamanDaftar> {
  final _formKey = GlobalKey<FormState>(); // Kunci global untuk form

  bool obscureTextKataSandi = true;
  bool obscureTextKonfirmasiKS = true;

  TextEditingController name = TextEditingController();
  TextEditingController conNoTelp = TextEditingController();
  TextEditingController conEmail = TextEditingController();
  TextEditingController conUsername = TextEditingController();
  TextEditingController conKataSandi = TextEditingController();
  TextEditingController conKonfirmasiKS = TextEditingController();
  final Dio _dio = Dio();

  Future<Response> register(String name, String conNoTelp, String conEmail) {
    return _dio.post(
      '34.128.69.15:8000/user/register',
      // data: {
      //   'name': username,
      //   'otp': password,
      // },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey, // Menggunakan kunci form
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 80,
                ),
                Text(
                  'Halo!',
                  style: TextStyle(
                    color: Color(0xFF191C1D),
                    fontSize: 57,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Sudah mempunya akun?",
                      style: TextStyle(
                          color: Color(0xFF191C1D),
                          fontSize: 16,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w600),
                    ),
                    GestureDetector(
                      child: Text(" Masuk Disini",
                          style: TextStyle(
                              color: Color(0xFF990000),
                              fontSize: 16,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline)),
                      onTap: () {
                        Navigator.pushNamed(context, '/login');
                      },
                    ),
                  ],
                ),
                SizedBox(height: 50),
                TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Nama",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: conNoTelp,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Nomor Telepon",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nomor Telepon tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: conEmail,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "E-Mail",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email tidak boleh kosong';
                    } else if (!value.endsWith("@gmail.com")) {
                      return 'Harap masukkan akun Gmail';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: conUsername,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Username",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Username tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: conKataSandi,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Kata Sandi",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscureTextKataSandi = !obscureTextKataSandi;
                        });
                      },
                      icon: Icon(
                        obscureTextKataSandi
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                  obscureText: obscureTextKataSandi,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kata Sandi tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: conKonfirmasiKS,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Konfirmasi Kata Sandi",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscureTextKonfirmasiKS = !obscureTextKonfirmasiKS;
                        });
                      },
                      icon: Icon(
                        obscureTextKonfirmasiKS
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                  obscureText: obscureTextKonfirmasiKS,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Konfirmasi Kata Sandi tidak boleh kosong';
                    } else if (value != conKataSandi.text) {
                      return 'Konfirmasi Kata Sandi tidak cocok';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 90),
                Container(
                  width: double.infinity,
                  height: 35,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Formulir valid, lakukan tindakan pendaftaran di sini
                        // Contoh: simpan data ke database atau lakukan login
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFEC7B73), // Warna oranye
                    ),
                    child: Text("Buat Akun"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
