import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Color color;
  final String text;
  final Function onPressed;
  RoundedButton(
      {@required this.color, @required this.text, @required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      // color: color,
      // borderRadius: BorderRadius.circular(15.0),
      // minWidth: 200.0,
      // height: 55.0,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.06,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: color,
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
        child: Center(
          child: Text(
              text,
              style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
