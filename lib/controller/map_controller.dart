import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../config/location.dart';

class MapController{

  late final Completer<GoogleMapController> _controller ;
  // Completer<GoogleMapController>();

  late final CameraPosition _initialCameraPosition ;

  late final LatLng _currentLocation ;


  MapController(this._controller, this._initialCameraPosition, this._currentLocation);
// CameraPosition(target: LatLng(31.963158, 35.930359), zoom: 10);

  Completer<GoogleMapController> get controller => _controller;

  set controller(Completer<GoogleMapController> value) {
    _controller = value;
  }

  CameraPosition get initialCameraPosition => _initialCameraPosition;

  set initialCameraPosition(CameraPosition value) {
    _initialCameraPosition = value;
  }

  LatLng get currentLocation => _currentLocation;

  set currentLocation(LatLng value) {
    _currentLocation = value;
  }


  Future<void> getMyLocation() async {
    LocationData myLocation = await LocationService().getLocation();
    _animateCamera(myLocation);
  }

  Future<void> _animateCamera(LocationData locationData) async {
    final GoogleMapController controller = await _controller.future;
    CameraPosition cameraPosition = CameraPosition(
        target: LatLng(locationData.latitude!, locationData.longitude!),
        zoom: 17);
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }
// _initialCameraPosition.target



}