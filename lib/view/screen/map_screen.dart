import 'dart:async';
import 'dart:convert';
import 'package:charge_go/config/location.dart';
import 'package:charge_go/config/translate_map.dart';
import 'package:charge_go/controller/map_controller.dart';
import 'package:charge_go/controller/nearest_station.dart';
import 'package:charge_go/view/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../../main.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapController mapController = MapController(
      Completer<GoogleMapController>(),
       CameraPosition(target: LatLng(locationData.latitude!, locationData.longitude!), zoom: 15),
      );

  @override
  void initState() {
    if (appLang.contains('ar')) {
      FlutterLocalization.instance.translate('ar');
    }
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: mapController.initialCameraPosition,
              onMapCreated: (controller) async {
                mapController.controller.complete(controller);
               setState(() {
                 mapController.marker.add(Marker(
                     markerId: const MarkerId('1'),
                     position: LatLng(locationData.latitude!,locationData.longitude!)),);
               });
              },
              mapType: MapType.hybrid,
              zoomControlsEnabled: false,
              markers: mapController.marker,
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
                          suffixIcon: IconButton(onPressed: () {
                            NearestStation neare = NearestStation();
                            // neare.nearestStation(LatLng(, mapController.myLocation.longitude!,));
                          }, icon: const Icon(Icons.play_arrow_rounded,color: Colors.blue,))
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
                      children: List.generate(mapController.mapIcon(context).length, (index) {
                        return Column(
                          children: [
                            mapController.mapIcon(context)[index],
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
