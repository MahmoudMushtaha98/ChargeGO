
import 'dart:async';
import 'package:charge_go/view/charging_point_screen.dart';
import 'package:charge_go/view/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
            builder: (context) => const HomeScreen(),
          )),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        height: widthOrHeight0(context, 0),
        child: SvgPicture.asset('assets/svg/Screenshot (180).svg'),
      ),
    );
  }
}
double widthOrHeight0(BuildContext context,int number){
  if(number == 0){
    return MediaQuery.of(context).size.height;
  }else{
    return MediaQuery.of(context).size.height;
  }
}