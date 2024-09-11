import 'package:flutter/material.dart';
import 'package:kaarobaar/constants/color_constants.dart';
import 'package:kaarobaar/utils/text.dart';


class PopularCommunities extends StatefulWidget {
  const PopularCommunities({super.key});

  @override
  State<PopularCommunities> createState() => _PopularCommunitiesState();
}

class _PopularCommunitiesState extends State<PopularCommunities> {

  dynamic size;
  final customText = CustomText();



  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: size.width * 0.02),
        child: SingleChildScrollView(
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
                  child: customText.kText("Popular Communities", 20, FontWeight.w700, Colors.white, TextAlign.center),
                ),
              ),

              SizedBox(
                height: size.height * 0.67,
                width: size.width,
                // color: Colors.grey.shade400,
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
                    return Container(
                      // margin: EdgeInsets.all(size.width * 0.02),
                      padding: EdgeInsets.all(size.width * 0.02),
                      decoration: BoxDecoration(
                        border: Border.all(color: ColorConstants.kIndicatorDots),
                        borderRadius: BorderRadius.circular(size.width * 0.03)
                      ),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: size.width * 0.38,
                            width: size.width * 0.38,
                            margin: EdgeInsets.only(bottom: size.width * 0.02),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade800,
                              borderRadius: BorderRadius.circular(size.width * 0.03)
                            ),
                            child: Image.asset("assets/images/cameraImg.png", fit: BoxFit.fill,),
                          ),
                          SizedBox(
                            width: size.width * 0.45,
                            height: size.width * 0.09,
                            child: customText.kText("The Sartaj blue night", 15, FontWeight.w700, Colors.black, TextAlign.center),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: size.width * 0.07,
                                child: Image.asset("assets/images/map.png"),
                              ),
                              SizedBox(
                                width: size.width * 0.33,
                                height: size.height * 0.09,
                                child: customText.kText("20102 Kabul Range Road, Afghanistan 1001.",
                                  13, FontWeight.w500, Colors.black, TextAlign.left)
                              )
                            ],
                          ),

                          Container(
                            height: size.height * 0.05,
                            width: size.width * 0.8,
                            // margin: EdgeInsets.symmetric(vertical: size.width * 0.02),
                            padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                            decoration: BoxDecoration(
                                // border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(size.width * 0.02),
                                gradient: const LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      ColorConstants.kGradientDarkGreen,
                                      ColorConstants.kGradientLightGreen
                                    ]
                                )
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                customText.kText("Event", 14, FontWeight.w700, Colors.white, TextAlign.center),
                                CircleAvatar(
                                  radius: size.width * 0.042,
                                  child: SizedBox(
                                    height: size.width * 0.055,
                                    child: Image.asset("assets/images/call.png")),
                                )
                              ],
                            ),
                          ),

                        ],
                      ),
                    );
                  })
              )

            ],
          ),
        ),
      ),
    );
  }

}
