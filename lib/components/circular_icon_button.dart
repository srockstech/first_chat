import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';

class CircularIconButton extends StatelessWidget {
  const CircularIconButton({
    @required this.screenHeight,
    this.icon,
    this.onPressed,
  });

  final double screenHeight;
  final Widget icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screenHeight * 0.1),
        border: Border.all(color: kDarkBlue, width: screenHeight * 0.001),
      ),
      margin: EdgeInsets.all(screenHeight * 0.01),
      height: screenHeight * 0.055,
      width: screenHeight * 0.055,
      child: IconButton(
        icon: icon,
        iconSize: screenHeight * 0.03,
        color: kDarkBlue,
        onPressed: onPressed,
      ),
    );
  }
}
