import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Color color;
  final String text;
  final Color? textColor;
  final Function()? onPressed;
  final bool bordered;
  final Color shadowColor;
  final bool? topLeftSharpCorner;
  final bool? bottomRightSharpCorner;

  RoundedButton(
      {this.bordered = false,
      this.topLeftSharpCorner,
      this.bottomRightSharpCorner,
      this.shadowColor = Colors.transparent,
      required this.color,
      required this.text,
      required this.textColor,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    if (bordered == false) {
      return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(screenHeight * 0.02),
          backgroundColor: color,
          shadowColor: shadowColor,
          elevation: screenHeight * 0.01,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(screenHeight * 0.04),
              topLeft: (topLeftSharpCorner != true)
                  ? Radius.circular(screenHeight * 0.04)
                  : Radius.circular(0),
              bottomLeft: Radius.circular(screenHeight * 0.04),
              bottomRight: (bottomRightSharpCorner != true)
                  ? Radius.circular(screenHeight * 0.04)
                  : Radius.circular(0),
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: screenHeight * 0.02,
            color: textColor,
            letterSpacing: 0.5,
          ),
        ),
      );
    } else {
      return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.all(screenHeight * 0.019),
          side: BorderSide(
            color: color,
            width: screenHeight * 0.002,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(screenHeight * 0.04),
              topLeft: (topLeftSharpCorner != true)
                  ? Radius.circular(screenHeight * 0.04)
                  : Radius.circular(0),
              bottomLeft: Radius.circular(screenHeight * 0.04),
              bottomRight: (bottomRightSharpCorner != true)
                  ? Radius.circular(screenHeight * 0.04)
                  : Radius.circular(0),
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
              fontSize: screenHeight * 0.02,
              color: textColor,
              letterSpacing: 0.5),
        ),
      );
    }
  }
}
