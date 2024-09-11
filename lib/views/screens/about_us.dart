import 'package:flutter/material.dart';
import 'package:kaarobaar/constants/color_constants.dart';
import 'package:kaarobaar/utils/text.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {

  dynamic size;
  final customText = CustomText();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      // body: Center(
      //   child: Text("About Us"),
      // ),
      body: Container(
        height: size.height * 0.77,
        width: size.width,
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.03, vertical: size.width * 0.02),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.7,
                width: size.width * 0.95,
                // color: Colors.grey.shade300,
                child: Column(
                  children: [
                    Container(
                      height: size.height * 0.05,
                      width: size.width * 0.8,
                      margin: EdgeInsets.symmetric(vertical: size.width * 0.03),
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
                        child: customText.kText("About Us", 20, FontWeight.w700, Colors.white, TextAlign.center),
                      ),
                    ),
                    customText.kText("Claim Your Business & Get Started Today!", 20, FontWeight.w700, Colors.black, TextAlign.center),
                    Container(
                      height: size.height * 0.2,
                      width: size.width,
                      margin: EdgeInsets.symmetric(vertical: size.width * 0.03),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(size.width * 0.05)
                      ),
                      child: Image.asset("assets/images/cameraImg.png", fit: BoxFit.fill,),
                    ),
                    const Text(
                      "Lorem ipsum dolor sit amet consectetur adipisicing elit. "
                      "Atque cupiditate cum provident at! Dolorum fuga, deserunt "
                      "est atque excepturi voluptas architecto exercitationem cumque "
                      "delectus iste facilis quaerat in minima totam. Lorem ipsum dolor "
                      "sit amet consectetur adipisicing elit. Nulla eligendi laudantium "
                      "obcaecati numquam quisquam vitae ratione nihil. Quasi laborum tempora "
                      "laboriosam libero aliquam distinctio, sapiente nemo, ex expedita nam "
                      "error! Lorem ipsum dolor sit amet, consectetur adipisicing elit.",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black,
                          fontFamily: "Raleway"), textAlign: TextAlign.start, overflow: TextOverflow.ellipsis,
                      maxLines: 8,
                    ),
                    GestureDetector(
                      child: Container(
                        height: size.width * 0.13,
                        width: size.width,
                        margin: EdgeInsets.symmetric(vertical: size.width * 0.03, horizontal: size.width * 0.25),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(size.width * 0.03),
                            gradient: const RadialGradient(
                              center: Alignment(0.19, -0.9),
                              colors: [
                                Color(0xffa40000),
                                Color(0xff262626)
                              ],
                              radius: 4.0,
                            )
                        ),
                        child: Center(
                          child: customText.kText("See Details", 22, FontWeight.w700, Colors.white, TextAlign.center),
                        ),
                      ),
                      onTap: () {
                        FocusScope.of(context).unfocus();
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.7,
                width: size.width * 0.95,
                // color: Colors.grey.shade300,
                child: Column(
                  children: [
                    Container(
                      height: size.height * 0.05,
                      width: size.width * 0.8,
                      margin: EdgeInsets.symmetric(vertical: size.width * 0.03),
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
                        child: customText.kText("Our Services", 20, FontWeight.w700, Colors.white, TextAlign.center),
                      ),
                    ),
                    customText.kText("Claim Your Business & Get Started Today!", 20, FontWeight.w700, Colors.black, TextAlign.center),
                    Container(
                      height: size.height * 0.2,
                      width: size.width,
                      margin: EdgeInsets.symmetric(vertical: size.width * 0.03),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(size.width * 0.05)
                      ),
                      child: Image.asset("assets/images/cameraImg.png", fit: BoxFit.fill,),
                    ),
                    const Text(
                      "Lorem ipsum dolor sit amet consectetur adipisicing elit. "
                          "Atque cupiditate cum provident at! Dolorum fuga, deserunt "
                          "est atque excepturi voluptas architecto exercitationem cumque "
                          "delectus iste facilis quaerat in minima totam. Lorem ipsum dolor "
                          "sit amet consectetur adipisicing elit. Nulla eligendi laudantium "
                          "obcaecati numquam quisquam vitae ratione nihil. Quasi laborum tempora "
                          "laboriosam libero aliquam distinctio, sapiente nemo, ex expedita nam "
                          "error! Lorem ipsum dolor sit amet, consectetur adipisicing elit.",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black,
                          fontFamily: "Raleway"), textAlign: TextAlign.start, overflow: TextOverflow.ellipsis,
                      maxLines: 8,
                    ),
                    GestureDetector(
                      child: Container(
                        height: size.width * 0.13,
                        width: size.width,
                        margin: EdgeInsets.symmetric(vertical: size.width * 0.03, horizontal: size.width * 0.25),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(size.width * 0.03),
                            gradient: const RadialGradient(
                              center: Alignment(0.19, -0.9),
                              colors: [
                                Color(0xffa40000),
                                Color(0xff262626)
                              ],
                              radius: 4.0,
                            )
                        ),
                        child: Center(
                          child: customText.kText("See Details", 22, FontWeight.w700, Colors.white, TextAlign.center),
                        ),
                      ),
                      onTap: () {
                        FocusScope.of(context).unfocus();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }

}
