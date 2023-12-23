import 'package:google_maps_flutter/google_maps_flutter.dart';

class StationsModel{
  final String id;
  final String type;
  final String name;
  final bool open;
  final LatLng latLng;
  final String rate;

  StationsModel(
      {required this.id,
      required this.type,
      required this.name,
      required this.open,
      required this.latLng,
      required this.rate});
}