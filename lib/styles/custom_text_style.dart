import 'package:flutter/material.dart';

class CustomTextStyle {
  static TextStyle appLogoNameTextStyle(BuildContext context, double screenHeight) {
    return Theme.of(context).textTheme.titleLarge!.copyWith(
      fontSize: screenHeight * 0.08,
      color: Colors.white,
    );
  }

  static TextStyle secondaryTextStyle(BuildContext context, double screenHeight) {
    return TextStyle(
        fontSize: screenHeight * 0.02,
        color: Colors.white,
        letterSpacing: 0.5);
  }
}