import 'dart:async';
import 'package:charge_go/config/translate_map.dart';
import 'package:charge_go/controller/map_controller.dart';
import 'package:charge_go/model/station_model.dart';
import 'package:charge_go/view/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../main.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapController mapController = MapController(
    Completer<GoogleMapController>(),
    CameraPosition(
        target: LatLng(locationData.latitude!, locationData.longitude!),
        zoom: 15),
  );

  List<LatLng> dest = [];
  Set<Polyline> polyLine = <Polyline>{};

  @override
  void initState() {
    if (appLang.contains('ar')) {
      FlutterLocalization.instance.translate('ar');
    }
    mapController.addCustomMarker("assets/images/myLocation.png");
    mapController.addCustomMarker("assets/images/home-chtarge.webp");
    mapController.addCustomMarker("assets/images/station-charge.png");
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
                List<StationsModel> list = await mapController.nearestStation
                    .nearestStation(LatLng(
                        locationData.latitude!, locationData.longitude!));
                setState(() {
                  mapController.marker.add(
                    Marker(
                        markerId: const MarkerId('current location'),
                        position: LatLng(
                            locationData.latitude!, locationData.longitude!),
                        icon: mapController.myLocationMarkerIcon),
                  );
                });
                for (var element in list) {
                  setState(() {
                    mapController.marker.add(Marker(
                      markerId: MarkerId(
                        '${element.id}',
                      ),
                      position: element.latLng,
                      icon: mapController.stationMarkerIcon,
                      onTap: () async {
                        PolylinePoints polylinePoints = PolylinePoints();
                        PolylineResult result =
                            await polylinePoints.getRouteBetweenCoordinates(
                                'AIzaSyAWIUhxGIS4R0YoVevm1-XGs1kiqc5Ak_w',
                                PointLatLng(locationData.latitude!,
                                    locationData.longitude!),
                                PointLatLng(element.latLng.latitude,
                                    element.latLng.longitude));
                        if (mounted) {
                          dest.clear();
                          for (var element in result.points) {
                            dest.add(
                                LatLng(element.latitude, element.longitude));
                          }
                          setState(() {
                            polyLine.clear();
                            polyLine.add(Polyline(
                              color: Colors.green,
                                polylineId: PolylineId('${element.id}'),
                                points: dest),);
                          });
                        }
                      },
                    ));
                  });
                }
              },
              mapType: MapType.terrain,
              markers: mapController.marker,
              polylines: polyLine,
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
                            hintText:
                                AppLocale.searchLocation.getString(context),
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: IconButton(
                                onPressed: () async {
                                  // List<StationsModel> list =
                                  //     await nearestStation.nearestStation(
                                  //         LatLng(locationData.latitude!,
                                  //             locationData.longitude!));
                                  // Dio dio = Dio();
                                  // List chargeType = [
                                  //   'Tesla Supercharger CCS',
                                  //   'Tesla Supercharger Euro',
                                  //   'Type 3c',
                                  //   'Type 2',
                                  //   'Combo CCS EU',
                                  //   'Caravan plug'
                                  // ];
                                  // int counter = 0;
                                  // if(mounted){
                                  //   for (var element in list) {
                                  //     try {
                                  //       final response = await dio.post(
                                  //         'http://192.168.1.6:8080/insert-data',
                                  //         data: {
                                  //           'lat': element.latLng.latitude,
                                  //           'lng': element.latLng.longitude,
                                  //           'name': element.name,
                                  //           'type': 'Station',
                                  //           'chargeType': chargeType[counter],
                                  //           'rate': element.rate,
                                  //           'open': '7 AM - 12 PM'
                                  //         },
                                  //       );
                                  //
                                  //       print(response.data);
                                  //     } catch (e) {
                                  //       print(e);
                                  //     }
                                  //     if(mounted){
                                  //       if(counter == chargeType.length-1) {
                                  //         counter=0;
                                  //       } else {
                                  //         counter++;
                                  //       }
                                  //     }
                                  //   }
                                  // }
                                },
                                icon: const Icon(
                                  Icons.play_arrow_rounded,
                                  color: Colors.blue,
                                ))),
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
                      children: List.generate(
                          mapController.mapIcon(context).length, (index) {
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
            ),
          ],
        ),
      ),
    );
  }
}

enum ChargeType {
  type2,
  euDomestic,
  comboCcsEu,
  type3c,
}
