import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaarobaar/constants/color_constants.dart';
import 'package:kaarobaar/controllers/side_drawerController.dart';
import 'package:kaarobaar/utils/text.dart';

class AdvertiseWithUs extends StatefulWidget {
  const AdvertiseWithUs({super.key});

  @override
  State<AdvertiseWithUs> createState() => _AdvertiseWithUsState();
}

class _AdvertiseWithUsState extends State<AdvertiseWithUs> {

  dynamic size;
  final customText = CustomText();

  SideDrawerController sideDrawerController = Get.put(SideDrawerController());

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
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
                child: customText.kText("Advertise With Us", 20, FontWeight.w700, Colors.white, TextAlign.center),
              ),
            ),

            SizedBox(
              height: size.height * 0.67,
              width: size.width,
              child: GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                  childAspectRatio: 1/1.8,
                ),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Container(
                      padding: EdgeInsets.all(size.width * 0.01),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size.width * 0.03)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: size.width * 0.38,
                            width: size.width * 0.5,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade800,
                                borderRadius: BorderRadius.circular(size.width * 0.03)
                            ),
                            child: Image.asset("assets/images/cameraImg.png", fit: BoxFit.fill,),
                          ),
                          Container(
                            width: size.width * 0.45,
                            height: size.width * 0.1,
                            padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
                            child: const Text(
                              "Flutter Developer (Coroprate Office)",
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.black,
                                fontFamily: "Raleway"), textAlign: TextAlign.start, overflow: TextOverflow.ellipsis,
                              maxLines: 7,
                            ),
                          ),
                          Container(
                            width: size.width * 0.45,
                            height: size.width * 0.27,
                            // color: Colors.grey.shade300,
                            padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: size.width * 0.06,
                                  child: Image.asset("assets/images/map.png"),
                                ),
                                SizedBox(
                                  width: size.width * 0.35,
                                  child: const Text("Office 24 Brentham Old Power Station, Western Avenue London - W5 1HS",
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black,
                                        fontFamily: "Raleway"), textAlign: TextAlign.start, overflow: TextOverflow.ellipsis,
                                    maxLines: 5,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                    onTap: () {
                      sideDrawerController.pageIndex.value = 18;
                      sideDrawerController.pageController.jumpToPage(18);
                    },
                  );
                },
              ),
            )

          ],
        ),
      )
    );
  }

}
