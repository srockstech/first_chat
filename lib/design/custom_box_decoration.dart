import 'package:flutter/material.dart';

class CustomBoxDecoration {
  static BoxDecoration bottomLeftRoundCornerShadow(double screenHeight) {
    return BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black87,
          offset: Offset(screenHeight * 0.02, screenHeight * 0.005),
          blurRadius: screenHeight * 0.025,
        ),
      ],
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.elliptical(screenHeight * 0.1, screenHeight * 0.07),
      ),
    );
  }

  static BoxDecoration topRightRoundCornerShadow(double screenHeight) {
    return BoxDecoration(
      borderRadius: BorderRadius.only(
        topRight: Radius.elliptical(screenHeight * 0.07, screenHeight * 0.065),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black45,
          offset: Offset(-25, 3),
          spreadRadius: 10,
          blurRadius: 30,
        ),
      ],
      color: Colors.white,
    );
  }
}
