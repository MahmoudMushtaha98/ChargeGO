import 'dart:async';
import 'dart:collection';
import 'package:charge_go/controller/nearest_station.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../config/location.dart';
import '../view/screen/charging_point_screen.dart';
import '../view/screen/settings_screen.dart';
import '../view/widget/map_icon_widget.dart';

class MapController {
  late final Completer<GoogleMapController> _controller;

  late final CameraPosition _initialCameraPosition;

  late LatLng currentLocation;

  HashSet<Marker> marker = HashSet<Marker>();

  NearestStation nearestStation = NearestStation();

  BitmapDescriptor myLocationMarkerIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor homeMarkerIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor stationMarkerIcon = BitmapDescriptor.defaultMarker;

  MapController(
    this._controller,
    this._initialCameraPosition,
  );

  Completer<GoogleMapController> get controller => _controller;

  set controller(Completer<GoogleMapController> value) {
    _controller = value;
  }

  CameraPosition get initialCameraPosition => _initialCameraPosition;

  set initialCameraPosition(CameraPosition value) {
    _initialCameraPosition = value;
  }

  Future<void> getMyLocation() async {
    LocationData myLocation = await LocationService().getLocation();
    animateCamera(myLocation);
  }

  Future<void> animateCamera(LocationData locationData) async {
    final GoogleMapController controller = await _controller.future;
    CameraPosition cameraPosition = CameraPosition(
        target: LatLng(locationData.latitude!, locationData.longitude!),
        zoom: 17);
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition,));
  }

  List mapIcon(BuildContext context) {
    return [
      MapIconWidget(
        iconData: Icons.gps_fixed,
        callback: () {
          getMyLocation();
        },
      ),
      MapIconWidget(
        iconData: Icons.list,
        callback: () async {
          Navigator.pushNamed(
            context,
            ChargingPointScreen.routeScreen,
            arguments: {'stations': nearestStation.stations},
          );
        },
      ),
      MapIconWidget(
        iconData: Icons.settings,
        callback: () {
          Navigator.pushNamed(context, SettingsScreen.routeScreen);
        },
      )
    ];
  }

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
