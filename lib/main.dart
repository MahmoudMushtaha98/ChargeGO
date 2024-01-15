import 'package:charge_go/config/location.dart';
import 'package:charge_go/view/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:location/location.dart';
import 'config/screen_route.dart';
import 'config/translate_map.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  locationData =await LocationService().getLocation();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterLocalization localization = FlutterLocalization.instance;

  @override
  void initState() {
    localization.init(
      mapLocales: [
        const MapLocale('en', AppLocale.EN,fontFamily: 'Oswald'),
        const MapLocale('ar', AppLocale.AR,fontFamily: 'Cairo'),
      ],
      initLanguageCode: appLang == '' ? 'en' : appLang,

    ).then((value) {
    });
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
      supportedLocales: const [Locale('en', 'US'), Locale('ar', 'AR')],
      localizationsDelegates: localization.localizationsDelegates,
      theme: ThemeData(fontFamily: localization.fontFamily),
      routes: routes(),
      home: const SplashScreen(),
    );
  }
}

String appLang = '';
LocationData locationData = LocationData.fromMap({"latitude": 0.0, "longitude": 0.0});
