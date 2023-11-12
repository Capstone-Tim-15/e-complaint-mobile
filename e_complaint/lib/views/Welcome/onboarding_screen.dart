import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'onboarding_page1.dart';
import 'onboarding_page2.dart';
import 'onboarding_page3.dart';
import 'onboarding_page4.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _controller = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                isLastPage = (index == 2);
              });
            },
            children: const [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.70),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // blank space
                const SizedBox(
                  width: 100,
                  child: Text(""),
                ),
                // dot indicator
                SmoothPageIndicator(
                    controller: _controller,
                    count: 3,
                    effect: const WormEffect(
                        activeDotColor: Colors.white,
                        dotColor: Colors.white,
                        paintStyle: PaintingStyle.stroke,
                        dotHeight: 15,
                        dotWidth: 15,
                        strokeWidth: 1)),
                // next button
                SizedBox(
                  width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isLastPage
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const IntroPage4(),
                                  ),
                                );
                              },
                              child: const Text("Next",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  )),
                            )
                          : const Text(""),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
