import 'package:flutter/material.dart';

import '../screen/splash_screen.dart';

class MapIconWidget extends StatelessWidget {
  const MapIconWidget({
    super.key,
    required this.iconData,
    required this.callback,
  });

  final IconData iconData;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        width: widthOrHeight0(context, 1) * 0.1,
        height: widthOrHeight0(context, 0) * 0.05,
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                spreadRadius: 0.5,
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ]),
        child: Icon(
          iconData,
          color: Colors.blue,
        ),
      ),
    );
  }
}
