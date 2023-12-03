import 'package:charge_go/view/screen/splash_screen.dart';
import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
   MapScreen({super.key});

  List<MapIconWidget> mapIcon = [
    const MapIconWidget( iconData: Icons.my_location,),
    const MapIconWidget( iconData: Icons.list,),
    const MapIconWidget( iconData: Icons.grade,),
  ];

  @override
  Widget build(BuildContext context) {
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
                        padding: EdgeInsets.symmetric(
                            horizontal: widthOrHeight0(context, 1) * 0.01),
                        height: widthOrHeight0(context, 1) * 0.07,
                        decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            border: Border.all(color: Colors.black)),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('Filter'),
                            Icon(Icons.arrow_drop_down)
                          ],
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

class MapIconWidget extends StatelessWidget {
  const MapIconWidget({
    super.key, required this.iconData,
  });
  final IconData iconData;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthOrHeight0(context, 1)*0.1,
      height: widthOrHeight0(context, 0)*0.05,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        shape: BoxShape.circle,
          border: Border.all(color: Colors.grey)
      ),
      child: Icon(iconData,),
    );
  }
}
