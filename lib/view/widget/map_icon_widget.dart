
import 'package:flutter/material.dart';

import '../screen/splash_screen.dart';

class MapIconWidget extends StatelessWidget {
  const MapIconWidget({
    super.key, required this.iconData, required this.callback,
  });
  final IconData iconData;
  final VoidCallback callback;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        width: widthOrHeight0(context, 1)*0.1,
        height: widthOrHeight0(context, 0)*0.05,
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey)
        ),
        child: Icon(iconData,),
      ),
    );
  }
}
