import 'package:charge_go/config/translate_map.dart';
import 'package:charge_go/view/screen/route_screen.dart';
import 'package:charge_go/view/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

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
      bottomNavigationBar: Container(
        height: widthOrHeight0(context, 0)*0.1,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              spreadRadius: 0.5,
              blurRadius: 30,
              offset: const Offset(0, 5),
            ),
          ]
        ),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          selectedItemColor: Colors.blue,
          items: [
            BottomNavigationBarItem(
                icon: const Icon(Icons.map_outlined),
                label: AppLocale.mapNav.getString(context)),
            BottomNavigationBarItem(
                icon: const Icon(Icons.route),
                label: AppLocale.routeNav.getString(context)),
          ],
          currentIndex: currentPageIndex,
          onTap: (value) {
            setState(() {
              currentPageIndex = value;
            });
          },
        ),
      ),
      body: [
        const MapScreen(),
        const RouteScreen(),
      ][currentPageIndex],
    );
  }
}
