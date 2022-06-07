import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';

class QuoteBubbleTextField extends StatelessWidget {
  QuoteBubbleTextField({
    @required this.screenHeight,
    @required this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.label,
    this.hintText,
    this.hintTextColor = kDarkBlue,
    this.textColor = kDarkBlue,
    this.enabledBorderColor = kDarkBlue,
    this.focusedBorderColor = kDarkBlue,
    this.cursorColor = kPink,
    this.fillColor = Colors.white,
    this.focusColor = Colors.white,
    this.fontSize,
    this.obscureText = false,
    this.haveSharpCorner = true,
    this.maxLines = 1,
    this.minLines,
    this.keyboardType,
  });

  final Function onChanged;
  final double screenHeight;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final String label;
  final String hintText;
  final Color hintTextColor;
  final Color textColor;
  final Color enabledBorderColor;
  final Color focusedBorderColor;
  final Color cursorColor;
  final Color fillColor;
  final Color focusColor;
  final double fontSize;
  final bool obscureText;
  final bool haveSharpCorner;
  final int maxLines;
  final int minLines;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(splashColor: Colors.transparent),
      child: TextField(
        obscureText: obscureText,
        keyboardType: keyboardType,
        maxLines: maxLines,
        minLines: minLines,
        onChanged: onChanged,
        cursorColor: cursorColor,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: label,
          labelStyle: TextStyle(color: kDarkBlue, fontWeight: FontWeight.bold),
          contentPadding: EdgeInsets.all(screenHeight * 0.02),
          filled: true,
          fillColor: fillColor,
          focusColor: focusColor,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: enabledBorderColor, width: screenHeight * 0.0015),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(screenHeight * 0.04),
              bottomLeft: Radius.circular(screenHeight * 0.04),
              topRight: Radius.circular(screenHeight * 0.04),
              bottomRight: (haveSharpCorner == false)
                  ? Radius.circular(screenHeight * 0.04)
                  : Radius.circular(0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: focusedBorderColor, width: screenHeight * 0.002),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(screenHeight * 0.04),
              bottomLeft: Radius.circular(screenHeight * 0.04),
              topRight: Radius.circular(screenHeight * 0.04),
              bottomRight: (haveSharpCorner == false)
                  ? Radius.circular(screenHeight * 0.04)
                  : Radius.circular(0),
            ),
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: hintTextColor),
        ),
        style: TextStyle(
            color: textColor, fontWeight: FontWeight.bold, fontSize: fontSize),
      ),
    );
  }
}
