// ignore_for_file: prefer_const_constructors

import 'package:e_complaint/models/user_profile.dart';
import 'package:e_complaint/viewModels/provider/complaint.dart';
import 'package:e_complaint/viewModels/provider/edit_profile.dart';
import 'package:e_complaint/viewModels/provider/login.dart';
import 'package:e_complaint/viewModels/provider/register.dart';
import 'package:e_complaint/views/Chatbot/chatbot_screen.dart';
import 'package:e_complaint/views/History_Pengaduan/riwayat_pengaduan_page.dart';
import 'package:e_complaint/views/Home/click_comment.dart';
import 'package:e_complaint/views/Home/home_addcomplaint.dart';

// import 'package:e_complaint/views/Home/home_screen.dart';
import 'package:e_complaint/views/Login/account_success.dart';
import 'package:e_complaint/views/Login/change_password.dart';
import 'package:e_complaint/views/Login/forgotpassword_screen.dart';
import 'package:e_complaint/views/Login/login_screen.dart';
import 'package:e_complaint/views/Login/resetpassword_screen.dart';
import 'package:e_complaint/views/Notifikasi/notif_screen.dart';
import 'package:e_complaint/views/Profile/profile_detail.dart';
import 'package:e_complaint/views/Profile/profile_page.dart';
import 'package:e_complaint/views/Search/result/result.page.dart';
import 'package:e_complaint/views/Welcome/onboarding_page1.dart';
import 'package:flutter/material.dart';
import 'views/Search/search_kategori_screen.dart';

import 'package:e_complaint/views/widget/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'views/Register/register.dart';
import 'views/Welcome/onboarding_screen.dart';
// import 'views/Welcome/spalsh_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RegistrationProvider()),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => AddComplaintProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // final UserProfile user = UserProfile(
  //   id: '',

  //   name: 'Jelita Salsabila',
  //   profileImageUrl:
  //       'https://res.cloudinary.com/dtvwbspq9/image/upload/v1698682685/WhatsApp_Image_2023-10-30_at_22.29.11_wvlup7.jpg',
  //   coverImageUrl:
  //       'https://res.cloudinary.com/dtvwbspq9/image/upload/v1698682685/WhatsApp_Image_2023-10-30_at_22.29.11_wvlup7.jpg',
  //   email: 'JelitaS@gmail.com',
  //   phoneNumber: '080987278935',
  // );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Complaint',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Nunito",
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFDF2216)),
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) => const LoginPage());
          case '/login':
            return MaterialPageRoute(builder: (context) => LoginPage());
          case '/register':
            return MaterialPageRoute(builder: (context) => const HalamanDaftar());
          case '/forgotpwd':
            return MaterialPageRoute(builder: (context) => ForgotPassword());
          case '/resetpwd':
            return MaterialPageRoute(builder: (context) => ResetPassword());
          case '/succesRegister':
            return MaterialPageRoute(builder: (context) => AccountSuccess());
          case '/succes-change-password':
            return MaterialPageRoute(builder: (context) => PasswordSucces());
          case '/home':
            return MaterialPageRoute(
              builder: (context) => FutureBuilder<bool>(
                future: hasValidToken(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Menampilkan indikator loading jika sedang menunggu hasil pemeriksaan token
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError || !snapshot.data!) {
                    // Redirect ke halaman login jika token tidak valid
                    return LoginPage();
                  } else {
                    // Lanjut ke halaman home jika token valid
                    return BottomNavigation();
                  }
                },
              ),
            );
          case '/notifikasi':
            return MaterialPageRoute(builder: (context) => Notifikasi());
          case '/comment':
            return MaterialPageRoute(builder: (context) => FullScreenCommentPage());
          case '/profile':
            return MaterialPageRoute(builder: (context) => UserProfilePage());
          case '/profile-detail':
            return MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                create: (_) => EditUserProvider(),
                child: const Profiledetail(),
              ),
            );
          case '/riwayat-pengaduan':
            return MaterialPageRoute(builder: (context) => riwayat_pengaduan_page());
          case '/chatbot':
            return MaterialPageRoute(builder: (context) => const ChatBotScreen());
          case '/comment':
            return MaterialPageRoute(builder: (context) => FullScreenCommentPage());
          case '/addcomplaint':
            return MaterialPageRoute(
              builder: (context) => const AddComplaint(
                selectedLocation: '',
                selectedLocation2: '',
              ),
            );
          default:
            return MaterialPageRoute(builder: (context) => UnknownRoutePage());
        }
      },
    );
  }

  // Fungsi ini dapat Anda sesuaikan sesuai dengan cara Anda menyimpan dan memeriksa token
  Future<bool> hasValidToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwtToken = prefs.getString('token');
    // Implementasi pemeriksaan token di sini
    return jwtToken != null && jwtToken.isNotEmpty;
  }
} // Misalnya, dapat menggunakan Shared Preferences atau penyimpanan lokal lainnya

class UnknownRoutePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('404 - Halaman tidak ditemukan'),
      ),
      body: Center(
        child: Text('Halaman tidak ditemukan'),
      ),
    );
  }
}
