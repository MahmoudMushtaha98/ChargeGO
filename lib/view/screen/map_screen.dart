
import 'package:charge_go/view/screen/charging_point_screen.dart';
import 'package:charge_go/view/screen/splash_screen.dart';
import 'package:flutter/material.dart';

import '../widget/map_icon_widget.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String fil ='Filter';







  @override
  Widget build(BuildContext context) {
    List<MapIconWidget> mapIcon = [
      MapIconWidget( iconData: Icons.my_location,callback: () {
      },),
      MapIconWidget( iconData: Icons.list,callback: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ChargingPointScreen(),));
      },),
      MapIconWidget( iconData: Icons.grade,callback: () {

      },),
    ];
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image.network(
                'https://www.wikihow.com/images/thumb/6/63/Get-Current-Location-on-Google-Maps-Step-2-Version-6.jpg/v4-460px-Get-Current-Location-on-Google-Maps-Step-2-Version-6.jpg.webp'),
            Padding(
              padding: EdgeInsets.all(widthOrHeight0(context, 1) * 0.04),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: widthOrHeight0(context, 1) * 0.07,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(

                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          hintText: 'Search a location',
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: widthOrHeight0(context, 1) * 0.02,
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(

                          padding:
                          EdgeInsets.symmetric(horizontal: widthOrHeight0(context, 1) * 0.01),
                          height: widthOrHeight0(context, 1) * 0.07,
                          decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              border: Border.all(color: Colors.grey)),
                          child:  Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: DropdownButton<String>(
                              underline: Container(
                                color: Colors.white,
                              ),
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: widthOrHeight0(context, 1)*0.0164
                              ),
                              isExpanded: true,
                              value: fil,
                              onChanged: (String? newValue) {
                                setState(() {
                                  fil = newValue!;
                                });
                              },
                              items: <String>['Filter', 'Station', 'Home']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),

                      )),
                ],
              ),
            ),
             Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
               Column(
                 crossAxisAlignment: CrossAxisAlignment.end,
                 children: [
                   const SizedBox(width: double.infinity,),
                   Column(
                     children: List.generate(mapIcon.length, (index) {
                       return Column(
                         children: [
                           mapIcon[index],
                           (index == 0)?SizedBox(height: widthOrHeight0(context, 0)*0.05,):SizedBox(height: widthOrHeight0(context, 0)*0.01,)
                         ],
                       );
                     }),
                   ),
                   SizedBox(height: widthOrHeight0(context, 0)*0.1,)
                 ],
               )
              ],
            )
          ],
        ),
      ),
    );
  }


}
