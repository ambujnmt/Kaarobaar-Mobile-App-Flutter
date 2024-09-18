import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer';
import 'package:kaarobaar/constants/color_constants.dart';
import 'package:kaarobaar/controllers/side_drawerController.dart';
import 'package:kaarobaar/services/api_services.dart';
import 'package:kaarobaar/utils/helper.dart';
import 'package:kaarobaar/utils/text.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  dynamic size;
  final customText = CustomText(), api = API(), helper = Helper();
  Map<String, dynamic> aboutUsData = {};
  List<dynamic> servicesListData = [];
  SideDrawerController sideDrawerController = Get.put(SideDrawerController());
  bool isApiLoading = false;

  @override
  void initState() {
    super.initState();
    aboutUs();
    servicesList();
  }

  aboutUs() async {
    setState(() {
      isApiLoading = true;
    });

    final response = await api.aboutUs();

    setState(() {
      isApiLoading = false;
    });

    if (response["status"] == 1) {
      aboutUsData = response["result"];
      log("aboutUsData in about us screen :- $aboutUsData");
    }
    setState(() {});
  }

  servicesList() async {
    print('services list function call');
    setState(() {
      isApiLoading = true;
    });

    final response = await api.servicesList();

    setState(() {
      servicesListData = response['result'];
    });

    setState(() {
      isApiLoading = false;
    });

    // if (response["status"] == 1) {
    //   // servicesListData = response["result"];
    //   // log(" services list response :- $servicesListData");
    // }
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      // body: Center(
      //   child: Text("About Us"),
      // ),
      body: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.03, vertical: size.width * 0.02),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
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
                        ])),
                child: Center(
                  child: customText.kText("About Us", 20, FontWeight.w700,
                      Colors.white, TextAlign.center),
                ),
              ),
              // customText.kText("Claim Your Business & Get Started Today!", 20, FontWeight.w700, Colors.black, TextAlign.center),
              isApiLoading
                  ? const CircularProgressIndicator(
                      color: ColorConstants.kTestimonialsDarkRed,
                    )
                  : Wrap(
                      children: [
                        customText.kText("${aboutUsData["title"]}", 20,
                            FontWeight.w700, Colors.black, TextAlign.center),
                        Container(
                          height: size.height * 0.2,
                          width: size.width,
                          margin:
                              EdgeInsets.symmetric(vertical: size.width * 0.03),
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius:
                                  BorderRadius.circular(size.width * 0.05),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      aboutUsData["about_image"].toString()),
                                  fit: BoxFit.cover)),
                        ),
                        HtmlWidget(
                          aboutUsData["about_content"],
                          textStyle: customText.kTextStyle(
                              16, FontWeight.w500, Colors.black),
                        )
                      ],
                    ),
              const SizedBox(height: 20),
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
                        ])),
                child: Center(
                  child: customText.kText("Our Services", 20, FontWeight.w700,
                      Colors.white, TextAlign.center),
                ),
              ),
              isApiLoading
                  ? const CircularProgressIndicator(
                      color: ColorConstants.kTestimonialsDarkRed,
                    )
                  : Container(
                      // color: Colors.red,
                      // height: size.height * .5,

                      width: double.infinity,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: servicesListData.length,
                        itemBuilder: (BuildContext context, int index) =>
                            Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customText.kText(
                                "${servicesListData[index]["title"]}",
                                20,
                                FontWeight.w700,
                                Colors.black,
                                TextAlign.center,
                              ),
                              servicesListData[index]['image'] == ""
                                  ? Container()
                                  : Container(
                                      height: size.height * 0.2,
                                      width: size.width,
                                      margin: EdgeInsets.symmetric(
                                          vertical: size.width * 0.03),
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(
                                            size.width * 0.05),
                                        // image: DecorationImage(
                                        //     image: NetworkImage(
                                        //         servicesListData[index]
                                        //             ["image"]),
                                        //     fit: BoxFit.cover),
                                      ),
                                      child: Image.network(
                                        servicesListData[index]['image']
                                            .toString(),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                              HtmlWidget(
                                servicesListData[index]["short_content"],
                                textStyle: customText.kTextStyle(
                                    16, FontWeight.w500, Colors.black),
                              ),
                              const SizedBox(height: 20),
                              GestureDetector(
                                child: Container(
                                  height: size.width * 0.13,
                                  width: size.width,
                                  margin: EdgeInsets.symmetric(
                                      vertical: size.width * 0.03,
                                      horizontal: size.width * 0.25),
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(
                                          size.width * 0.03),
                                      gradient: const RadialGradient(
                                        center: Alignment(0.19, -0.9),
                                        colors: [
                                          Color(0xffa40000),
                                          Color(0xff262626)
                                        ],
                                        radius: 4.0,
                                      )),
                                  child: Center(
                                    child: customText.kText(
                                        "See Details",
                                        22,
                                        FontWeight.w700,
                                        Colors.white,
                                        TextAlign.center),
                                  ),
                                ),
                                onTap: () {
                                  // FocusScope.of(context).unfocus();
                                  sideDrawerController.pageIndex.value = 19;
                                  sideDrawerController.ourServiceId = servicesListData[index]["id"];
                                  sideDrawerController.pageController.jumpToPage(19);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}


// const Text(
//   "Lorem ipsum dolor sit amet consectetur adipisicing elit. "
//   "Atque cupiditate cum provident at! Dolorum fuga, deserunt "
//   "est atque excepturi voluptas architecto exercitationem cumque "
//   "delectus iste facilis quaerat in minima totam. Lorem ipsum dolor "
//   "sit amet consectetur adipisicing elit. Nulla eligendi laudantium "
//   "obcaecati numquam quisquam vitae ratione nihil. Quasi laborum tempora "
//   "laboriosam libero aliquam distinctio, sapiente nemo, ex expedita nam "
//   "error! Lorem ipsum dolor sit amet, consectetur adipisicing elit.",
//   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black,
//       fontFamily: "Raleway"), textAlign: TextAlign.start, overflow: TextOverflow.ellipsis,
//   maxLines: 8,
// ),
// GestureDetector(
//   child: Container(
//     height: size.width * 0.13,
//     width: size.width,
//     margin: EdgeInsets.symmetric(vertical: size.width * 0.03, horizontal: size.width * 0.25),
//     decoration: BoxDecoration(
//         color: Colors.black,
//         borderRadius: BorderRadius.circular(size.width * 0.03),
//         gradient: const RadialGradient(
//           center: Alignment(0.19, -0.9),
//           colors: [
//             Color(0xffa40000),
//             Color(0xff262626)
//           ],
//           radius: 4.0,
//         )
//     ),
//     child: Center(
//       child: customText.kText("See Details", 22, FontWeight.w700, Colors.white, TextAlign.center),
//     ),
//   ),
//   onTap: () {
//     FocusScope.of(context).unfocus();
//   },
// ),
// SizedBox(
//   height: size.height * 0.7,
//   width: size.width * 0.95,
//   // color: Colors.grey.shade300,
//   child: Column(
//     children: [
//       Container(
//         height: size.height * 0.05,
//         width: size.width * 0.8,
//         margin: EdgeInsets.symmetric(vertical: size.width * 0.03),
//         decoration: BoxDecoration(
//             border: Border.all(color: Colors.white),
//             borderRadius: BorderRadius.circular(size.width * 0.05),
//             gradient: const LinearGradient(
//                 begin: Alignment.centerLeft,
//                 end: Alignment.centerRight,
//                 colors: [
//                   ColorConstants.kGradientDarkGreen,
//                   ColorConstants.kGradientLightGreen
//                 ]
//             )
//         ),
//         child: Center(
//           child: customText.kText("Our Services", 20, FontWeight.w700, Colors.white, TextAlign.center),
//         ),
//       ),
//       customText.kText("Claim Your Business & Get Started Today!", 20, FontWeight.w700, Colors.black, TextAlign.center),
//       Container(
//         height: size.height * 0.2,
//         width: size.width,
//         margin: EdgeInsets.symmetric(vertical: size.width * 0.03),
//         decoration: BoxDecoration(
//             color: Colors.grey,
//             borderRadius: BorderRadius.circular(size.width * 0.05)
//         ),
//         child: Image.asset("assets/images/cameraImg.png", fit: BoxFit.fill,),
//       ),
//       const Text(
//         "Lorem ipsum dolor sit amet consectetur adipisicing elit. "
//             "Atque cupiditate cum provident at! Dolorum fuga, deserunt "
//             "est atque excepturi voluptas architecto exercitationem cumque "
//             "delectus iste facilis quaerat in minima totam. Lorem ipsum dolor "
//             "sit amet consectetur adipisicing elit. Nulla eligendi laudantium "
//             "obcaecati numquam quisquam vitae ratione nihil. Quasi laborum tempora "
//             "laboriosam libero aliquam distinctio, sapiente nemo, ex expedita nam "
//             "error! Lorem ipsum dolor sit amet, consectetur adipisicing elit.",
//         style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black,
//             fontFamily: "Raleway"), textAlign: TextAlign.start, overflow: TextOverflow.ellipsis,
//         maxLines: 8,
//       ),
//       GestureDetector(
//         child: Container(
//           height: size.width * 0.13,
//           width: size.width,
//           margin: EdgeInsets.symmetric(vertical: size.width * 0.03, horizontal: size.width * 0.25),
//           decoration: BoxDecoration(
//               color: Colors.black,
//               borderRadius: BorderRadius.circular(size.width * 0.03),
//               gradient: const RadialGradient(
//                 center: Alignment(0.19, -0.9),
//                 colors: [
//                   Color(0xffa40000),
//                   Color(0xff262626)
//                 ],
//                 radius: 4.0,
//               )
//           ),
//           child: Center(
//             child: customText.kText("See Details", 22, FontWeight.w700, Colors.white, TextAlign.center),
//           ),
//         ),
//         onTap: () {
//           FocusScope.of(context).unfocus();
//         },
//       ),
//     ],
//   ),
// ),
