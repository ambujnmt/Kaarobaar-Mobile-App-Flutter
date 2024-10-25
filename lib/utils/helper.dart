import 'package:flutter/material.dart';
import 'package:kaarobaar/constants/color_constants.dart';
import 'package:kaarobaar/utils/text.dart';

class Helper {
  final customText = CustomText();

  errorDialog(context, message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Container(
          // height: 30,
          // child: customText.kText(
          //     message, 20, FontWeight.w900, Colors.white, TextAlign.start),
          child: Text(
            message,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w900,
                fontFamily: "Raleway"),
            maxLines: 2,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        backgroundColor: ColorConstants.kGradientRed,
      ),
    );
  }

  successDialog(context, message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        // content: customText.kText(
        //     message, 20, FontWeight.w900, Colors.white, TextAlign.start),
        content: Container(
          child: Text(
            message,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w900,
                fontFamily: "Raleway"),
            maxLines: 2,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
          ),
        ),

        backgroundColor: ColorConstants.kGradientDarkGreen,
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
