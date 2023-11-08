import 'package:flutter/material.dart';

import 'views/Welcome/spalsh_screen.dart';

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
        '/': (context) => const SplashScreen(), // Route awal
        //  '/onboarding': (context) => SecondPage(),
        // '/login': (context) => ThirdPage(),
        // '/resgister': (context) => ThirdPage(),
        // '/home ': (context) => ThirdPage(),
        // '/news': (context) => ThirdPage(),
      },
    );
  }
}
