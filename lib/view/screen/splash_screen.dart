import 'dart:async';
import 'package:charge_go/controller/map_controller.dart';
import 'package:charge_go/view/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key, }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      getPref();
      Navigator.pushNamedAndRemoveUntil(context, HomeScreen.screenRoute, (route) => false);
    });
    super.initState();
  }

  void getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    appLang = sharedPreferences.getString('lang') ?? 'en';
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

double widthOrHeight0(BuildContext context, int number) {
  if (number == 0) {
    return MediaQuery.of(context).size.height;
  } else {
    return MediaQuery.of(context).size.height;
  }
}
