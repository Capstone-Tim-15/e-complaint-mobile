import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

class Complaint {
  final String categoryId;
  final String title;
  final String status;
  final String content;
  final String attachment;

  Complaint({
    required this.categoryId,
    required this.title,
    required this.status,
    required this.content,
    required this.attachment,
    required String nama,
    required String imagePath,
    required Color textColor,
    required String tulisKeluhan,
    required String alamat,
    required String selectedCategory,
  });

  // Metode untuk mengonversi objek ke map untuk dikirim sebagai formulir
}
