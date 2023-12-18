import 'package:charge_go/config/translate_map.dart';
import 'package:charge_go/main.dart';
import 'package:charge_go/view/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/setting_controller.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  static const String routeScreen = '/SettingsScreen';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  SettingController settingController = SettingController();

  @override
  Widget build(BuildContext context) {
    settingController.selectedLanguage =
        appLang.contains('en') ? appLang : 'ar';
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.close,
              color: Colors.black,
              size: widthOrHeight0(context, 1) * 0.05,
            )),
        title: Text(
          AppLocale.settingNav.getString(context),
          style: TextStyle(
              fontSize: widthOrHeight0(context, 1) * 0.03,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: widthOrHeight0(context, 0) * 0.05,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: widthOrHeight0(context, 1) * 0.02,
                    right: widthOrHeight0(context, 1) * 0.02),
                child: Text(
                  AppLocale.filter.getString(context),
                  style: TextStyle(
                      fontSize: widthOrHeight0(context, 1) * 0.025,
                      color: Colors.grey),
                ),
              ),
              SizedBox(
                height: widthOrHeight0(context, 0) * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: widthOrHeight0(context, 1) * 0.45,
                    height: widthOrHeight0(context, 0) * 0.25,
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.ev_station,
                                      size: widthOrHeight0(context, 1) * 0.05),
                                  SizedBox(
                                    width: widthOrHeight0(context, 1) * 0.02,
                                  ),
                                  Text(AppLocale.station.getString(context),
                                      style: TextStyle(
                                          fontSize: widthOrHeight0(context, 1) *
                                              0.025,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Switch(
                                value: settingController.station,
                                onChanged: (value) {
                                  setState(() {
                                    settingController.station = value;
                                  });
                                },
                                activeTrackColor: Colors.blue,
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.home,
                                      size: widthOrHeight0(context, 1) * 0.05),
                                  SizedBox(
                                    width: widthOrHeight0(context, 1) * 0.02,
                                  ),
                                  Text(AppLocale.home.getString(context),
                                      style: TextStyle(
                                          fontSize: widthOrHeight0(context, 1) *
                                              0.025,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Switch(
                                value: settingController.home,
                                onChanged: (value) {
                                  setState(() {
                                    settingController.home = value;
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
                  style: TextStyle(
                      fontSize: widthOrHeight0(context, 1) * 0.025,
                      color: Colors.grey),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: widthOrHeight0(context, 0) * 0.05,
              ),
              Padding(
                padding: EdgeInsets.only(left: widthOrHeight0(context, 1) * 0.02,right: widthOrHeight0(context, 1) * 0.02),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'English',
                          style: TextStyle(
                              fontSize: widthOrHeight0(context, 1)*0.025, fontWeight: FontWeight.bold),
                        ),
                        Radio(
                          fillColor: settingController.selectedLanguage!
                                  .contains('en')
                              ? const MaterialStatePropertyAll(Color(0xff39b6fe))
                              : null,
                          value: 'en',
                          groupValue: settingController.selectedLanguage,
                          onChanged: (value) {
                            setState(() async {
                              SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();
                              settingController.selectedLanguage =
                                  value.toString();
                              settingController.localization.translate('en');
                              sharedPreferences.setString('lang', 'en');
                              appLang = 'en';
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('عربي',
                            style: TextStyle(
                                fontSize: widthOrHeight0(context, 1)*0.025, fontWeight: FontWeight.bold)),
                        Radio(
                          focusColor: const Color(0xff39b6fe),
                          fillColor: settingController.selectedLanguage!
                                  .contains('ar')
                              ? const MaterialStatePropertyAll(Color(0xff39b6fe))
                              : null,
                          activeColor: Colors.black,
                          value: 'ar',
                          groupValue: settingController.selectedLanguage,
                          onChanged: (value) {
                            setState(() async {
                              SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();
                              settingController.selectedLanguage =
                                  value.toString();
                              settingController.localization.translate('ar');
                              sharedPreferences.setString('lang', 'ar');
                              appLang = 'ar';
                            });
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
