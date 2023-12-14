import 'package:location/location.dart';

class LocationService {
  Future<LocationData> getLocation() async {
    Location location = Location();
    bool serviceEnable;
    PermissionStatus permissionStatus;
    LocationData locationData;

    serviceEnable = await location.serviceEnabled();
    if (!serviceEnable) {
      serviceEnable = await location.requestService();
      if (!serviceEnable) {
        throw Exception();
      }
    }

    permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        throw Exception();
      }
    }
    locationData = await location.getLocation();
    return locationData;
  }
}
