import 'dart:io';

import 'package:flutter/material.dart';

import '../constants.dart';

class CustomShadow {
  static List<BoxShadow> primaryCTAShadow() {
    return [
      (Platform.isAndroid) ? BoxShadow(
        color: kLightBrown.withOpacity(0.35),
        blurRadius: 1,
        offset: Offset(0, 4),
        spreadRadius: -0.5,
      ) : BoxShadow(
        color: kLightBrown.withOpacity(0.25),
        blurRadius: 4,
        offset: Offset(0, 4),
      ),
    ];
  }
}