import 'package:e_complaint/viewModels/provider/complaint.dart';
import 'package:e_complaint/viewModels/provider/login.dart';
import 'package:e_complaint/viewModels/provider/register.dart';
import 'package:e_complaint/views/Chatbot/chatbot_screen.dart';
import 'package:e_complaint/views/Home/home_addcomplaint.dart';

import 'package:e_complaint/views/Home/home_screen.dart';
import 'package:e_complaint/views/Login/account_success.dart';
import 'package:e_complaint/views/Login/change_password.dart';
import 'package:e_complaint/views/Login/forgotpassword_screen.dart';
import 'package:e_complaint/views/Login/login_screen.dart';
import 'package:e_complaint/views/Login/resetpassword_screen.dart';
import 'package:e_complaint/views/Notifikasi/notif_screen.dart';

import 'package:e_complaint/views/widget/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Complaint',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Nunito",
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFDF2216)),
        // useMaterial3: true,
      ),
      initialRoute: '/addcomplaint',
      routes: {
        '/': (context) => const OnboardingScreen(), // Route awal
        '/login': (context) => LoginPage(),
        '/register': (context) => const HalamanDaftar(),
        '/home': (context) => BottomNavigation(),
        '/forgotpwd': (context) => ForgotPassword(),
        '/resetpwd': (context) => ResetPassword(),
        '/notifikasi': (context) => Notifikasi(),

        '/succesRegister': (context) => AccountSuccess(),
        '/succes-change-password': (context) => PasswordSucces(),
        '/chatbot': (context) => const ChatBotScreen(),
        '/addcomplaint': (context) => const AddComplaint(
              selectedLocation: '',
              selectedLocation2: '',
            ),
      },
    );
  }
}
