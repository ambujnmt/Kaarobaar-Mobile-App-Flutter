import 'package:flutter/material.dart';
import 'package:kaarobaar/constants/color_constants.dart';
import 'package:kaarobaar/utils/text.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {

  dynamic size;
  final customText = CustomText();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      // body: Center(
      //   child: Text("Categories"),
      // ),
      body: Container(
        height: size.height * 0.77,
        width: size.width,
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
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
              child: customText.kText("Categories", 20, FontWeight.w700, Colors.white, TextAlign.center),
            ),
          ),

            Container(
              height: size.height * 0.2,
              width: size.width,
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
              margin: EdgeInsets.only(bottom: size.width * 0.015),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customText.kText("Jobs", 25, FontWeight.w700, Colors.black, TextAlign.center),
                        customText.kText("View All", 18, FontWeight.w700, ColorConstants.kIconsGrey, TextAlign.center),
                      ],
                    ),
                  ),
                  SizedBox(height: size.width * 0.01,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: size.height * 0.15,
                        width: size.width * 0.43,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade800,
                          borderRadius: BorderRadius.circular(size.width *0.03)
                        ),
                        child: Image.asset("assets/images/cameraImg.png", fit: BoxFit.fill,),
                      ),
                      SizedBox(width: size.width * 0.02,),
                      Container(
                        height: size.height * 0.15,
                        width: size.width * 0.43,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade800,
                            borderRadius: BorderRadius.circular(size.width *0.03)
                        ),
                        child: Image.asset("assets/images/cameraImg.png", fit: BoxFit.fill,),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: size.height * 0.2,
              width: size.width,
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
              margin: EdgeInsets.only(bottom: size.width * 0.015),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customText.kText("Events", 25, FontWeight.w700, Colors.black, TextAlign.center),
                        customText.kText("View All", 18, FontWeight.w700, ColorConstants.kIconsGrey, TextAlign.center),
                      ],
                    ),
                  ),
                  SizedBox(height: size.width * 0.01,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: size.height * 0.15,
                        width: size.width * 0.43,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade800,
                            borderRadius: BorderRadius.circular(size.width *0.03)
                        ),
                        child: Image.asset("assets/images/cameraImg.png", fit: BoxFit.fill,),
                      ),
                      SizedBox(width: size.width * 0.02,),
                      Container(
                        height: size.height * 0.15,
                        width: size.width * 0.43,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade800,
                            borderRadius: BorderRadius.circular(size.width *0.03)
                        ),
                        child: Image.asset("assets/images/cameraImg.png", fit: BoxFit.fill,),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: size.height * 0.2,
              width: size.width,
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
              margin: EdgeInsets.only(bottom: size.width * 0.015),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customText.kText("Places", 25, FontWeight.w700, Colors.black, TextAlign.center),
                        customText.kText("View All", 18, FontWeight.w700, ColorConstants.kIconsGrey, TextAlign.center),
                      ],
                    ),
                  ),
                  SizedBox(height: size.width * 0.01,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: size.height * 0.15,
                        width: size.width * 0.43,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade800,
                            borderRadius: BorderRadius.circular(size.width *0.03)
                        ),
                        child: Image.asset("assets/images/cameraImg.png", fit: BoxFit.fill,),
                      ),
                      SizedBox(width: size.width * 0.02,),
                      Container(
                        height: size.height * 0.15,
                        width: size.width * 0.43,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade800,
                            borderRadius: BorderRadius.circular(size.width *0.03)
                        ),
                        child: Image.asset("assets/images/cameraImg.png", fit: BoxFit.fill,),
                      ),
                    ],
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

}
