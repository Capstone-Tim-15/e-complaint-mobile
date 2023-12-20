import 'package:e_complaint/views/Login/login_screen.dart';
import 'package:e_complaint/views/Welcome/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class keluar extends StatelessWidget {
  const keluar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFEC7B73),
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ListTile(
          title: Center(
            child: Text(
              'Keluar',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
          onTap: () {
            showExitConfirmationDialog(context);
          },
        ),
      ),
    );
  }

  void showExitConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Keluar'),
          content: Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () async {
                // Hapus token dari Shared Preferences
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.remove('bearerToken');

                // Navigasi ke halaman awal aplikasi
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => OnboardingScreen()),
                  (Route<dynamic> route) => false,
                );
              },
              child: Text('Keluar'),
            ),
          ],
        );
      },
    );
  }
}
