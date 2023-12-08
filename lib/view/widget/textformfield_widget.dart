
import 'package:flutter/material.dart';

class TextFormWidget extends StatelessWidget {
  final bool obscureText;
  final TextEditingController passController;
  final String hintText;
  final double width;
  final double height;
  final Color color;
  final IconData iconSufData;

  const TextFormWidget(
      {super.key,
        required this.obscureText,
        required this.passController,
        required this.hintText,
        this.width = 0,
        this.height = 0,
        this.color = Colors.lime,
        this.iconSufData = Icons.add});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: (width == 0) ? null : width,
        height: (height == 0) ? null : height,
        child: TextFormField(
          textAlign: TextAlign.left,
          keyboardType: TextInputType.emailAddress,
          obscureText: obscureText,

          controller: passController,
          decoration: InputDecoration(
            prefixIcon: Icon((iconSufData == Icons.add) ? null : iconSufData,color: Color(0xffa8a8a8)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: (color == Colors.lime)
                    ? const Color(0xff6482c4).withOpacity(0.8)
                    : color,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10))
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: (color == Colors.lime)
                    ? const Color(0xff6482c4).withOpacity(0.8)
                    : color,
              ),
                borderRadius: const BorderRadius.all(Radius.circular(10))
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red.withOpacity(0.8),

              ),


            ),
            focusedErrorBorder:  OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red.withOpacity(0.8),
              ),
            ),
            disabledBorder:  OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red.withOpacity(0.8),
              ),
                borderRadius: const BorderRadius.all(Radius.circular(20))
            ),
            isDense: true,
            hintText: hintText,

            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
        ));
  }
}