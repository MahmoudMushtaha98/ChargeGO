import 'package:charge_go/config/translate_map.dart';
import 'package:charge_go/main.dart';
import 'package:charge_go/view/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/setting_controller.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  static const String routeScreen = '/SettingsScreen';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  SettingController settingController = SettingController();

  List<String> references = ['English', 'عربي'];
  bool display = false;

  @override
  Widget build(BuildContext context) {
    settingController.selectedLanguage =
        appLang.contains('en') ? appLang : 'ar';
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body: Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            width: double.infinity,
            height: widthOrHeight0(context, 0) * 0.3,
            decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.5),
                borderRadius: BorderRadius.only(
                    bottomLeft:
                        Radius.circular(widthOrHeight0(context, 1) * 0.1),
                    bottomRight:
                        Radius.circular(widthOrHeight0(context, 1) * 0.1))),
            child: Padding(
              padding: EdgeInsets.only(top: widthOrHeight0(context, 0) * 0.05),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.close,
                        color: Colors.black87,
                        size: widthOrHeight0(context, 1) * 0.05,
                      )),
                  Padding(
                    padding: EdgeInsets.only(
                        left: widthOrHeight0(context, 1) * 0.08),
                    child: Text(
                      'Settings',
                      style: TextStyle(
                          fontSize: widthOrHeight0(context, 1) * 0.05,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(
                width: double.infinity,
              ),
              Container(
                padding: EdgeInsets.only(
                    left: widthOrHeight0(context, 1) * 0.01,
                    right: widthOrHeight0(context, 1) * 0.01,
                    top: widthOrHeight0(context, 0) * 0.02),
                width: widthOrHeight0(context, 1) * 0.45,
                height: widthOrHeight0(context, 0) * 0.8,
                decoration: const BoxDecoration(
                    color: Color(0xffF5F5F5),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10))),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocale.filter.getString(context),
                          style: TextStyle(
                            fontSize: widthOrHeight0(context, 1) * 0.025,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff828181),
                          ),
                        ),
                        SizedBox(
                          height: widthOrHeight0(context, 0) * 0.01,
                        ),
                        Container(
                          width: double.infinity,
                          height: widthOrHeight0(context, 0) * 0.06,
                          decoration: const BoxDecoration(
                              color: Color(0xffFFFFFF),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(
                                width: widthOrHeight0(context, 1) * 0.3,
                                child: Row(
                                  children: [
                                    Icon(Icons.ev_station,
                                        size:
                                            widthOrHeight0(context, 1) * 0.05),
                                    SizedBox(
                                      width: widthOrHeight0(context, 1) * 0.02,
                                    ),
                                    Text(AppLocale.station.getString(context),
                                        style: TextStyle(
                                            fontSize:
                                                widthOrHeight0(context, 1) *
                                                    0.025,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
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
                        SizedBox(
                          height: widthOrHeight0(context, 0) * 0.015,
                        ),
                        Container(
                          width: double.infinity,
                          height: widthOrHeight0(context, 0) * 0.06,
                          decoration: const BoxDecoration(
                              color: Color(0xffFFFFFF),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(
                                width: widthOrHeight0(context, 1) * 0.3,
                                child: Row(
                                  children: [
                                    Icon(Icons.home,
                                        size:
                                            widthOrHeight0(context, 1) * 0.05),
                                    SizedBox(
                                      width: widthOrHeight0(context, 1) * 0.02,
                                    ),
                                    Text(AppLocale.home.getString(context),
                                        style: TextStyle(
                                            fontSize:
                                                widthOrHeight0(context, 1) *
                                                    0.025,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              Switch(
                                value: settingController.station,
                                onChanged: (value) {
                                  setState(() {
                                    settingController.home = value;
                                  });
                                },
                                activeTrackColor: Colors.blue,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: widthOrHeight0(context, 0) * 0.06,
                        ),
                        Text(
                          AppLocale.references.getString(context),
                          style: TextStyle(
                            fontSize: widthOrHeight0(context, 1) * 0.025,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff828181),
                          ),
                        ),
                        SizedBox(
                          height: widthOrHeight0(context, 0) * 0.01,
                        ),
                        Container(
                          width: double.infinity,
                          height: display?widthOrHeight0(context, 0) * 0.2:widthOrHeight0(context, 0) * 0.06,
                          decoration: const BoxDecoration(
                              color: Color(0xffFFFFFF),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left:
                                                widthOrHeight0(context, 1) * 0.015,
                                            right:
                                                widthOrHeight0(context, 1) * 0.01),
                                        child: Icon(Icons.language,
                                            size:
                                                widthOrHeight0(context, 1) * 0.05),
                                      ),
                                      Text(AppLocale.language.getString(context),
                                          style: TextStyle(
                                              fontSize: widthOrHeight0(context, 1) *
                                                  0.025,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  const SizedBox(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right:
                                                widthOrHeight0(context, 1) * 0.01),
                                        child: Text(
                                          settingController.selectedLanguage!.contains('en')?'English':'عربي',
                                          style: TextStyle(
                                              fontSize:
                                                  widthOrHeight0(context, 1) * 0.02,
                                              color: const Color(0xff908D8D),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              display = !display;
                                            });
                                          },
                                          icon: display?const Icon(Icons.keyboard_arrow_down): const Icon(Icons.arrow_forward_ios))
                                    ],
                                  )
                                ],
                              ),
                              if(display)...[
                                const Divider(),
                                GestureDetector(
                                  onTap: () {
                                    setState(() async {
                                      SharedPreferences sharedPreferences =
                                      await SharedPreferences.getInstance();
                                      settingController.selectedLanguage =
                                          'ar';
                                      settingController.localization
                                          .translate('ar');
                                      sharedPreferences.setString('lang', 'ar');
                                      appLang = 'ar';
                                      display = false;
                                    });
                                  },
                                  child: Text('عربي',style: TextStyle(
                                      fontSize: widthOrHeight0(context, 1) *
                                          0.025,
                                      fontWeight: FontWeight.bold)),
                                ),
                                const Divider(),
                                GestureDetector(
                                  onTap: () {
                                    setState(() async {
                                      display = false;
                                      SharedPreferences sharedPreferences =
                                      await SharedPreferences.getInstance();
                                      settingController.selectedLanguage =
                                          'en';
                                      settingController.localization
                                          .translate('en');
                                      sharedPreferences.setString('lang', 'en');
                                      appLang = 'en';
                                    });
                                  },
                                  child: Text('English',style: TextStyle(
                                      fontSize: widthOrHeight0(context, 1) *
                                          0.025,
                                      fontWeight: FontWeight.bold)),
                                )
                              ]
                            ],
                          ),
                        ),
                      ],
                    ),
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
