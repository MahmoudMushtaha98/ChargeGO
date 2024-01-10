import 'package:charge_go/controller/nearest_station.dart';
import 'package:charge_go/main.dart';
import 'package:charge_go/model/station_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'position_services.dart';

class RouteController{


  bool onTapCur = false;
  bool onTapWh = false;

  NearestStation nearestStation = NearestStation();

  final TextEditingController controllerStart = TextEditingController();
  final TextEditingController controllerEnd = TextEditingController();
  Set<Marker> markers = <Marker>{};
  PositionServices positionServices = PositionServices();

  PolylinePoints polylinePoints = PolylinePoints();
  CameraPosition iniCameraPosition =
  CameraPosition(target: LatLng(locationData.latitude!, locationData.longitude!), zoom: 15);

  Set<Polyline> polyLine = <Polyline>{};
  List<LatLng> latLong = [];



  BitmapDescriptor myLocationMarkerIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor homeMarkerIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor stationMarkerIcon = BitmapDescriptor.defaultMarker;

  void addCustomMarker(String path) {
    ImageConfiguration configuration =
    const ImageConfiguration(size: Size(100, 100));
    BitmapDescriptor.fromAssetImage(configuration, path).then((icon) {
      if (path.contains("assets/images/myLocation.png")) {
        myLocationMarkerIcon = icon;
      } else if (path.contains("assets/images/home-chtarge.webp")) {
        homeMarkerIcon = icon;
      } else {
        stationMarkerIcon = icon;
      }
    });
  }
}