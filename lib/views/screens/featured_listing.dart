import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaarobaar/constants/color_constants.dart';
import 'package:kaarobaar/controllers/side_drawerController.dart';
import 'package:kaarobaar/services/api_services.dart';
import 'package:kaarobaar/utils/text.dart';

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
                              childAspectRatio: 1 / 1.4,
                            ),
                            itemCount: featuredListingData.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  // sideDrawerController.pageIndex.value = 31;
                                  // sideDrawerController.topServicesDetailId =
                                  //     featuredListingData[index]["id"];
                                  // sideDrawerController.pageController
                                  //     .jumpToPage(31);
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
                                    // crossAxisAlignment: CrossAxisAlignment.start,
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
                                                        ['image']
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
                                                "${featuredListingData[index]['image'].toString()}",
                                                fit: BoxFit.fill,
                                              ),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.45,
                                        // height: size.width * 0.09,
                                        child: customText.kText(
                                            "${featuredListingData[index]['category_name'].toString()}",
                                            15,
                                            FontWeight.w700,
                                            Colors.black,
                                            TextAlign.center),
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
