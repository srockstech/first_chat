import 'package:flutter/material.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const Color kPink = Color(0xFFFE69B4);
const Color kPinkShadow = Color(0xBBFE69B4);
const Color kDarkBlue = Color(0xFF18516E);
const Color kOrange = Color(0xFFFC778A);
const Color kOrangeShadow = Color(0xBBFC778A);
const Color kBlue = Color(0xFF1BB2BC);
const Color kLightBlue = Color(0xFF64D1D2);
