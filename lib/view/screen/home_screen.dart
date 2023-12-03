


import 'package:flutter/material.dart';

import 'map_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const screenRoute = '/home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        selectedItemColor: Colors.blue,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.map_outlined),label: 'Map'),
          BottomNavigationBarItem(icon: Icon(Icons.route),label: 'Route'),
        ],
        currentIndex: currentPageIndex,
        onTap: (value) {
          setState(() {
            currentPageIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
      ),
      body: [
         MapScreen(),
        const Text('route'),
      ][currentPageIndex],
    );
  }
}




//
// bottomNavigationBar: BottomNavigationBar(
// backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//
// items: const [
// BottomNavigationBarItem(icon: Icon(Icons.map_outlined),label: 'Map'),
// BottomNavigationBarItem(icon: Icon(Icons.route),label: 'Route'),
// ],
// currentIndex: currentPageIndex,
// ),
// body: [
// Container(
// child: Text('Map'),
// ),
// Container(
// child: Text('route'),
// ),
// ][currentPageIndex],