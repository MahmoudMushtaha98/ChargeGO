
import 'package:charge_go/view/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/translate_map.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final FlutterLocalization localization = FlutterLocalization.instance;



  @override
  void initState(){
    localization.init(
      mapLocales: [
        const MapLocale('en', AppLocale.EN),
        const MapLocale('ar', AppLocale.AR),

      ],
      initLanguageCode: appLang == ''? 'en' : appLang,
    );
    localization.onTranslatedLanguage = _onTranslatedLanguage;
    super.initState();
  }

  void _onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: FlutterLocalization.instance.currentLocale,
      debugShowCheckedModeBanner: false,
      supportedLocales: const [
        Locale('en','US'),
        Locale('ar','AR')
      ],
      localizationsDelegates: localization.localizationsDelegates,
      home: const SplashScreen(),
    );
  }
}


String appLang = '';