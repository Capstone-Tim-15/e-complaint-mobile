import 'package:e_complaint/models/user_profile.dart';
import 'package:e_complaint/views/widget/profile_image_widget.dart';
import 'package:e_complaint/views/Profile/widgets/status_pengaduan_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../viewModels/provider/profile.dart';
import 'widgets/arsip_berita_widget.dart';
import 'widgets/faq_widget.dart';
import 'widgets/keluar_widget.dart';

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

  Future<void> saveProfile(String id, String username, String name,
      String email, String phone, String imageUrl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', id);
    await prefs.setString('username', username);
    await prefs.setString('name', name);
    await prefs.setString('email', email);
    await prefs.setString('phone', phone);
    await prefs.setString('imageUrl', imageUrl);

    // prefs.getKeys().forEach((key) {
    //   print('$key: ${prefs.get(key)}');
    // });
  }

  Future<void> fetchUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userName = prefs.getString('name') ?? '';
    String jwt = prefs.getString('bearerToken') ?? '';

    try {
      Map<String, dynamic> userData =
          await _profileProvider.getUserByName(userName, jwt);

      setState(() {
        user = UserProfile(
          id: userData['results']['id'],
          username: userData['results']['username'],
          name: userData['results']['name'],
          profileImageUrl: userData['results']['imageUrl'] ?? '',
          coverImageUrl: userData['results']['coverImageUrl'] ?? '',
          email: userData['results']['email'] ?? '',
          phoneNumber: userData['results']['phone'] ?? '',
        );
        this.userName = userName;
        saveProfile(
          user!.id,
          user!.username,
          user!.name,
          user!.email,
          user!.phoneNumber,
          user!.profileImageUrl,
        );
      });
      prefs.getKeys().forEach((key) {
        print('$key: ${prefs.get(key)}');
      });
    } catch (error) {
      print('Error fetching user profile: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profil',
          style: TextStyle(
            color: Colors.deepOrangeAccent,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
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
            const SizedBox(
              height: 10,
            ),
            const arsip_berita(),
            const SizedBox(
              height: 20,
            ),
            const status_pengaduan(),
            const SizedBox(
              height: 30,
            ),
            const faq(),
            const SizedBox(
              height: 20,
            ),
            const keluar(),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
