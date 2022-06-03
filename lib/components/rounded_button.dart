import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Color color;
  final String text;
  final Color textColor;
  final Function onPressed;
  final bool bordered;
  final Color shadowColor;
  RoundedButton(
      {this.bordered = false, this.shadowColor = Colors.transparent, @required this.color, @required this.text, @required this.textColor, @required this.onPressed});
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    if(bordered == false) {
      return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(screenHeight * 0.025),
          backgroundColor: color,
          shadowColor: shadowColor,
          elevation: 18,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(screenHeight * 0.025)),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 16, color: textColor, letterSpacing: 1),
        ),
      );
    }else{
      return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.all(screenHeight * 0.025),
          side: BorderSide(color: color, width: 2),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(screenHeight * 0.025)),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 16, color: textColor, letterSpacing: 1),
        ),
      );
    }
  }
}
