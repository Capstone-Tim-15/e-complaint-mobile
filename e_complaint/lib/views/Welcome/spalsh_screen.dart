// // dastin

// import 'package:flutter/material.dart';
// import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';

// import 'onboarding_screen.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return FlutterSplashScreen.fadeIn(
//       duration: const Duration(seconds: 3),
//       backgroundColor: Colors.white,
//       nextScreen: const OnboardingScreen(),
//       onInit: () {
//         debugPrint('on init');
//       },
//       onEnd: () {
//         debugPrint('On End');
//       },
//       onAnimationEnd: () => debugPrint("Next Screen"),
//       childWidget: SizedBox(
//         width: 200,
//         height: 200,
//         child: Image.asset('assets/images/logo.png'),
//       ),
//     );
//   }
// }
