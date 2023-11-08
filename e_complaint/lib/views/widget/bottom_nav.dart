import 'package:e_complaint/views/Home/news_screen.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        indicatorColor: Colors.white,
        height: 52,
        backgroundColor: Colors.white,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const [
          NavigationDestination(
              selectedIcon: ImageIcon(
                size: 32,
                color: Color.fromARGB(255, 224, 34, 22),
                AssetImage('assets/icons/icon_home.png'),
              ),
              icon: ImageIcon(
                size: 32,
                AssetImage('assets/icons/icon_home.png'),
              ),
              label: 'Home'),
          NavigationDestination(
              selectedIcon: ImageIcon(
                size: 32,
                color: Color.fromARGB(255, 224, 34, 22),
                AssetImage('assets/icons/icon_search.png'),
              ),
              icon: ImageIcon(
                size: 32,
                AssetImage('assets/icons/icon_search.png'),
              ),
              label: 'Search'),
          NavigationDestination(
              selectedIcon: ImageIcon(
                size: 32,
                color: Color.fromARGB(255, 224, 34, 22),
                AssetImage('assets/icons/icon_notification.png'),
              ),
              icon: ImageIcon(
                size: 32,
                AssetImage('assets/icons/icon_notification.png'),
              ),
              label: 'Notification'),
          NavigationDestination(
              selectedIcon: ImageIcon(
                size: 32,
                color: Color.fromARGB(255, 224, 34, 22),
                AssetImage('assets/icons/icon_profile.png'),
              ),
              icon: ImageIcon(
                size: 32,
                AssetImage('assets/icons/icon_profile.png'),
              ),
              label: 'Profile'),
        ],
      ),
      body: <Widget>[
        const NewsScreen(),
        const NewsScreen(),
        const NewsScreen(),
        const NewsScreen(),
      ][currentPageIndex],
    );
  }
}
