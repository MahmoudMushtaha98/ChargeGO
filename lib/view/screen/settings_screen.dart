import 'package:charge_go/config/translate_map.dart';
import 'package:charge_go/main.dart';
import 'package:charge_go/view/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widget/textformfield_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _controller = TextEditingController();

  final FlutterLocalization localization = FlutterLocalization.instance;
  String? selectedGender ;




  @override
  Widget build(BuildContext context) {
    selectedGender = appLang.contains('en')? appLang:'ar';
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: widthOrHeight0(context, 0) * 0.35,
            width: double.infinity,
            child: Column(
              children: [
                Expanded(
                  child: SvgPicture.asset('assets/svg/Screenshot (180).svg'),
                ),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                        text: AppLocale.log.getString(context),
                        style: TextStyle(
                            color: const Color(0xff39b6fe),
                            fontSize: widthOrHeight0(context, 1) * 0.05),
                        children: [
                          TextSpan(
                              text: (appLang.contains('ar')?' ${AppLocale.iin.getString(context)}':AppLocale.iin.getString(context)),
                              style: const TextStyle(color: Color(0xffa8a8a8)))
                        ]),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: widthOrHeight0(context, 0) * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextFormWidget(
                  obscureText: false,
                  passController: _controller,
                  hintText: 'Email',
                  width: widthOrHeight0(context, 1) * 0.4,
                  color: const Color(0xffa8a8a8),
                  iconSufData: Icons.email_outlined,
                ),
                TextFormWidget(
                  obscureText: true,
                  passController: _controller,
                  hintText: 'Password',
                  width: widthOrHeight0(context, 1) * 0.4,
                  color: const Color(0xffa8a8a8),
                  iconSufData: Icons.password,
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: widthOrHeight0(context, 0) * 0.06,
            width: widthOrHeight0(context, 1) * 0.25,
            decoration: const BoxDecoration(
                color: Color(0xff39b6fe),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Text(
              AppLocale.login.getString(context),
              style: TextStyle(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  fontSize: widthOrHeight0(context, 1) * 0.03,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: widthOrHeight0(context, 0)*0.1,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Radio(
                fillColor: selectedGender!.contains('en')
                    ? const MaterialStatePropertyAll(Color(0xff39b6fe))
                    : null,
                value: 'en',
                groupValue: selectedGender,
                onChanged: (value) {
                  setState(() async{
                    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                    selectedGender = value.toString();
                    localization.translate('en');
                    sharedPreferences.setString('lang', 'en');
                    appLang = 'en';
                  });
                },
              ),
              const Text(
                'English',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              Radio(
                focusColor: const Color(0xff39b6fe),
                fillColor: selectedGender!.contains('ar')
                    ? const MaterialStatePropertyAll(Color(0xff39b6fe))
                    : null,
                activeColor: Colors.black,
                value: 'ar',
                groupValue: selectedGender,
                onChanged: (value) {
                  setState(() async{
                    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                    selectedGender = value.toString();
                    localization.translate('ar');
                    sharedPreferences.setString('lang', 'ar');
                    appLang='ar';
                  });
                },
              ),
              const Text('عربي',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
            ],
          )
        ],
      ),
    );
  }
}
