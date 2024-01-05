import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'position_services.dart';

class RouteController{


  bool onTapCur = false;
  bool onTapWh = false;

  final TextEditingController controllerStart = TextEditingController();
  final TextEditingController controllerEnd = TextEditingController();
  Set<Marker> markers = <Marker>{};
  PositionServices positionServices = PositionServices();

  PolylinePoints polylinePoints = PolylinePoints();
  CameraPosition iniCameraPosition =
  const CameraPosition(target: LatLng(31.963158, 35.930359), zoom: 15);

  Set<Polyline> polyLine = <Polyline>{};
  List<LatLng> latLong = [];

}