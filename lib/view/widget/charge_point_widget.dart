import 'package:flutter/material.dart';
import '../screen/home_screen.dart';
import '../screen/splash_screen.dart';

class ChargingPointWidget extends StatelessWidget {
  final IconData icons;
  final String km;
  final String title;
  final String chargeStatus;
  final String evaluation;

  const ChargingPointWidget({
    super.key,
    required this.icons,
    required this.km,
    required this.title,
    required this.chargeStatus,
    required this.evaluation,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, HomeScreen.screenRoute);
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
                    icons,
                    size: widthOrHeight0(context, 1) * 0.05,
                    color: Colors.amber,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: widthOrHeight0(context, 1) * 0.13,
                    height: widthOrHeight0(context, 0)*0.04,
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
                          km,
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
                title,
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
                    chargeStatus,
                    style: TextStyle(
                        fontSize: widthOrHeight0(context, 1) * 0.024,
                    ),
                  ),
                  SizedBox(
                    width: widthOrHeight0(context, 1)*0.09,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.star_border_outlined,
                          size: widthOrHeight0(context, 1) * 0.03,
                        ),
                        Text(
                          evaluation,
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
