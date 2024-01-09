import 'package:google_maps_flutter/google_maps_flutter.dart';

class StationsModel {
  final int id;
  final String type;
  final String name;
  final bool open;
  final LatLng latLng;
  final double rate;
  final String chargeType;
  final double distance;

  StationsModel({
    required this.id,
    required this.type,
    required this.name,
    required this.open,
    required this.latLng,
    required this.rate,
    required this.chargeType,
    required this.distance,
  });
}
