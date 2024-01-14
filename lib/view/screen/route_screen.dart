import 'package:charge_go/config/translate_map.dart';
import 'package:charge_go/controller/route_controller.dart';
import 'package:charge_go/main.dart';
import 'package:charge_go/view/screen/current_location_search.dart';
import 'package:charge_go/view/screen/end_point_screen.dart';
import 'package:charge_go/view/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../model/station_model.dart';

class RouteScreen extends StatefulWidget {
  const RouteScreen({Key? key}) : super(key: key);

  @override
  State<RouteScreen> createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {
  RouteController routeController = RouteController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          routeController.latLong.clear();
          routeController.polyLine.clear();
          routeController.markers.clear();
          if (routeController.endPoint != null) {
            Map<String, dynamic> details = await routeController
                .positionServices
                .getPlaceId(routeController.controllerEnd.text);
            PolylineResult result = await routeController.polylinePoints
                .getRouteBetweenCoordinates(
                    'AIzaSyAWIUhxGIS4R0YoVevm1-XGs1kiqc5Ak_w',
                    PointLatLng(routeController.startPoint!.latLng!.latitude,
                        routeController.startPoint!.latLng!.longitude),
                    PointLatLng(details['geometry']['location']['lat'],
                        details['geometry']['location']['lng']));
            for (var element in result.points) {
              routeController.latLong
                  .add(LatLng(element.latitude, element.longitude));
            }

            setState(() {
              routeController.markers.add(Marker(
                  markerId: const MarkerId('Start'),
                  position: LatLng(routeController.startPoint!.latLng!.latitude,
                      routeController.startPoint!.latLng!.longitude),
                  icon: routeController.myLocationMarkerIcon));
              routeController.markers.add(Marker(
                  markerId: const MarkerId('End'),
                  position: LatLng(routeController.endPoint!.latLng!.latitude,
                      routeController.endPoint!.latLng!.longitude)));
              routeController.polyLine.add(Polyline(
                  polylineId: PolylineId(
                    '${routeController.polyLine.length + 1}',
                  ),
                  points: routeController.latLong,
                  color: Colors.blue));
            });
            List<StationsModel> stations = [];
            routeController.latLong.forEach((element) async {
              stations =
                  await routeController.nearestStation.nearestStation(element);
              if (mounted) {
                for (var element in stations) {
                  routeController.markers.add(Marker(
                      markerId: MarkerId(element.id.toString()),
                      position: element.latLng!,
                      icon: routeController.stationMarkerIcon));
                }
                stations.clear();
                setState(() {});
              }
            });
          } else {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Enter end point'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('OK'))
                    ],
                  );
                });
          }
        },
        child: const Text(
          'Go',
          style: TextStyle(color: Colors.blue),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              onMapCreated: (controller) {
                setState(() {
                  routeController.markers.add(
                    Marker(
                        markerId: const MarkerId('current location'),
                        position: LatLng(
                            routeController.startPoint!.latLng!.latitude,
                            routeController.startPoint!.latLng!.longitude),
                        icon: routeController.myLocationMarkerIcon),
                  );
                });
              },
              markers: routeController.markers,
              initialCameraPosition: routeController.iniCameraPosition,
              zoomControlsEnabled: false,
              polylines: routeController.polyLine,
              mapType: MapType.terrain,
            ),
            Container(
              width: double.infinity,
              height: widthOrHeight0(context, 0) * 0.2,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    spreadRadius: 0.5,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.circle,
                            color: Colors.blue,
                            size: widthOrHeight0(context, 1) * 0.02,
                          ),
                          Container(
                            width: widthOrHeight0(context, 1) * 0.003,
                            height: widthOrHeight0(context, 0) * 0.04,
                            color: Colors.grey,
                          ),
                          Icon(Icons.circle_outlined,
                              color: Colors.blue,
                              size: widthOrHeight0(context, 1) * 0.02)
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                await showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) {
                                      return CurrentLocationSearch(
                                        startPoint: addStartPoint,
                                      );
                                    });
                              },
                              child: Container(

                                  alignment: appLang.contains('ar')?Alignment.bottomRight:Alignment.bottomLeft,
                                  child: Text(
                                    appLang.contains('ar') && routeController.startPoint?.id==0
                                        ? AppLocale.currentLocation.getString(context)
                                        : routeController.startPoint!.name!,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize:
                                            widthOrHeight0(context, 0) * 0.025,
                                        overflow: TextOverflow.ellipsis),
                                  )),
                            ),
                          ),
                          const Divider(),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                await showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) {
                                      return EndPointScreen(
                                        endPoint: addEndPoint,
                                      );
                                    });
                              },
                              child: Container(
                                alignment: appLang.contains('ar')?Alignment.topRight:Alignment.topLeft,
                                child: Text(
                                  routeController.endPoint?.name ??
                                      AppLocale.whereYouGo.getString(context),
                                  maxLines: 1,
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize:
                                        widthOrHeight0(context, 0) * 0.025,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addMarker(LatLng argument) {
    setState(() {
      routeController.markers.add(Marker(
          markerId: MarkerId('marker ${routeController.markers.length + 1}'),
          position: LatLng(argument.latitude, argument.longitude),
          infoWindow: InfoWindow(
              title: 'Position ${routeController.markers.length + 1}',
              snippet:
                  'latitude: ${argument.latitude}, longitude: ${argument.longitude}')));
    });
  }

  void addStartPoint(StationsModel startPoint) async {
    //startPoint.latLng!.latitude,startPoint.latLng!.longitude
    setState(() {
      routeController.startPoint = startPoint;
    });
  }

  void addEndPoint(StationsModel endPoint) {
    setState(() {
      routeController.endPoint = endPoint;
    });
  }

  @override
  void initState() {
    routeController.addCustomMarker('assets/images/myLocation.png');
    super.initState();
  }

  @override
  void dispose() {
    routeController.controllerStart.dispose();
    routeController.controllerEnd.dispose();
    super.dispose();
  }
}
