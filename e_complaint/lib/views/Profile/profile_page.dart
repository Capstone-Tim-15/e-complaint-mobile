import 'package:e_complaint/models/user_profile.dart';
import 'package:e_complaint/views/widget/arsip_berita_widget.dart';
import 'package:e_complaint/views/widget/faq_widget.dart';
import 'package:e_complaint/views/widget/keluar_widget.dart';
import 'package:e_complaint/views/widget/profile_image_widget.dart';
import 'package:e_complaint/views/widget/status_pengaduan_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../viewModels/provider/profile.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  UserProfile? user; // Change UserProfile to be nullable
  late String userName;
  final ProfileProvider _profileProvider = ProfileProvider();

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> saveProfile(
      String name, String email, String phone, String imageUrl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('email', email);
    await prefs.setString('phone', phone);
    await prefs.setString('imageUrl', imageUrl);
  }

  Future<void> fetchUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userName = prefs.getString('name') ?? '';
    String jwt = prefs.getString('token') ?? '';

    try {
      Map<String, dynamic> userData =
          await _profileProvider.getUserByName(userName, jwt);

      setState(() {
        user = UserProfile(
          name: userData['results']['name'],
          profileImageUrl: userData['results']['imageUrl'] ?? '',
          coverImageUrl: userData['results']['coverImageUrl'] ?? '',
          email: userData['results']['email'] ?? '',
          phoneNumber: userData['results']['phone'] ?? '',
        );
        this.userName = userName;
        saveProfile(
            user!.name, user!.email, user!.phoneNumber, user!.profileImageUrl);
      });
    } catch (error) {
      print('Error fetching user profile: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profil',
          style: TextStyle(
            color: Colors.deepOrangeAccent,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
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
            if (user != null) ProfileImageWidget(user: user!),
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
