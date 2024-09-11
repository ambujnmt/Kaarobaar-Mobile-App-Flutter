import 'package:flutter/material.dart';
import 'package:kaarobaar/constants/color_constants.dart';
import 'package:kaarobaar/utils/text.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {

  dynamic size;
  final customText = CustomText();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height * 0.77,
        width: size.width,
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
        child: Column(
          children: [
            Container(
              height: size.height * 0.05,
              width: size.width * 0.8,
              margin: EdgeInsets.symmetric(vertical: size.width * 0.05),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(size.width * 0.05),
                  gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        ColorConstants.kGradientDarkGreen,
                        ColorConstants.kGradientLightGreen
                      ]
                  )
              ),
              child: Center(
                child: customText.kText("Privacy Policy", 20, FontWeight.w700, Colors.white, TextAlign.center),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: size.width * 0.02),
                      child: customText.kText("Lorem ipsum dolor sit amet consectetur adipisicing "
                        "elit. Atque cupiditate cum provident at! Dolorum fuga, deserunt est atque "
                        "excepturi voluptas architecto exercitationem cumque delectus iste facilis "
                        "quaerat in minima totam.", 16, FontWeight.w500, Colors.black, TextAlign.start),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: size.width * 0.02),
                      child: customText.kText("Lorem ipsum dolor sit amet consectetur adipisicing elit. "
                        "Atque cupiditate cum provident at! Dolorum fuga, deserunt est atque excepturi "
                        "voluptas architecto exercitationem cumque delectus iste facilis quaerat in minima "
                        "totam. Lorem ipsum dolor sit amet consectetur adipisicing elit. Atque cupiditate "
                        "cum provident at! Dolorum fuga, deserunt est atque excepturi voluptas architecto "
                        "exercitationem cumque delectus iste facilis quaerat in minima totam. Lorem ipsum "
                        "dolor sit amet consectetur adipisicing elit. Atque cupiditate cum provident at! "
                        "Dolorum fuga, deserunt est atque excepturi voluptas architecto exercitationem "
                        "cumque delectus iste facilis quaerat in minima totam. Lorem ipsum dolor sit amet "
                        "consectetur adipisicing elit. Atque cupiditate cum provident at! Dolorum fuga, "
                        "deserunt est atque excepturi voluptas architecto exercitationem cumque delectus "
                        "iste facilis quaerat in minima totam.", 16, FontWeight.w500, Colors.black, TextAlign.start),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: size.width * 0.02),
                      child: customText.kText("Lorem ipsum dolor sit amet consectetur adipisicing "
                        "elit. Atque cupiditate cum provident at! Dolorum fuga, deserunt est atque "
                        "excepturi voluptas architecto exercitationem cumque delectus iste facilis "
                        "quaerat in minima totam.", 16, FontWeight.w500, Colors.black, TextAlign.start),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: size.width * 0.02),
                      child: customText.kText("Lorem ipsum dolor sit amet consectetur adipisicing elit. "
                        "Atque cupiditate cum provident at! Dolorum fuga, deserunt est atque excepturi "
                        "voluptas architecto exercitationem cumque delectus iste facilis quaerat in minima "
                        "totam. Lorem ipsum dolor sit amet consectetur adipisicing elit. Atque cupiditate "
                        "cum provident at! Dolorum fuga, deserunt est atque excepturi voluptas architecto "
                        "exercitationem cumque delectus iste facilis quaerat in minima totam. Lorem ipsum "
                        "dolor sit amet consectetur adipisicing elit. Atque cupiditate cum provident at! "
                        "Dolorum fuga, deserunt est atque excepturi voluptas architecto exercitationem "
                        "cumque delectus iste facilis quaerat in minima totam. Lorem ipsum dolor sit amet "
                        "consectetur adipisicing elit. Atque cupiditate cum provident at! Dolorum fuga, "
                        "deserunt est atque excepturi voluptas architecto exercitationem cumque delectus "
                        "iste facilis quaerat in minima totam.", 16, FontWeight.w500, Colors.black, TextAlign.start),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }

}
