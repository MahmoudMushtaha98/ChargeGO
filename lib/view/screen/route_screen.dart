import 'package:charge_go/config/translate_map.dart';
import 'package:charge_go/controller/route_controller.dart';
import 'package:charge_go/main.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          routeController.latLong.clear();
          routeController.polyLine.clear();
          routeController.markers.clear();
          Map<String, dynamic> details = await routeController.positionServices
              .getPlaceId(routeController.controllerEnd.text);
          PolylineResult result = await routeController.polylinePoints
              .getRouteBetweenCoordinates(
                  'AIzaSyAWIUhxGIS4R0YoVevm1-XGs1kiqc5Ak_w',
                  PointLatLng(locationData.latitude!, locationData.longitude!),
                  PointLatLng(details['geometry']['location']['lat'],
                      details['geometry']['location']['lng']));
          for (var element in result.points) {
            routeController.latLong
                .add(LatLng(element.latitude, element.longitude));
          }

          setState(() {
            routeController.markers.add(Marker(
                markerId: const MarkerId('Start'),
                position:
                    LatLng(locationData.latitude!, locationData.longitude!),
                icon: routeController.myLocationMarkerIcon));
            routeController.markers.add(Marker(
                markerId: const MarkerId('End'),
                position: routeController.latLong.last));
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
              stations.forEach((element) {
                routeController.markers.add(Marker(
                    markerId: MarkerId(element.id.toString()),
                    position: element.latLng,icon: routeController.stationMarkerIcon));
              });
              stations.clear();
              setState(() {

              });
            }
          });
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
                            locationData.latitude!, locationData.longitude!),
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
                            child: Container(
                              alignment: Alignment.bottomLeft,
                              child: TextFormField(
                                controller: routeController.controllerStart,
                                onTap: () {
                                  setState(() {
                                    routeController.onTapCur = true;
                                  });
                                },
                                decoration: InputDecoration(
                                  label: routeController.onTapCur
                                      ? null
                                      : Text(
                                          AppLocale.myLocation
                                              .getString(context),
                                          style: TextStyle(
                                              fontSize:
                                                  widthOrHeight0(context, 1) *
                                                      0.027),
                                        ),
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue)),
                                ),
                              ),
                            ),
                          ),
                          const Divider(),
                          Expanded(
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: TextFormField(
                                controller: routeController.controllerEnd,
                                onTap: () {
                                  setState(() {
                                    routeController.onTapWh = true;
                                  });
                                },
                                decoration: InputDecoration(
                                    label: routeController.onTapWh
                                        ? null
                                        : Text(
                                            AppLocale.location
                                                .getString(context),
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize:
                                                    widthOrHeight0(context, 1) *
                                                        0.025),
                                          ),
                                    focusedBorder: InputBorder.none,
                                    border: InputBorder.none),
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
// Future<void> _goToPlace(LatLng latLng)async{
//   final GoogleMapController controller = await routeController.
// }
}
