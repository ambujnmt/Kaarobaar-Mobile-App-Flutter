import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kaarobaar/constants/color_constants.dart';
import 'package:kaarobaar/controllers/side_drawerController.dart';
import 'package:kaarobaar/services/api_services.dart';
import 'package:kaarobaar/utils/text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  dynamic size;
  int currentIndex = 0;
  final customText = CustomText();
  final api = API();

  SideDrawerController sideDrawerController = Get.put(SideDrawerController());
  bool isApiCalling = false;

  // slider images
  String images = " ";

  // testimonials data
  List<dynamic> featuredListingData = [];

  // popular communities list data
  List<dynamic> popularCommunitiesList = [];
  List<dynamic> homeTopServicesList = [];

// get slider images dashboard
  getSliderImages() async {
    setState(() {
      isApiCalling = true;
    });
    final response = await api.sliderImagesDashboard();
    setState(() {
      images = response['result'][0]['image'];
    });
    setState(() {
      isApiCalling = false;
    });

    print('slider list images ----$images');
  }

  // get popular communities  list
  getPopularCommunities() async {
    setState(() {
      isApiCalling = true;
    });
    final response = await api.popularCommunities();
    setState(() {
      popularCommunitiesList = response['result'];
    });
    setState(() {
      isApiCalling = false;
    });

    print(' get popular communities ----$popularCommunitiesList');
  }

  getHomeTopServices() async {
    setState(() {
      isApiCalling = true;
    });
    final response = await api.homeTopServices();
    setState(() {
      homeTopServicesList = response['result'];
    });
    setState(() {
      isApiCalling = false;
    });
    print('get home top services------- $homeTopServicesList');
  }

  // get featured listing of Dashboard
  getFeatured() async {
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

    print(' get featured ----$featuredListingData');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSliderImages();
    getFeatured();
    getPopularCommunities();
    getHomeTopServices();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          CarouselSlider(
            items: [
              Container(
                margin: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(images),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(images),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(images),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(images),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(images),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
            options: CarouselOptions(
                height: 180.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                viewportFraction: 0.8,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                }),
          ),
          DotsIndicator(
            dotsCount: 5,
            position: currentIndex,
            decorator: const DotsDecorator(
              color: ColorConstants.kIndicatorDots, // Inactive color
              activeColor: ColorConstants.kCircleRed,
            ),
          ),
          Container(
            height: size.height * 0.05,
            width: size.width * 0.8,
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
              child: customText.kText("Popular Categories", 20, FontWeight.w700,
                  Colors.white, TextAlign.center),
            ),
          ),
          popularCommunitiesList.isEmpty
              ? Container()
              : GestureDetector(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(right: 5, top: 2, bottom: 2),
                        child: customText.kText("View All", 16, FontWeight.w700,
                            ColorConstants.kIconsGrey, TextAlign.center),
                      )),
                  onTap: () {
                    sideDrawerController.pageIndex.value = 15;
                    sideDrawerController.pageController.jumpToPage(15);
                  },
                ),
          popularCommunitiesList.isEmpty
              ? Container(
                  height: size.height * 0.25,
                  width: size.width,
                  child: Center(
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
                  ),
                )
              : SizedBox(
                  height: size.height * 0.25,
                  width: size.width,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: popularCommunitiesList.length >= 4
                        ? 4
                        : popularCommunitiesList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          sideDrawerController.pageIndex.value = 29;
                          sideDrawerController.communityByCategoryId =
                              popularCommunitiesList[index]["id"];
                          sideDrawerController.pageController.jumpToPage(29);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 20, left: 20),
                          height: size.width * 0.2,
                          width: size.width * 0.5,
                          child: Column(
                            children: [
                              Container(
                                height: size.width * 0.4,
                                width: size.width * 0.5,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(
                                    size.width * 0.05,
                                  ),
                                ),
                                child: popularCommunitiesList[index]['image']
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
                                        "${popularCommunitiesList[index]['image'].toString()}",
                                        fit: BoxFit.fill,
                                      ),
                              ),
                              customText.kText(
                                  "${popularCommunitiesList[index]['category_name'].toString()}",
                                  16,
                                  FontWeight.w900,
                                  Colors.black,
                                  TextAlign.center),
                              customText.kText(
                                  "${popularCommunitiesList[index]['listing'].toString()} Listing",
                                  16,
                                  FontWeight.w400,
                                  Colors.black,
                                  TextAlign.center)
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
          Container(
            height: size.height * 0.05,
            width: size.width * 0.8,
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
              child: customText.kText("Top Services", 20, FontWeight.w700,
                  Colors.white, TextAlign.center),
            ),
          ),
          homeTopServicesList.isEmpty
              ? Container(
                  height: size.height * 0.25,
                  width: size.width,
                  child: Center(
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
                  ),
                )
              : GestureDetector(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(right: 5, top: 2, bottom: 2),
                        child: customText.kText("View All", 16, FontWeight.w700,
                            ColorConstants.kIconsGrey, TextAlign.center),
                      )),
                  onTap: () {
                    sideDrawerController.pageIndex.value = 28;
                    sideDrawerController.pageController.jumpToPage(28);
                  },
                ),
          SizedBox(
            height: size.height * 0.25,
            width: size.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: homeTopServicesList.length >= 4
                  ? 4
                  : homeTopServicesList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    sideDrawerController.pageIndex.value = 31;
                    sideDrawerController.topServicesDetailId =
                        homeTopServicesList[index]["id"];
                    sideDrawerController.pageController.jumpToPage(31);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 20, left: 20),
                    height: size.width * 0.2,
                    width: size.width * 0.5,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 2),
                          height: size.width * 0.4,
                          width: size.width * 0.5,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(
                              size.width * 0.05,
                            ),
                          ),
                          child: homeTopServicesList[index]['featured_image']
                                      .toString() ==
                                  ""
                              ? Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: const DecorationImage(
                                      image: AssetImage(
                                        'assets/images/no_image.jpeg',
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                )
                              : Image.network(
                                  "${homeTopServicesList[index]['featured_image'].toString()}",
                                  fit: BoxFit.fill,
                                ),
                        ),
                        customText.kText(
                            "${homeTopServicesList[index]['business_title'].toString()}",
                            16,
                            FontWeight.w900,
                            Colors.black,
                            TextAlign.center),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            height: size.height * 0.05,
            width: size.width * 0.8,
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
              child: customText.kText("Featured Listing", 20, FontWeight.w700,
                  Colors.white, TextAlign.center),
            ),
          ),
          featuredListingData.isEmpty
              ? Container(
                  height: size.height * 0.25,
                  width: size.width,
                  child: Center(
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
                  ),
                )
              : GestureDetector(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(right: 5, top: 2, bottom: 2),
                        child: customText.kText("View All", 16, FontWeight.w700,
                            ColorConstants.kIconsGrey, TextAlign.center),
                      )),
                  onTap: () {
                    sideDrawerController.pageIndex.value = 32;
                    sideDrawerController.pageController.jumpToPage(32);
                  },
                ),
          Container(
            height: size.height * 0.32,
            width: size.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: featuredListingData.length >= 4
                  ? 4
                  : featuredListingData.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    sideDrawerController.pageIndex.value = 33;
                    sideDrawerController.featuredDetailId =
                        featuredListingData[index]["id"];
                    sideDrawerController.pageController.jumpToPage(33);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    height: size.width * 0.2,
                    width: size.width * 0.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 2),
                          height: size.width * 0.4,
                          width: size.width * 0.5,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(
                              size.width * 0.05,
                            ),
                          ),
                          child: featuredListingData[index]['featured_image']
                                      .toString() ==
                                  ""
                              ? Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
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
                          margin: const EdgeInsets.only(left: 10),
                          child: customText.kText(
                            "${featuredListingData[index]['business_title'].toString()}",
                            16,
                            FontWeight.w900,
                            Colors.black,
                            TextAlign.start,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.location_on_rounded,
                                color: Colors.green,
                              ),
                              const SizedBox(width: 10),
                              Container(
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
                          margin: const EdgeInsets.only(left: 10),
                          height: 50,
                          child: customText.kText(
                            "${featuredListingData[index]['business_description'].toString()}",
                            16,
                            FontWeight.w900,
                            Colors.black,
                            TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Image.asset("assets/images/caraousalImg1.png"),
          SizedBox(
            height: size.height * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: size.height * 0.2,
                width: size.width * 0.4,
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                child: Center(
                  child: Image.asset("assets/images/logo.png"),
                ),
              ),
              Container(
                  height: size.height * 0.2,
                  width: size.width * 0.6,
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                  // color: Colors.yellow,
                  // decoration: BoxDecoration(
                  //   color: Colors.yellow
                  // ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              height: size.width * 0.08,
                              child: Image.asset("assets/images/map.png")),
                          SizedBox(
                              width: size.width * 0.45,
                              child: customText.kText(
                                  "Office 24 Brentham Old Power Station, Western Avenue "
                                  "LONDON - W5 1HS United Kingdom (GB)",
                                  13,
                                  FontWeight.w500,
                                  Colors.black,
                                  TextAlign.start))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              height: size.width * 0.08,
                              child: Image.asset("assets/images/call.png")),
                          SizedBox(
                            width: size.width * 0.45,
                            child: customText.kText("07970999007", 13,
                                FontWeight.w500, Colors.black, TextAlign.start),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              height: size.width * 0.08,
                              child: Image.asset("assets/images/email.png")),
                          SizedBox(
                            width: size.width * 0.45,
                            child: customText.kText("Info@Kaarobaar.co.uk", 13,
                                FontWeight.w500, Colors.black, TextAlign.start),
                          )
                        ],
                      ),
                    ],
                  )),
            ],
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
        ],
      ),
    ));
  }
}
