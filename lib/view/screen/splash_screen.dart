
import 'dart:async';

import 'package:charge_go/view/screen/home_screen.dart';
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
      const Duration(seconds: 3),
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
    return SizedBox(
      height: widthOrHeight0(context, 0),
      width: double.infinity,
      child: Icon(Icons.ac_unit,color: Colors.white,),
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