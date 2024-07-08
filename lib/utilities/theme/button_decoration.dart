import 'package:flutter/material.dart';

ButtonStyle getOutlinedButtonStyle({
  double borderRadius = 8.0,
  Color foregroundColor = Colors.black,
  Color backgroundColor = Colors.transparent,
  Color borderColor = Colors.black,
  double borderWidth = 1.0,
  double width = 400,
  double height = 50.0,
  Color buttonColor = Colors.black,
  bool showShadow = true,
}) {
  return OutlinedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(
          borderRadius ?? 8.0,
        ),
      ),
    ),
    foregroundColor: foregroundColor,
    backgroundColor: backgroundColor,
    side: BorderSide(
      color: borderColor,
      width: borderWidth,
    ),
    minimumSize: Size(
      width,
      height,
    ),
  );
}


ButtonStyle getElevatedButtonStyle({
  double borderRadius = 8.0,
  Color foregroundColor = Colors.white,
  Color backgroundColor = Colors.black,
  double elevation = 4.0,
  double width = 400,
  double height = 50.0,
  bool showShadow = true,
}) {
  return ElevatedButton.styleFrom(
    foregroundColor: foregroundColor, backgroundColor: backgroundColor, shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(
          borderRadius ?? 8.0,
        ),
      ),
    ),
    elevation: elevation,
    minimumSize: Size(
      width,
      height,
    ),
  );
}