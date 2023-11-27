// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool _obscure = true;
  bool _obscureConfirm = true;
  final _formKey = GlobalKey<FormState>(); // Tambahkan ini

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 150, left: 20, right: 20),
        child: Form(
          // Tambahkan Form widget di sini
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create a password\nnew',
                style: TextStyle(
                  color: Color(0xFF212121),
                  fontSize: 36,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w700,
                  height: 1,
                ),
              ),
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
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                // Ubah TextField menjadi TextFormField
                obscureText: _obscure,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  labelText: "Kata Sandi",
                  suffixIcon: IconButton(
                    icon: Icon(
                        _obscure ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _obscure = !_obscure;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kata Sandi harus diisi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                // Ubah TextField menjadi TextFormField
                obscureText: _obscureConfirm,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  labelText: "Konfirmasi Kata Sandi",
                  suffixIcon: IconButton(
                    icon: Icon(_obscureConfirm
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _obscureConfirm = !_obscureConfirm;
                      });
                    },
                  ),
                ),
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Konfirmasi Kata Sandi harus diisi';
                //   }
                //   return null;
                // },
              ),
              SizedBox(height: 250),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Menampilkan AlertDialog
                      _showVerificationDialog(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFFEC7B73),
                  ),
                  child: Text('Ganti Kata Sandi'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Fungsi untuk menampilkan AlertDialog
void _showVerificationDialog(BuildContext context) {
  String verificationCode =
      ''; // Menambahkan variabel state untuk kode verifikasi

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        title: Center(
          child: Text(
            'Kami telah mengirimkan kode verifikasi melalui email yang anda masukkan',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 16,
                fontWeight: FontWeight.w700),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min, // Menggunakan ukuran minimal
          children: [
            // Form untuk kode verifikasi
            TextFormField(
              onChanged: (value) {
                verificationCode = value;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Kode Verifikasi',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Kode Verifikasi harus diisi';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                'Tidak menerima kode?',
                style: TextStyle(
                  color: Color(0xFF001945),
                  fontSize: 14,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          ],
        ),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Logika untuk memproses kode verifikasi
                // Tambahkan logika sesuai kebutuhan aplikasi Anda
                // Setelah berhasil memproses, Anda bisa menutup AlertDialog
                if (verificationCode.isNotEmpty) {
                  // Lakukan sesuatu dengan verificationCode
                  // Contoh: Menampilkan pemberitahuan bahwa kata sandi berhasil diubah
                  _showSuccessNotification(context);

                  // Setelah itu, pindahkan pengguna ke halaman login
                  Navigator.of(context).pop(); // Tutup AlertDialog
                  Navigator.pushReplacementNamed(
                      context, '/login'); // Pindah ke halaman login
                } else {
                  // Tampilkan pesan kesalahan jika diperlukan
                  _showErrorNotification(
                      context, 'Kode Verifikasi tidak valid.');
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFFEC7B73),
              ),
              child: Text('Selanjutnya'),
            ),
          ),
        ],
      );
    },
  );
}

// Fungsi untuk menampilkan pemberitahuan sukses
void _showSuccessNotification(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Kata sandi berhasil diubah!'),
      backgroundColor: Colors.green.shade300,
    ),
  );
}

// Fungsi untuk menampilkan pemberitahuan kesalahan
void _showErrorNotification(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ),
  );
}
