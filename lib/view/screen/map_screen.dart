import 'dart:async';

import 'package:charge_go/config/location.dart';
import 'package:charge_go/config/translate_map.dart';
import 'package:charge_go/view/screen/charging_point_screen.dart';
import 'package:charge_go/view/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../../main.dart';
import '../widget/map_icon_widget.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  static const CameraPosition _initialCameraPosition =
  CameraPosition(target: LatLng(31.963158, 35.930359), zoom: 10);
  LatLng currentLocation = _initialCameraPosition.target;

  @override
  void initState() {
    if (appLang.contains('ar')) {
      FlutterLocalization.instance.translate('ar');
    }
    super.initState();
  }

  String fil = 'Filter';

  @override
  Widget build(BuildContext context) {
    List<MapIconWidget> mapIcon = [
      MapIconWidget(
        iconData: Icons.gps_fixed,
        callback: () {
          getMyLocation();
        },
      ),
      MapIconWidget(
        iconData: Icons.list,
        callback: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ChargingPointScreen(),
              ));
        },
      ),
    ];
    return Scaffold(

      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: _initialCameraPosition,
              onMapCreated: (controller) => _controller.complete(controller),
              onCameraMove: (position) {
                setState(() {
                  currentLocation = position.target;
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
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow:  [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            spreadRadius: 0.3,
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ]
                      ),
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
                  SizedBox(
                    width: widthOrHeight0(context, 1) * 0.02,
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        height: widthOrHeight0(context, 1) * 0.07,
                        decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            boxShadow:  [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.4),
                                spreadRadius: 0.3,
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                            border: Border.all(color: Colors.grey)),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: widthOrHeight0(context, 1) * 0.03,
                              right: widthOrHeight0(context, 1) * 0.01),
                          child: DropdownButton<String>(
                            underline: Container(
                              color: Colors.white,
                            ),
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold,
                                fontSize: widthOrHeight0(context, 1) * 0.0164),
                            isExpanded: true,
                            value: fil,
                            onChanged: (String? newValue) {
                              setState(() {
                                fil = newValue!;
                              });
                            },
                            items: <String>['Filter', 'Station', 'Home']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      )),
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
                SizedBox(
                  width: double.infinity,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> getMyLocation() async {
    LocationData myLocation = await LocationService().getLocation();
    _animateCamera(myLocation);
  }

  Future<void> _animateCamera(LocationData locationData) async {
    final GoogleMapController controller = await _controller.future;
    CameraPosition cameraPosition = CameraPosition(
        target: LatLng(locationData.latitude!, locationData.longitude!),
      zoom: 17
    );
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

  }
}
