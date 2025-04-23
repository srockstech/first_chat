import 'dart:io';

import 'package:first_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuoteBubbleTextField extends StatelessWidget {
  QuoteBubbleTextField({
    @required this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.label,
    this.hintText,
    this.hintTextColor = kBlack,
    this.textColor = kBlack,
    this.enabledBorderColor = kBlack,
    this.focusedBorderColor = kBlack,
    this.cursorColor = kPink,
    this.fillColor = Colors.white,
    this.focusColor = Colors.white,
    this.fontSize,
    this.obscureText = false,
    this.haveSharpCorner = true,
    this.maxLines = 1,
    this.minLines,
    this.keyboardType,
    this.textInputAction,
    this.controller,
    this.enabledBorderWidth,
    this.focusedBorderWidth,
    this.contentPadding,
    this.hideKeyboardOnTapOutside = true,
    this.focusNode,
    this.shadow = const [
      BoxShadow(
        color: Colors.transparent,
        offset: Offset(0, 3),
        blurRadius: 6,
      ),
    ],
  });

  final Function(String)? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? label;
  final String? hintText;
  final Color? hintTextColor;
  final Color? textColor;
  final Color enabledBorderColor;
  final Color focusedBorderColor;
  final Color? cursorColor;
  final Color? fillColor;
  final Color? focusColor;
  final double? fontSize;
  final bool? obscureText;
  final bool? haveSharpCorner;
  final int? maxLines;
  final int? minLines;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final double? enabledBorderWidth;
  final double? focusedBorderWidth;
  final EdgeInsets? contentPadding;
  final List<BoxShadow> shadow;
  final bool hideKeyboardOnTapOutside;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;


  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Theme(
      data: Theme.of(context).copyWith(splashColor: Colors.transparent),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(screenHeight * 0.04),
            bottomLeft: Radius.circular(screenHeight * 0.04),
            topRight: Radius.circular(screenHeight * 0.04),
            bottomRight: (haveSharpCorner == false)
                ? Radius.circular(screenHeight * 0.04)
                : Radius.circular(0),
          ),
          boxShadow: shadow,
        ),
        child: TextField(
          inputFormatters: [
            // allow only numbers
            if (keyboardType == TextInputType.phone) FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            // truncating the text to 10 characters
            if (keyboardType == TextInputType.phone) LengthLimitingTextInputFormatter(10),
          ],
          onTapOutside: (focusNode) {
            if(hideKeyboardOnTapOutside == true) {
              FocusScope.of(context).unfocus();
            }
          },
          focusNode: focusNode,
          controller: controller,
          obscureText: obscureText!,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          maxLines: maxLines,
          minLines: minLines,
          onChanged: onChanged,
          cursorColor: cursorColor,
          cursorWidth: screenWidth * 0.009,
          cursorHeight: screenWidth * 0.056,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            labelText: label,
            labelStyle: TextStyle(color: kBlack, fontWeight: FontWeight.bold),
            contentPadding: (contentPadding != null) ? contentPadding : EdgeInsets.all(screenHeight * 0.02),
            filled: true,
            counterStyle: TextStyle(color: Colors.transparent),
            fillColor: fillColor,
            focusColor: focusColor,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: enabledBorderColor, width: (enabledBorderWidth == null) ? screenHeight * 0.0015 : enabledBorderWidth!),
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
                  color: focusedBorderColor, width: (focusedBorderWidth == null) ? screenHeight * 0.0015 : enabledBorderWidth!),
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
              color: textColor, fontSize: fontSize, fontWeight: FontWeight.w600),

        ),
      ),
    );
  }
}
