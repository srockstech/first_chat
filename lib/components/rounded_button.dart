import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Color color;
  final Color borderColor;
  final Function()? onPressed;
  final bool bordered;
  final bool? topLeftSharpCorner;
  final bool? bottomRightSharpCorner;
  final bool? bottomLeftSharpCorner;
  final bool? topRightSharpCorner;
  final List<BoxShadow> shadow;
  final Widget? child;
  final EdgeInsets? contentPadding;

  RoundedButton(
      {this.bordered = false,
      this.topLeftSharpCorner,
      this.bottomRightSharpCorner,
      this.bottomLeftSharpCorner,
      this.topRightSharpCorner,
      required this.color,
      this.borderColor = Colors.transparent,
      required this.onPressed,
        this.contentPadding,
      this.child,
        this.shadow = const [
          BoxShadow(
            color: Colors.transparent,
            offset: Offset(0, 3),
            blurRadius: 6,
          ),
        ]});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    if (bordered == false) {
      return Container(
        decoration: BoxDecoration(
          boxShadow: shadow,
          borderRadius: BorderRadius.only(
            topRight: (topRightSharpCorner != true)
                ? Radius.circular(screenHeight * 0.04)
                : Radius.zero,
            topLeft: (topLeftSharpCorner != true)
                ? Radius.circular(screenHeight * 0.04)
                : Radius.zero,
            bottomLeft: (bottomLeftSharpCorner != true)
                ? Radius.circular(screenHeight * 0.04)
                : Radius.zero,
            bottomRight: (bottomRightSharpCorner != true)
                ? Radius.circular(screenHeight * 0.04)
                : Radius.zero,
          ),
        ),
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            padding: (contentPadding != null) ? contentPadding : EdgeInsets.all(screenHeight * 0.02),
            backgroundColor: color,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: (topRightSharpCorner != true)
                    ? Radius.circular(screenHeight * 0.04)
                    : Radius.zero,
                topLeft: (topLeftSharpCorner != true)
                    ? Radius.circular(screenHeight * 0.04)
                    : Radius.zero,
                bottomLeft: (bottomLeftSharpCorner != true)
                    ? Radius.circular(screenHeight * 0.04)
                    : Radius.zero,
                bottomRight: (bottomRightSharpCorner != true)
                    ? Radius.circular(screenHeight * 0.04)
                    : Radius.zero,
              ),
            ),
          ),
          child: child!,
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          boxShadow: shadow,
          borderRadius: BorderRadius.only(
            topRight: (topRightSharpCorner != true)
                ? Radius.circular(screenHeight * 0.04)
                : Radius.zero,
            topLeft: (topLeftSharpCorner != true)
                ? Radius.circular(screenHeight * 0.04)
                : Radius.zero,
            bottomLeft: (bottomLeftSharpCorner != true)
                ? Radius.circular(screenHeight * 0.04)
                : Radius.zero,
            bottomRight: (bottomRightSharpCorner != true)
                ? Radius.circular(screenHeight * 0.04)
                : Radius.zero,
          ),
        ),
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            padding: (contentPadding != null) ? contentPadding : EdgeInsets.all(screenHeight * 0.02),
            side: BorderSide(
              color: borderColor,
              width: screenHeight * 0.002,
            ),
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: (topRightSharpCorner != true)
                    ? Radius.circular(screenHeight * 0.04)
                    : Radius.zero,
                topLeft: (topLeftSharpCorner != true)
                    ? Radius.circular(screenHeight * 0.04)
                    : Radius.zero,
                bottomLeft: (bottomLeftSharpCorner != true)
                    ? Radius.circular(screenHeight * 0.04)
                    : Radius.zero,
                bottomRight: (bottomRightSharpCorner != true)
                    ? Radius.circular(screenHeight * 0.04)
                    : Radius.zero,
              ),
            ),
          ),
          child: child,
        ),
      );
    }
  }
}
