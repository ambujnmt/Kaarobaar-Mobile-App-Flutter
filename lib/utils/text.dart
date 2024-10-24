import 'package:flutter/material.dart';

class CustomText {
  kText(String hint, double fontSize, FontWeight fontWeight, Color color,
      TextAlign textAlign,
      {int? maxLines}) {
    return Text(
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      hint,
      style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          fontFamily: "Raleway"),
      textAlign: textAlign,
    );
  }

  kTextStyle(
    double fontSize,
    FontWeight fontWeight,
    Color color,
  ) {
    return TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        fontFamily: "Raleway");
  }
}
