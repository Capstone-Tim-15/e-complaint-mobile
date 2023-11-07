import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);

  int _currentPage = 0;

  final List<OnboardingPage> onboardingPages = [
    OnboardingPage(
      deskripsi: 'Mari Berpartisipasi dalam penyaluran pelayanan publik',
      imagePath: 'assets/images/Saly-1.png',
    ),
    OnboardingPage(
      deskripsi:
          'Laporkan masalah dan ajukan pengaduan masalah yang Anda alami',
      imagePath: 'assets/images/logo.png',
    ),
    OnboardingPage(
      deskripsi: 'Sampaikan aspirasi Anda dengan mengajukan keluhan',
      imagePath: 'assets/images/logo.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: onboardingPages.length,
            itemBuilder: (context, index) {
              return onboardingPages[index];
            },
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildPageIndicator(),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < onboardingPages.length; i++) {
      indicators.add(
        Container(
          width: 8.0,
          height: 8.0,
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == i ? Colors.blue : Colors.grey,
          ),
        ),
      );
    }
    return indicators;
  }
}

class OnboardingPage extends StatelessWidget {
  final String deskripsi;
  final String imagePath;

  OnboardingPage({required this.deskripsi, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(60),
      color: const Color(0xffE64E45),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 350,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40, right: 60, left: 60),
            child: Text(
              deskripsi,
              style: const TextStyle(fontSize: 16, color: Colors.white),
              textAlign: TextAlign.justify,
            ),
          ),
          const SizedBox(height: 40),
          // Tampilkan tombol Mulai di halaman terakhir
        ],
      ),
    );
  }
}
