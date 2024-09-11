import 'package:flutter/material.dart';
import 'package:kaarobaar/constants/color_constants.dart';
import 'package:kaarobaar/utils/text.dart';

class Helper {

  final customText = CustomText();

  errorDialog(context, message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: customText.kText(
            message, 20, FontWeight.w900, Colors.white,
            TextAlign.start),
        backgroundColor: ColorConstants.kGradientRed,
      ),
    );
  }

  successDialog(context, message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: customText.kText(
            message, 20, FontWeight.w900, Colors.white,
            TextAlign.start),
        backgroundColor: ColorConstants.kGradientDarkGreen,
        duration: const Duration(seconds: 1),
      ),
    );
  }

}