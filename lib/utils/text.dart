import 'package:flutter/material.dart';

class CustomText {

  kText(String hint, double fontSize, FontWeight fontWeight, Color color,
      TextAlign textAlign) {
    return Text(
      hint,
      style: TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color,
          fontFamily: "Raleway"),
      textAlign: textAlign,
    );
  }

  kTextStyle(double fontSize, FontWeight fontWeight, Color color,) {
    return TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color, fontFamily: "Raleway");
  }

}