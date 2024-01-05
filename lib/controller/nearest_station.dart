import 'package:charge_go/model/station_model.dart';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NearestStation {
  // final String apiKey = 'AIzaSyAWIUhxGIS4R0YoVevm1-XGs1kiqc5Ak_w';
  // final String baseURL =
  //     'https://maps.googleapis.com/maps/api/place/nearbysearch/json?';

  Dio dio = Dio();
  late List stationsData;

  List<StationsModel> stations = [];

  Future<List<StationsModel>> nearestStation(LatLng latLng) async {
    try{
      stations.clear();
      String url ='http://192.168.1.6:8080/git-distance?lat=${latLng.latitude}&lng=${latLng.longitude}';
      var response = await dio.get(url);
      stationsData = response.data;
      for (var element in stationsData) {
        stations.add(StationsModel(
            id: element['id'],
            type: element['type'],
            name: element['name'],
            open: true,
            latLng: LatLng(element['lat'],element['lng']),
            rate: element['rate'],
            chargeType: element['chargeType']));

      }
    }catch(e){
      print(e.toString());
    }
    return stations;
  }
}
