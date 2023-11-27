
import 'package:e_complaint/views/Chatbot/chatbot_screen.dart';
import 'package:e_complaint/views/Home/home_addcomplaint.dart';
import 'package:e_complaint/views/Home/home_screen.dart';
import 'package:e_complaint/views/Login/forgotpassword_screen.dart';
import 'package:e_complaint/views/Login/login_screen.dart';
import 'package:e_complaint/views/Login/resetpassword_screen.dart';
import 'package:e_complaint/views/Notifikasi/notif_screen.dart';

import 'package:flutter/material.dart';

import 'views/Register/register_dart.dart';
import 'views/Welcome/onboarding_screen.dart';
// import 'views/Welcome/spalsh_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'E-Complaint',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFDF2216)),
        // useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const OnboardingScreen(), // Route awal
        '/login': (context) => const LoginPage(),
        '/register': (context) => const HalamanDaftar(),
        '/home ': (context) => HomePage(),
        '/forgotpwd': (context) => ForgotPassword(),
        '/resetpwd': (context) => ResetPassword(),
        '/notifikasi': (context) => Notifikasi(),
        '/chatbot': (context) => const ChatBotScreen(),
        // '/news': (context) => ThirdPage(),
        '/addcomplaint':(context) => const AddComplaint(selectedLocation: '', selectedLocation2: '',),

      },
    );
  }
}
