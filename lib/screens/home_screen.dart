import 'package:auctify/screens/home_fragment.dart';
import 'package:auctify/screens/product_list_screen.dart';
import 'package:auctify/screens/profile_screen.dart';
import 'package:auctify/screens/track_order.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void onTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final listOfScreens = [
    HomeFragment(),
    ProductListScreen(),
    TrackOrder(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
              backgroundColor: Colors.transparent,
              color: Colors.black,
              height: 70,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: const [
                Icon(
                  Icons.home,
                  size: 30,
                  color: Colors.white,
                ),
                Icon(
                  Icons.search,
                  size: 30,
                  color: Colors.white,
                ),
                Icon(
                  Icons.directions_bus_filled,
                  size: 30,
                  color: Colors.white,
                ),
                Icon(
                  Icons.person,
                  size: 30,
                  color: Colors.white,
                ),
              ]),
          body: listOfScreens[_currentIndex]),
    );
  }
}
