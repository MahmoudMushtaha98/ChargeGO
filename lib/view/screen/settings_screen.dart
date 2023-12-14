import 'package:charge_go/config/translate_map.dart';
import 'package:charge_go/main.dart';
import 'package:charge_go/view/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  static const String routeScreen = '/SettingsScreen';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final FlutterLocalization localization = FlutterLocalization.instance;
  String? selectedLanguage;
  bool station = true;
  bool home = true;

  @override
  Widget build(BuildContext context) {
    selectedLanguage = appLang.contains('en') ? appLang : 'ar';
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.close,
                  color: Colors.black,
                  size: widthOrHeight0(context, 1) * 0.05,
                )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: widthOrHeight0(context, 1) * 0.02,
                      right: widthOrHeight0(context, 1) * 0.02),
                  child: Text(
                    AppLocale.filter.getString(context),
                    style:
                        TextStyle(fontSize: widthOrHeight0(context, 1) * 0.05),
                  ),
                ),
                SizedBox(
                  height: widthOrHeight0(context, 0) * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: widthOrHeight0(context, 1) * 0.45,
                      height: widthOrHeight0(context, 0) * 0.25,
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xff808080)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(35))),
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(Icons.ev_station,
                                    size: widthOrHeight0(context, 1) * 0.05),
                                Text(AppLocale.station.getString(context),
                                    style: TextStyle(
                                        fontSize:
                                            widthOrHeight0(context, 1) * 0.025,
                                        fontWeight: FontWeight.bold)),
                                Switch(
                                  value: station,
                                  onChanged: (value) {
                                    setState(() {
                                      station = value;
                                    });
                                  },
                                  activeTrackColor: Colors.blue,
                                )
                              ],
                            ),
                          ),
                          Divider(
                            endIndent: widthOrHeight0(context, 1) * 0.05,
                            indent: widthOrHeight0(context, 1) * 0.05,
                            color: Colors.black,
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(Icons.home,
                                    size: widthOrHeight0(context, 1) * 0.05),
                                Text(AppLocale.home.getString(context),
                                    style: TextStyle(
                                        fontSize:
                                            widthOrHeight0(context, 1) * 0.025,
                                        fontWeight: FontWeight.bold)),
                                Switch(
                                  value: home,
                                  onChanged: (value) {
                                    setState(() {
                                      home = value;
                                    });
                                  },
                                  activeTrackColor: Colors.blue,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              width: double.infinity,
              height: widthOrHeight0(context, 0) * 0.05,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: widthOrHeight0(context, 1) * 0.02,
                      right: widthOrHeight0(context, 1) * 0.02),
                  child: Text(
                    AppLocale.language.getString(context),
                    style:
                        TextStyle(fontSize: widthOrHeight0(context, 1) * 0.05),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: widthOrHeight0(context, 0) * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: widthOrHeight0(context, 1) * 0.45,
                      height: widthOrHeight0(context, 0) * 0.08,
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xff808080)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Radio(
                            fillColor: selectedLanguage!.contains('en')
                                ? const MaterialStatePropertyAll(
                                    Color(0xff39b6fe))
                                : null,
                            value: 'en',
                            groupValue: selectedLanguage,
                            onChanged: (value) {
                              setState(() async {
                                SharedPreferences sharedPreferences =
                                    await SharedPreferences.getInstance();
                                selectedLanguage = value.toString();
                                localization.translate('en');
                                sharedPreferences.setString('lang', 'en');
                                appLang = 'en';
                              });
                            },
                          ),
                          const Text(
                            'English',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                          Radio(
                            focusColor: const Color(0xff39b6fe),
                            fillColor: selectedLanguage!.contains('ar')
                                ? const MaterialStatePropertyAll(
                                    Color(0xff39b6fe))
                                : null,
                            activeColor: Colors.black,
                            value: 'ar',
                            groupValue: selectedLanguage,
                            onChanged: (value) {
                              setState(() async {
                                SharedPreferences sharedPreferences =
                                    await SharedPreferences.getInstance();
                                selectedLanguage = value.toString();
                                localization.translate('ar');
                                sharedPreferences.setString('lang', 'ar');
                                appLang = 'ar';
                              });
                            },
                          ),
                          const Text('عربي',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
