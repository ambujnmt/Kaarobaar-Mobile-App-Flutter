import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaarobaar/constants/color_constants.dart';
import 'package:kaarobaar/controllers/side_drawerController.dart';
import 'package:kaarobaar/services/api_services.dart';
import 'package:kaarobaar/utils/text.dart';
import 'package:url_launcher/url_launcher.dart';

class PopularCommunitiesDetails extends StatefulWidget {
  const PopularCommunitiesDetails({super.key});

  @override
  State<PopularCommunitiesDetails> createState() =>
      _PopularCommunitiesDetailsState();
}

class _PopularCommunitiesDetailsState extends State<PopularCommunitiesDetails> {
  dynamic size;
  final customText = CustomText();
  List<dynamic> communityByCategoryData = [];
  bool isApiCalling = false;
  final api = API();

  SideDrawerController sideDrawerController = Get.put(SideDrawerController());

  // get popular communities  list
  communityByCategory() async {
    setState(() {
      isApiCalling = true;
    });
    final response = await api
        .allCommunityByCategory(sideDrawerController.communityByCategoryId);
    setState(() {
      communityByCategoryData = response['result'];
    });
    setState(() {
      isApiCalling = false;
    });

    print(' get popular communities by category ----$communityByCategoryData');
  }

  // Function to initiate the phone call
  _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    communityByCategory();
    print(
        'communities by category list ${sideDrawerController.communityByCategoryId}');
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: isApiCalling
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : communityByCategoryData.isEmpty
              ? Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8)),
                    height: 50,
                    width: size.width * .400,
                    child: Center(
                      child: customText.kText("No data found", 15,
                          FontWeight.w700, Colors.black, TextAlign.center),
                    ),
                  ),
                )
              : Container(
                  margin: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: size.height * 0.05,
                          width: size.width * 0.8,
                          margin:
                              EdgeInsets.symmetric(vertical: size.width * 0.05),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius:
                                  BorderRadius.circular(size.width * 0.05),
                              gradient: const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    ColorConstants.kGradientDarkGreen,
                                    ColorConstants.kGradientLightGreen
                                  ])),
                          child: Center(
                            child: customText.kText(
                                "Popular Communities",
                                20,
                                FontWeight.w700,
                                Colors.white,
                                TextAlign.center),
                          ),
                        ),
                        Container(
                            height: size.height * 0.67,
                            width: size.width,
                            // color: Colors.grey.shade400,
                            child: GridView.builder(
                                padding: EdgeInsets.zero,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 5.0,
                                  mainAxisSpacing: 5.0,
                                  childAspectRatio: 1 / 1.8,
                                  // childAspectRatio: 1 / 1.4,
                                ),
                                itemCount: communityByCategoryData.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      sideDrawerController.pageIndex.value = 30;
                                      sideDrawerController.detailTwoId =
                                          communityByCategoryData[index]["id"];
                                      sideDrawerController.pageController
                                          .jumpToPage(30);
                                    },
                                    child: Container(
                                      // margin: EdgeInsets.all(size.width * 0.02),
                                      padding:
                                          EdgeInsets.all(size.width * 0.02),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: ColorConstants
                                                  .kIndicatorDots),
                                          borderRadius: BorderRadius.circular(
                                              size.width * 0.03)),
                                      child: Column(
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: size.width * 0.38,
                                            width: size.width * 0.38,
                                            margin: EdgeInsets.only(
                                                bottom: size.width * 0.02),
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade800,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        size.width * 0.03)),
                                            child: communityByCategoryData[
                                                                index]
                                                            ['featured_image']
                                                        .toString() ==
                                                    ""
                                                ? Center(
                                                    child: customText.kText(
                                                        "No image",
                                                        20,
                                                        FontWeight.w700,
                                                        Colors.white,
                                                        TextAlign.center),
                                                  )
                                                : Image.network(
                                                    "${communityByCategoryData[index]['featured_image'].toString()}",
                                                    fit: BoxFit.fill,
                                                  ),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.45,
                                            height: size.width * 0.09,
                                            child: customText.kText(
                                                "${communityByCategoryData[index]['business_title'].toString()}",
                                                15,
                                                FontWeight.w700,
                                                Colors.black,
                                                TextAlign.center),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.45,
                                            height: size.width * 0.09,
                                            child: customText.kText(
                                                "${communityByCategoryData[index]['business_description'].toString()}",
                                                15,
                                                FontWeight.w400,
                                                Colors.black,
                                                TextAlign.center),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: size.width * 0.07,
                                                child: Image.asset(
                                                    "assets/images/map.png"),
                                              ),
                                              SizedBox(
                                                  width: size.width * 0.33,
                                                  // height: size.height * 0.09,
                                                  child: customText.kText(
                                                      "${communityByCategoryData[index]['address'].toString()}",
                                                      13,
                                                      FontWeight.w500,
                                                      Colors.black,
                                                      TextAlign.left))
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          GestureDetector(
                                            onTap: () {
                                              // place your make phone call
                                              _makePhoneCall(
                                                  '${communityByCategoryData[index]['mobile'].toString()}');
                                            },
                                            child: Container(
                                              height: size.height * 0.05,
                                              width: size.width * 0.8,
                                              // margin: EdgeInsets.symmetric(vertical: size.width * 0.02),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      size.width * 0.02),
                                              decoration: BoxDecoration(
                                                  // border: Border.all(color: Colors.white),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          size.width * 0.02),
                                                  gradient:
                                                      const LinearGradient(
                                                          begin: Alignment
                                                              .centerLeft,
                                                          end:
                                                              Alignment
                                                                  .centerRight,
                                                          colors: [
                                                        ColorConstants
                                                            .kGradientDarkGreen,
                                                        ColorConstants
                                                            .kGradientLightGreen
                                                      ])),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  customText.kText(
                                                      "${communityByCategoryData[index]['category_name'].toString()}",
                                                      14,
                                                      FontWeight.w700,
                                                      Colors.white,
                                                      TextAlign.center),
                                                  CircleAvatar(
                                                    radius: size.width * 0.042,
                                                    child: SizedBox(
                                                        height:
                                                            size.width * 0.055,
                                                        child: Image.asset(
                                                            "assets/images/call.png")),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }))
                      ],
                    ),
                  ),
                ),
    );
  }
}
