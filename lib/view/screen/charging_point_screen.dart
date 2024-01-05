import 'dart:math';

import 'package:charge_go/config/translate_map.dart';
import 'package:charge_go/main.dart';
import 'package:charge_go/view/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../model/station_model.dart';
import '../widget/charge_point_widget.dart';

class ChargingPointScreen extends StatefulWidget {
  const ChargingPointScreen({super.key});

  static const String routeScreen = '/ChargingPointScreen';

  @override
  State<ChargingPointScreen> createState() => _ChargingPointScreenState();
}

class _ChargingPointScreenState extends State<ChargingPointScreen> {
  List<StationsModel> station = [];

  @override
  void didChangeDependencies() {
    Map argumentRoute = ModalRoute.of(context)!.settings.arguments as Map;
    setState(() {
      station = argumentRoute['stations'];
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.close,
            size: 40,
          ),
        ),
        title: Text(
          AppLocale.nearCharge.getString(context),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: widthOrHeight0(context, 0) -
                widthOrHeight0(context, 0) * 0.09489,
            child: ListView.builder(
              itemCount: station.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ChargingPointWidget(
                      icons: Icons.ev_station,
                      km: '${calculateDistance(LatLng(locationData.latitude!, locationData.longitude!), station[index].latLng)} km',
                      title: station[index].name,
                      chargeStatus: AppLocale.chargeType.getString(context),
                      evaluation: station[index].rate.toString(),
                    ),
                    SizedBox(
                      height: widthOrHeight0(context, 0) * 0.03,
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  final double earthRadius = 6371;

  double degreesToRadians(double degrees) {
    return degrees * pi / 180.0;
  }

  double calculateDistance(LatLng point1, LatLng point2) {
    double lat1 = degreesToRadians(point1.latitude);
    double lon1 = degreesToRadians(point1.longitude);
    double lat2 = degreesToRadians(point2.latitude);
    double lon2 = degreesToRadians(point2.longitude);

    double dLat = lat2 - lat1;
    double dLon = lon2 - lon1;

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1) * cos(lat2) * sin(dLon / 2) * sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double originalNumber = earthRadius * c;
    int decimalPlaces = 1;

    double roundedNumber = roundToDecimal(originalNumber, decimalPlaces);
    return roundedNumber;
  }

  double roundToDecimal(double number, int decimalPlaces) {
    return double.parse(number.toStringAsFixed(decimalPlaces));
  }
}
