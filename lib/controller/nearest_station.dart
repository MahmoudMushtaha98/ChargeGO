import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NearestStation {
  final String apiKey = 'AIzaSyAWIUhxGIS4R0YoVevm1-XGs1kiqc5Ak_w';
  final String baseURL =
      'https://maps.googleapis.com/maps/api/place/nearbysearch/json?';



  Dio dio = Dio();

  Future<Map<String, dynamic>> nearestStation(LatLng latLng) async {
    const String url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?'
        'keyword=gas_station'
        '&location=31.9539494%2C35.910635'
        '&radius=5000'
        '&type=gas_station'
        '&key=AIzaSyAWIUhxGIS4R0YoVevm1-XGs1kiqc5Ak_w';
    var response = await dio.get(url);
    print(response.data['results']);
    return response.data;
  }
}
