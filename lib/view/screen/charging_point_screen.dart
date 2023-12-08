

import 'package:charge_go/config/translate_map.dart';
import 'package:charge_go/view/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import 'home_screen.dart';

class ChargingPointScreen extends StatefulWidget {
  const ChargingPointScreen({super.key});

  @override
  State<ChargingPointScreen> createState() => _ChargingPointScreenState();
}

class _ChargingPointScreenState extends State<ChargingPointScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon:
        const Icon(
          Icons.close,
          size: 40,
        ),),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
            Padding(

             padding:  const EdgeInsets.only(top:40.0),
             child: Text(AppLocale.nearCharge.getString(context),
             style: const TextStyle(
               fontWeight: FontWeight.bold,
               fontSize: 30
             ),
             ),
           ),

          ChargingPointWidget(icons: Icons.ev_station,km: '1.6km',title:'Total Station',chargeStatus:AppLocale.chargeType.getString(context),evaluation: '4/5', ),
        ],
      ),
    );
  }
}

class ChargingPointWidget extends StatelessWidget {
  final IconData icons;
  final String km;
  final String title;
  final String chargeStatus;
  final String evaluation;

  const ChargingPointWidget({super.key,
    required this.icons,
    required this.km,
    required this.title,
    required this.chargeStatus,
    required this.evaluation,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: Colors.black)
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(icons,
                      size: 40,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue)
                        ),
                        child: Padding(
                          padding:const EdgeInsets.all(5.0),
                          child: Text(km,
                            style:const TextStyle(
                              color:  Colors.blue,
                              fontSize: 20
                            ),
                          ),
                        ),
                      ),
                    ),

                ],
              ),
              const SizedBox(
                height: 20,
              ),
               Padding(
                padding:const EdgeInsets.only(left: 10.0),
                child: Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(chargeStatus,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: widthOrHeight0(context, 1)*0.03,
                        color: Colors.green
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.star_border_outlined,
                          size: 40,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(evaluation,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
    ),
      ),
    );
  }
}
