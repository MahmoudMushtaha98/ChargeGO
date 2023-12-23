import 'package:charge_go/main.dart';
import 'package:charge_go/model/station_model.dart';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NearestStation {
  final String apiKey = 'AIzaSyAWIUhxGIS4R0YoVevm1-XGs1kiqc5Ak_w';
  final String baseURL =
      'https://maps.googleapis.com/maps/api/place/nearbysearch/json?';

  Dio dio = Dio();
  late List stationsData;

  List<StationsModel> stations = [];

  Future<List<StationsModel>> nearestStation(LatLng latLng) async {
    String url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?'
        'keyword=gas_station'
        '&location=31.963158%2C35.930359&'
        'radius=5000'
        '&type=gas_station'
        '&key=AIzaSyAWIUhxGIS4R0YoVevm1-XGs1kiqc5Ak_w';
    var response = await dio.get(url);
    stationsData = response.data['results'];
    print('=====================$stationsData');
    for (var element in stationsData) {
      stations.add(StationsModel(
          id: element['place_id'].toString(),
          type: element['types'][0].toString(),
          name: element['name'].toString(),
          open: (element['opening_hours'].toString().contains('null'))?true:element['opening_hours']['open_now']??true,
          latLng: LatLng(element['geometry']['location']['lat'],element['geometry']['location']['lng']),
          rate: element['rating'].toString()));
    }

    return stations;
  }
}
