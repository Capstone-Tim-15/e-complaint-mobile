import 'package:e_complaint/models/user_profile.dart';
import 'package:e_complaint/views/widget/arsip_berita_widget.dart';
import 'package:e_complaint/views/widget/faq_widget.dart';
import 'package:e_complaint/views/widget/keluar_widget.dart';
import 'package:e_complaint/views/widget/profile_image_widget.dart';
import 'package:e_complaint/views/widget/status_pengaduan_widget.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class UserProfilePage extends StatelessWidget {
  final UserProfile user;

  UserProfilePage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profil',
          style: TextStyle(
              color: Colors.deepOrangeAccent,
              fontSize: 32,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.blue),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: Container(
            color: Colors.blue,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            profile_image_widget(user: user),
            SizedBox(
              height: 10,
            ),
            arsip_berita(),
            SizedBox(
              height: 20,
            ),
            status_pengaduan(),
            SizedBox(
              height: 30,
            ),
            faq(),
            SizedBox(
              height: 20,
            ),
            keluar(),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
