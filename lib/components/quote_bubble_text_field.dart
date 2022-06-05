import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';

class QuoteBubbleTextField extends StatelessWidget {
  QuoteBubbleTextField({
    @required this.screenHeight,
    @required this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.label,
    this.obscureText = false,
    this.keyboardType,
  });

  final Function onChanged;
  final double screenHeight;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final String label;
  final bool obscureText;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: label,
          labelStyle: TextStyle(color: kDarkBlue, fontWeight: FontWeight.bold),
          focusColor: Colors.grey,
          contentPadding: EdgeInsets.all(screenHeight * 0.02),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: kDarkBlue, width: screenHeight * 0.0015),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(screenHeight * 0.04),
              bottomLeft: Radius.circular(screenHeight * 0.04),
              bottomRight: Radius.circular(screenHeight * 0.04),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: kDarkBlue, width: screenHeight * 0.002),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(screenHeight * 0.04),
              bottomLeft: Radius.circular(screenHeight * 0.04),
              bottomRight: Radius.circular(screenHeight * 0.04),
            ),
          ),
          hintStyle: TextStyle(color: Colors.grey[600])),
      style: TextStyle(color: kDarkBlue, fontWeight: FontWeight.bold),
    );
  }
}
