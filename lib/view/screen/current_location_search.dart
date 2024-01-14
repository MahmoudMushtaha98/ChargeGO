import 'package:charge_go/model/station_model.dart';
import 'package:charge_go/view/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_search_advance/google_maps_place_search_advance.dart';

class CurrentLocationSearch extends StatefulWidget {
  const CurrentLocationSearch({super.key, required this.startPoint});

  final ValueChanged<StationsModel> startPoint;

  @override
  State<CurrentLocationSearch> createState() => _CurrentLocationSearchState();
}

class _CurrentLocationSearchState extends State<CurrentLocationSearch> {


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: widthOrHeight0(context, 0) * 0.9,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          SizedBox(
            height: widthOrHeight0(context, 0) * 0.05,
          ),
          Container(
            width: widthOrHeight0(context, 1) * 0.45,
            decoration: BoxDecoration(
              color: Theme
                  .of(context)
                  .scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: GooglePlaceSearchAdvance(
              googleMapsApiKey: "AIzaSyAWIUhxGIS4R0YoVevm1-XGs1kiqc5Ak_w",
              country: "Jo",
              hintText: 'Your location',
              lightTheme: true,
              onLocationSelected: (lat, lng, address, mainText) {
                widget.startPoint(StationsModel(
                    id: null,
                    type: null,
                    name: address,
                    open: null,
                    latLng: LatLng(lat, lng),
                    rate: null,
                    chargeType: null,
                    distance: null));
                Navigator.pop(
                    context,
                    widget.startPoint
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
