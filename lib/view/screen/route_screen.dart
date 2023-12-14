import 'package:charge_go/view/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteScreen extends StatefulWidget {
  const RouteScreen({super.key});

  @override
  State<RouteScreen> createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(31.963158, 35.930359), zoom: 10),
              zoomControlsEnabled: false,
            ),
            Container(
              width: double.infinity,
              height: widthOrHeight0(context, 0) * 0.2,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    spreadRadius: 0.5,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.circle,
                            color: Colors.blue,
                            size: widthOrHeight0(context, 1) * 0.02,
                          ),
                          Container(
                            width: widthOrHeight0(context, 1) * 0.003,
                            height: widthOrHeight0(context, 0) * 0.04,
                            color: Colors.grey,
                          ),
                          Icon(Icons.circle_outlined,
                              color: Colors.blue,
                              size: widthOrHeight0(context, 1) * 0.02)
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                'Current Location',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize:
                                        widthOrHeight0(context, 1) * 0.025),
                              ),
                            ),
                          ),
                          const Divider(),
                          Expanded(
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Where to?',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize:
                                        widthOrHeight0(context, 1) * 0.025),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
