import 'dart:math';

import 'package:charge_go/main.dart';
import 'package:charge_go/model/station_model.dart';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../view/screen/charging_point_screen.dart';

class NearestStation {
  // final String apiKey = 'AIzaSyAWIUhxGIS4R0YoVevm1-XGs1kiqc5Ak_w';
  // final String baseURL =
  //     'https://maps.googleapis.com/maps/api/place/nearbysearch/json?';

  Dio dio = Dio();
  late List stationsData;

  List<StationsModel> stations = [];

  Future<List<StationsModel>> nearestStation(LatLng latLng) async {
    try {
      stations.clear();
      String url =
          'http://192.168.43.181:8080/git-distance?lat=${latLng.latitude}&lng=${latLng.longitude}';
      var response = await dio.get(url);
      stationsData = response.data;
      for (var element in stationsData) {
        stations.add(StationsModel(
            id: element['id'],
            type: element['type'],
            name: element['name'],
            open: true,
            latLng: LatLng(element['lat'], element['lng']),
            rate: element['rate'],
            chargeType: element['chargeType'],
            distance: calculateDistance(
                LatLng(locationData.latitude!, locationData.longitude!),
                LatLng(element['lat'], element['lng']))));
      }
    } catch (e) {
      print(e.toString());
    }
    stations.sort((a, b) => a.distance.compareTo(b.distance));
    return stations;
  }

  double earthRadius = 6371;

  double degreesToRadians(double degrees) {
    return degrees * pi / 180.0;
  }

  double calculateDistance(LatLng point1, LatLng point2) {
    double lat1 = degreesToRadians(point1.latitude);
    double lon1 = degreesToRadians(point1.longitude);
    double lat2 = degreesToRadians(point2.latitude);
    double lon2 = degreesToRadians(point2.longitude);

    double dLat = lat2 - lat1;
    double dLon = lon2 - lon1;

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1) * cos(lat2) * sin(dLon / 2) * sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double originalNumber = earthRadius * c;
    int decimalPlaces = 1;

    double roundedNumber = roundToDecimal(originalNumber, decimalPlaces);
    return roundedNumber;
  }

  double roundToDecimal(double number, int decimalPlaces) {
    return double.parse(number.toStringAsFixed(decimalPlaces));
  }
}
