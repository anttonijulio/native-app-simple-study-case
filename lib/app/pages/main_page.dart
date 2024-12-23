import 'package:flutter/material.dart';

import 'battery_page.dart';
import 'connection_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _changePage(int currentPage) {
    setState(() => _currentPage = currentPage);
    _pageController.animateToPage(
      _currentPage,
      duration: const Duration(milliseconds: 200),
      curve: Curves.linear,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _changePage,
        physics: const NeverScrollableScrollPhysics(),
        children: const [BatteryPage(), ConnectionPage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        onTap: _changePage,
        currentIndex: _currentPage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.battery_0_bar),
            activeIcon: Icon(Icons.battery_6_bar_sharp),
            label: 'Battery',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wifi_1_bar),
            activeIcon: Icon(Icons.wifi),
            label: 'Connection',
          ),
        ],
      ),
    );
  }
}
