import 'package:e_complaint/views/Home/home_screen.dart';
import 'package:flutter/material.dart';
import "package:persistent_bottom_nav_bar/persistent_tab_view.dart";

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [
      HomePage(),
      HomePage(),
      HomePage(),
      HomePage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const ImageIcon(
          AssetImage('assets/icons/icon_home.png'),
        ),
        activeColorPrimary: const Color.fromARGB(255, 255, 219, 207),
        activeColorSecondary: Colors.black,
        inactiveColorPrimary: Colors.black,
        iconSize: 24,
      ),
      PersistentBottomNavBarItem(
        icon: const ImageIcon(
          AssetImage('assets/icons/icon_search.png'),
        ),
        activeColorPrimary: const Color.fromARGB(255, 255, 219, 207),
        activeColorSecondary: Colors.black,
        inactiveColorPrimary: Colors.black,
        iconSize: 24,
      ),
      PersistentBottomNavBarItem(
        icon: const ImageIcon(
          AssetImage('assets/icons/icon_notification.png'),
        ),
        activeColorPrimary: const Color.fromARGB(255, 255, 219, 207),
        activeColorSecondary: Colors.black,
        inactiveColorPrimary: Colors.black,
        iconSize: 24,
      ),
      PersistentBottomNavBarItem(
        icon: const ImageIcon(
          AssetImage('assets/icons/icon_profile.png'),
        ),
        activeColorPrimary: const Color.fromARGB(255, 255, 219, 207),
        activeColorSecondary: Colors.black,
        inactiveColorPrimary: Colors.black,
        iconSize: 24,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      decoration: NavBarDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey, // Warna bayangan
            blurRadius: 8, // Radius blur bayangan
            offset: Offset(0, 2), // Posisi bayangan (x, y)
          ),
        ],
      ),
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      backgroundColor: Colors.white,
      navBarStyle: NavBarStyle.style7,
      navBarHeight: 52,
    );
  }
}
