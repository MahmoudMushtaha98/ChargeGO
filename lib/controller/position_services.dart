import 'package:dio/dio.dart';

class PositionServices {
  final String apiKey = 'AIzaSyAWIUhxGIS4R0YoVevm1-XGs1kiqc5Ak_w';
  final String baseURL =
      'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?fields=formatted_address%2Cname%2Crating%2Copening_hours%2Cgeometry';


  Dio dio = Dio();
  Future<Map<String,dynamic>> getPlaceId(String place) async {
    final String url = '$baseURL&input=$place%Amman%Jordan&inputtype=textquery&key=$apiKey';
    var response = await dio.get(url);
    return response.data['candidates'][0];
  }
}
