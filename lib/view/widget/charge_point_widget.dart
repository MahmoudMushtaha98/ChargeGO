import 'package:charge_go/model/station_model.dart';
import 'package:charge_go/view/screen/map_screen.dart';
import 'package:flutter/material.dart';
import '../screen/splash_screen.dart';

class ChargingPointWidget extends StatelessWidget {
  final StationsModel stationsModel;

  const ChargingPointWidget({Key? key,
    required this.stationsModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MapScreen(latLng: stationsModel.latLng),), (route) => false);
      },
      child: Container(
        width: widthOrHeight0(context, 1) * 0.45,
        height: widthOrHeight0(context, 0) * 0.25,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsets.only(
              left: widthOrHeight0(context, 1) * 0.02,
              right: widthOrHeight0(context, 1) * 0.02),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    stationsModel.type!.contains('Station')?Icons.ev_station:Icons.home,
                    size: widthOrHeight0(context, 1) * 0.05,
                    color: Colors.amber,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: widthOrHeight0(context, 1) * 0.13,
                    height: widthOrHeight0(context, 0) * 0.04,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(7))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Icon(
                          Icons.directions_outlined,
                          color: Colors.blue,
                        ),
                        Text(
                          '${stationsModel.distance} km',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: widthOrHeight0(context, 1) * 0.024,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Text(
                stationsModel.name!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: widthOrHeight0(context, 1) * 0.026,
                ),
              ),
              Text(
                'Open 24/7',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: widthOrHeight0(context, 1) * 0.026,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Charge Free',
                    style: TextStyle(
                      fontSize: widthOrHeight0(context, 1) * 0.024,
                    ),
                  ),
                  SizedBox(
                    width: widthOrHeight0(context, 1) * 0.09,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.star_border_outlined,
                          size: widthOrHeight0(context, 1) * 0.03,
                        ),
                        Text(
                          stationsModel.rate.toString(),
                          style: TextStyle(
                            fontSize: widthOrHeight0(context, 1) * 0.024,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
