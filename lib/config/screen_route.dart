import 'package:flutter/material.dart';

import '../view/screen/charging_point_screen.dart';
import '../view/screen/settings_screen.dart';

Map<String, WidgetBuilder> routes() {
  return {
    ChargingPointScreen.routeScreen: (context) => const ChargingPointScreen(),
    SettingsScreen.routeScreen: (context) => const SettingsScreen()
  };
}
