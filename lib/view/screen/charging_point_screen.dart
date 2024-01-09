import 'package:charge_go/config/translate_map.dart';
import 'package:charge_go/view/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import '../../model/station_model.dart';
import '../widget/charge_point_widget.dart';

class ChargingPointScreen extends StatefulWidget {
  const ChargingPointScreen({Key? key}) : super(key: key);

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
                      stationsModel: station[index],
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

}
