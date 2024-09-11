import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kaarobaar/constants/color_constants.dart';
import 'package:kaarobaar/controllers/side_drawerController.dart';
import 'package:kaarobaar/utils/text.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  
  dynamic size;
  final customText = CustomText();

  SideDrawerController sideDrawerController = Get.put(SideDrawerController());

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
        child: Column(
          children: [
            SizedBox(height: size.width * 0.05,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: size.width * 0.62,
                  child: customText.kText("My Account", 30, FontWeight.bold, Colors.black, TextAlign.start),
                ),
                Container(
                  height: size.width * 0.25,
                  padding: EdgeInsets.all(size.width * 0.01),
                  decoration: const BoxDecoration(
                    color: ColorConstants.kCircleRed,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset("assets/images/sampleGirl.png"),
                ),
              ],
            ),
            SizedBox(height: size.width * 0.05,),
            Container(
              height: size.height * 0.06,
              width: size.width,
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              decoration: const BoxDecoration(
                // color: Colors.grey.shade200,
                border: Border(
                  bottom: BorderSide(width: 1.0, color: ColorConstants.kIconsGrey),
                ),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: customText.kText("User Name", 20, FontWeight.w500, ColorConstants.kIconsGrey, TextAlign.start),
              ),
            ),
            SizedBox(height: size.width * 0.05,),
            Container(
              height: size.height * 0.06,
              width: size.width,
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.0, color: ColorConstants.kIconsGrey),
                ),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: customText.kText("Email", 20, FontWeight.w500, ColorConstants.kIconsGrey, TextAlign.start),
              ),
            ),
            SizedBox(height: size.width * 0.05,),
            Container(
              height: size.height * 0.06,
              width: size.width,
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.0, color: ColorConstants.kIconsGrey),
                ),
              ),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customText.kText("Password", 20, FontWeight.w500, ColorConstants.kIconsGrey, TextAlign.start),
                  GestureDetector(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: customText.kText("Change", 14, FontWeight.w500, ColorConstants.kIconsGrey, TextAlign.right)
                    ),
                    onTap: () {
                      sideDrawerController.pageIndex.value = 14;
                      sideDrawerController.pageController.jumpToPage(14);
                    },
                  )
                ],
              )
            ),
            // const Spacer(),
            SizedBox(height: size.height * 0.2,),
            GestureDetector(
              child: Container(
                height: size.width * 0.13,
                width: size.width,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(size.width * 0.02),
                    gradient: const RadialGradient(
                      center: Alignment(0.19, -0.9),
                      colors: [
                        ColorConstants.kGradientDarkGreen,
                        ColorConstants.kGradientBlack,
                      ],
                      radius: 4.0,
                    )
                ),
                child: Center(
                  child: customText.kText("Continue", 30, FontWeight.w700, Colors.white, TextAlign.center),
                ),
              ),
              onTap: () {},
            )
          ],
        ),
      )
    );
  }

}
