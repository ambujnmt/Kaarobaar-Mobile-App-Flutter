import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaarobaar/constants/color_constants.dart';
import 'package:kaarobaar/controllers/side_drawerController.dart';
import 'package:kaarobaar/services/api_services.dart';
import 'package:kaarobaar/utils/text.dart';
import 'package:url_launcher/url_launcher.dart';

class FeaturedScreen extends StatefulWidget {
  const FeaturedScreen({super.key});

  @override
  State<FeaturedScreen> createState() => _FeaturedScreenState();
}

class _FeaturedScreenState extends State<FeaturedScreen> {
  dynamic size;
  final customText = CustomText();
  List<dynamic> featuredListingData = [];
  bool isApiCalling = false;
  final api = API();
  SideDrawerController sideDrawerController = Get.put(SideDrawerController());

  // get  all featured listing
  getFeaturedAllList() async {
    setState(() {
      isApiCalling = true;
    });
    final response = await api.featuredListingDashboard();
    setState(() {
      featuredListingData = response['result'];
    });
    setState(() {
      isApiCalling = false;
    });

    print(' get all featured list ----$featuredListingData');
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
    getFeaturedAllList();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: isApiCalling
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : featuredListingData.isEmpty
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
                                "Featured Listing",
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
                              // childAspectRatio: 1 / 1.8,
                              childAspectRatio: 1 / 1.9,
                            ),
                            itemCount: featuredListingData.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  // sideDrawerController.pageIndex.value = 33;
                                  // sideDrawerController.featuredDetailId =
                                  //     featuredListingData[index]["id"];
                                  // sideDrawerController.pageController
                                  //     .jumpToPage(33);
                                },
                                child: Container(
                                  // margin: EdgeInsets.all(size.width * 0.02),
                                  padding: EdgeInsets.all(size.width * 0.02),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: ColorConstants.kIndicatorDots),
                                      borderRadius: BorderRadius.circular(
                                          size.width * 0.03)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: size.width * 0.38,
                                        width: size.width * 0.38,
                                        margin: EdgeInsets.only(
                                            bottom: size.width * 0.02),
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade800,
                                            borderRadius: BorderRadius.circular(
                                                size.width * 0.03)),
                                        child: featuredListingData[index]
                                                        ['featured_image']
                                                    .toString() ==
                                                ""
                                            ? Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  image: const DecorationImage(
                                                    image: AssetImage(
                                                      'assets/images/no_image.jpeg',
                                                    ),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              )
                                            : Image.network(
                                                "${featuredListingData[index]['featured_image'].toString()}",
                                                fit: BoxFit.fill,
                                              ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(left: 12),
                                        width: size.width * 0.45,
                                        // height: size.width * 0.09,
                                        child: customText.kText(
                                          "${featuredListingData[index]['business_title'].toString()}",
                                          15,
                                          FontWeight.w700,
                                          Colors.black,
                                          TextAlign.start,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Container(
                                        margin: const EdgeInsets.only(left: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Icon(
                                              Icons.location_on_rounded,
                                              color: Colors.green,
                                            ),
                                            const SizedBox(width: 10),
                                            Container(
                                              width: size.width * .2,
                                              child: customText.kText(
                                                "${featuredListingData[index]['address'].toString()}",
                                                16,
                                                FontWeight.w900,
                                                Colors.black,
                                                TextAlign.start,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 10, bottom: 10),
                                        height: 50,
                                        child: customText.kText(
                                          "${featuredListingData[index]['business_description'].toString()}",
                                          16,
                                          FontWeight.w900,
                                          Colors.black,
                                          TextAlign.start,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          // place your make phone call
                                          _makePhoneCall(
                                              '${featuredListingData[index]['mobile'].toString()}');
                                        },
                                        child: Container(
                                          height: size.height * 0.05,
                                          width: size.width * 0.8,
                                          // margin: EdgeInsets.symmetric(vertical: size.width * 0.02),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: size.width * 0.02),
                                          decoration: BoxDecoration(
                                              // border: Border.all(color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      size.width * 0.02),
                                              gradient: const LinearGradient(
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                  colors: [
                                                    ColorConstants
                                                        .kGradientDarkGreen,
                                                    ColorConstants
                                                        .kGradientLightGreen
                                                  ])),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              customText.kText(
                                                  "${featuredListingData[index]['category_name'].toString()}",
                                                  14,
                                                  FontWeight.w700,
                                                  Colors.white,
                                                  TextAlign.center),
                                              CircleAvatar(
                                                radius: size.width * 0.042,
                                                child: SizedBox(
                                                    height: size.width * 0.055,
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
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
    );
  }
}
