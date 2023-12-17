import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'position_services.dart';

class RouteController{


  bool onTapCur = false;
  bool onTapWh = false;

  final TextEditingController controllerStart = TextEditingController();
  final TextEditingController controllerEnd = TextEditingController();
  Set<Marker> markers = <Marker>{};
  PositionServices positionServices = PositionServices();


}