import 'dart:async';
import 'package:charge_go/config/translate_map.dart';
import 'package:charge_go/controller/map_controller.dart';
import 'package:charge_go/view/screen/charging_point_screen.dart';
import 'package:charge_go/view/screen/settings_screen.dart';
import 'package:charge_go/view/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../main.dart';
import '../widget/map_icon_widget.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {


  MapController mapController = MapController(Completer<GoogleMapController>(),
      const CameraPosition(target: LatLng(31.963158, 35.930359), zoom: 10),
      const LatLng(31.963158, 35.930359));



  @override
  void initState() {
    if (appLang.contains('ar')) {
      FlutterLocalization.instance.translate('ar');
    }
    mapController.getMyLocation();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    List<MapIconWidget> mapIcon = [
      MapIconWidget(
        iconData: Icons.gps_fixed,
        callback: () {
          mapController.getMyLocation();
        },
      ),
      MapIconWidget(
        iconData: Icons.list,
        callback: () {
          Navigator.pushNamed(context, ChargingPointScreen.routeScreen);
        },
      ),
      MapIconWidget(
        iconData: Icons.settings,
        callback: () {
          Navigator.pushNamed(context, SettingsScreen.routeScreen);
        },
      )
    ];
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: mapController.initialCameraPosition,
              onMapCreated: (controller) => mapController.controller.complete(controller),
              onCameraMove: (position) {
                setState(() {
                  mapController.currentLocation = position.target;
                });
              },
              mapType: MapType.normal,
              zoomControlsEnabled: false,
            ),
            Padding(
              padding: EdgeInsets.all(widthOrHeight0(context, 1) * 0.04),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: widthOrHeight0(context, 1) * 0.07,
                      decoration: BoxDecoration(
                          color: Theme
                              .of(context)
                              .scaffoldBackgroundColor,
                          borderRadius:
                          const BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              spreadRadius: 0.3,
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ]),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                          hintText: AppLocale.searchLocation.getString(context),
                          prefixIcon: const Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(
                      width: double.infinity,
                    ),
                    Column(
                      children: List.generate(mapIcon.length, (index) {
                        return Column(
                          children: [
                            mapIcon[index],
                            (index == 0)
                                ? SizedBox(
                              height: widthOrHeight0(context, 0) * 0.05,
                            )
                                : SizedBox(
                              height: widthOrHeight0(context, 0) * 0.01,
                            )
                          ],
                        );
                      }),
                    ),
                    SizedBox(
                      height: widthOrHeight0(context, 0) * 0.13,
                    )
                  ],
                ),
                const SizedBox(
                  width: double.infinity,
                )
              ],
            )
          ],
        ),
      ),
    );
  }


}
