import 'package:e_complaint/views/Login/login_screen.dart';
import 'package:flutter/material.dart';

import 'views/Welcome/onboarding_screen.dart';
// import 'views/Welcome/spalsh_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const OnboardingScreen(), // Route awal
        '/login': (context) => const LoginScreen(),
        // '/resgister': (context) => ThirdPage(),
        // '/home ': (context) => ThirdPage(),
        // '/news': (context) => ThirdPage(),
      },
    );
  }
}
