import 'package:charge_go/config/translate_map.dart';
import 'package:charge_go/view/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import '../widget/charge_point_widget.dart';

class ChargingPointScreen extends StatefulWidget {
  const ChargingPointScreen({super.key});

  static const String routeScreen = '/ChargingPointScreen';

  @override
  State<ChargingPointScreen> createState() => _ChargingPointScreenState();
}

class _ChargingPointScreenState extends State<ChargingPointScreen> {
  @override
  Widget build(BuildContext context) {
    List<ChargingPointWidget> chargePoint = [
      ChargingPointWidget(
        icons: Icons.ev_station,
        km: '1.6 km',
        title: 'Total Station',
        chargeStatus: AppLocale.chargeType.getString(context),
        evaluation: '4/5',
      ),
      ChargingPointWidget(
        icons: Icons.ev_station,
        km: '2.1 km',
        title: 'Al-Manaseer Station',
        chargeStatus: AppLocale.chargeType.getString(context),
        evaluation: '4.3/5',
      ),
    ];
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
            height: widthOrHeight0(context, 0)-widthOrHeight0(context, 0)*0.09489,
            child: ListView.builder(
              itemCount: chargePoint.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    chargePoint[index],
                    SizedBox(height: widthOrHeight0(context, 0)*0.03,)
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
