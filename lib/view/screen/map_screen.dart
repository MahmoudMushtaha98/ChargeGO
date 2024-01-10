import 'dart:async';
import 'package:charge_go/config/translate_map.dart';
import 'package:charge_go/controller/map_controller.dart';
import 'package:charge_go/model/station_model.dart';
import 'package:charge_go/view/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_search_advance/google_maps_place_search_advance.dart';
import 'package:location/location.dart';
import '../../main.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key, this.latLng}) : super(key: key);

  final LatLng? latLng;

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

  void polyLineFromChargePoint() async {
    if (widget.latLng != null) {
      PolylinePoints polylinePoints = PolylinePoints();
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          'AIzaSyAWIUhxGIS4R0YoVevm1-XGs1kiqc5Ak_w',
          PointLatLng(locationData.latitude!, locationData.longitude!),
          PointLatLng(widget.latLng!.latitude, widget.latLng!.longitude));
      if (mounted) {
        dest.clear();
        for (var element in result.points) {
          dest.add(LatLng(element.latitude, element.longitude));
        }
        setState(() {
          polyLine.clear();
          polyLine.add(
            Polyline(
                color: Colors.green,
                polylineId: const PolylineId('selected'),
                points: dest),
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            GoogleMap(
              initialCameraPosition: mapController.initialCameraPosition,
              zoomControlsEnabled: false,
              onMapCreated: (controller) async {
                polyLineFromChargePoint();
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
                            polyLine.add(
                              Polyline(
                                  color: Colors.green,
                                  polylineId: PolylineId('${element.id}'),
                                  points: dest),
                            );
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
              padding: EdgeInsets.only(top: widthOrHeight0(context, 0) * 0.05),
              child: SizedBox(
                width: widthOrHeight0(context, 1) * 0.45,
                child: GooglePlaceSearchAdvance(
                  googleMapsApiKey: "AIzaSyAWIUhxGIS4R0YoVevm1-XGs1kiqc5Ak_w",
                  country: "Jo",
                  onLocationSelected: (lat, lng, address, mainText) async {
                    setState(() {
                      mapController.marker.clear();
                      locationData =LocationData.fromMap({"latitude": lat, "longitude": lng});
                      mapController.marker.add(Marker(
                          markerId: const MarkerId('current location'),
                          icon: mapController.myLocationMarkerIcon,
                          position: LatLng(lat, lng)));
                    });

                    List<StationsModel> st = await mapController.nearestStation
                        .nearestStation(LatLng(lat, lng));
                    for (var element in st) {
                      setState(() {
                        mapController.marker.add(Marker(
                            markerId: MarkerId(element.id.toString()),
                            position: element.latLng,
                            icon: mapController.stationMarkerIcon));
                      });
                    }
                    mapController.animateCamera(LocationData.fromMap(
                        {"latitude": lat, "longitude": lng}));

                    // Marker(
                    //     markerId: const MarkerId('current location'),
                    //     position: LatLng(lat, lng),
                    //     icon: mapController.myLocationMarkerIcon);
                    // mapController.nearestStation.stations.clear();
                    // mapController.nearestStation.nearestStation(LatLng(lat, lng));
                  },
                  lightTheme: true,
                ),
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
