
import 'dart:async';
import 'package:charge_go/view/charging_point_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 2),
          () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ChargingPointScreen(),
          )),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Image.asset(fit: BoxFit.cover, 'assets/images/Screenshot_180.png'),
    );
  }
}
