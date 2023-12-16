import 'package:e_complaint/models/user_profile.dart';
import 'package:e_complaint/views/Home/home_screen.dart';
import 'package:e_complaint/views/Notifikasi/notif_screen.dart';
import 'package:e_complaint/views/Profile/profile_detail.dart';
import 'package:e_complaint/views/Profile/profile_page.dart';
import 'package:e_complaint/views/Search/search_kategori_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        elevation: 20,
        indicatorColor: const Color.fromARGB(255, 255, 219, 207),
        height: 60,
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
                size: 24,
                AssetImage('assets/icons/icon_home_hover.png'),
              ),
              icon: ImageIcon(
                size: 24,
                AssetImage('assets/icons/icon_home.png'),
              ),
              label: 'Home'),
          NavigationDestination(
              selectedIcon: ImageIcon(
                size: 24,
                AssetImage('assets/icons/icon_search_hover.png'),
              ),
              icon: ImageIcon(
                size: 24,
                AssetImage('assets/icons/icon_search.png'),
              ),
              label: 'Search'),
          NavigationDestination(
              selectedIcon: ImageIcon(
                size: 24,
                AssetImage('assets/icons/icon_notification_hover.png'),
              ),
              icon: ImageIcon(
                size: 24,
                AssetImage('assets/icons/icon_notification.png'),
              ),
              label: 'Notification'),
          NavigationDestination(
              selectedIcon: ImageIcon(
                size: 24,
                AssetImage('assets/icons/icon_profile_hover.png'),
              ),
              icon: ImageIcon(
                size: 24,
                AssetImage('assets/icons/icon_profile.png'),
              ),
              label: 'Profile'),
        ],
      ),
      body: <Widget>[
        HomePage(),
        SearchPage(),
        Notifikasi(),
        UserProfilePage(),
      ][currentPageIndex],
    );
  }
}
