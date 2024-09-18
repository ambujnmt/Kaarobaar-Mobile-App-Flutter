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
  List<dynamic> testimonialsList = [];

  // popular communities list data
  List<dynamic> popularCommunitiesList = [];

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

    print(' slider list images ----$images');
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

  // get testimonials of Dashboard
  getTestimonials() async {
    setState(() {
      isApiCalling = true;
    });
    final response = await api.testimonialsDashboard();
    setState(() {
      testimonialsList = response['result'];
    });
    setState(() {
      isApiCalling = false;
    });

    print(' get testimonials ----$testimonialsList');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSliderImages();
    getTestimonials();
    getPopularCommunities();
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
              child: customText.kText("Popular Communities", 20,
                  FontWeight.w700, Colors.white, TextAlign.center),
            ),
          ),
          GestureDetector(
            child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 5, top: 2, bottom: 2),
                  child: customText.kText("View All", 16, FontWeight.w700,
                      ColorConstants.kIconsGrey, TextAlign.center),
                )),
            onTap: () {
              sideDrawerController.pageIndex.value = 15;
              sideDrawerController.pageController.jumpToPage(15);
            },
          ),
          SizedBox(
            height: size.height * 0.25,
            width: size.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: popularCommunitiesList.length >= 4
                  ? 4
                  : popularCommunitiesList.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  height: size.width * 0.2,
                  width: size.width * 0.5,
                  child: Column(
                    children: [
                      Container(
                        height: size.width * 0.4,
                        width: size.width * 0.4,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(
                            size.width * 0.05,
                          ),
                        ),
                        child:
                            popularCommunitiesList[index]['image'].toString() ==
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
                          "${popularCommunitiesList[index]['content'].toString()}",
                          16,
                          FontWeight.w400,
                          Colors.black,
                          TextAlign.center)
                    ],
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
              child: customText.kText("Testimonials", 20, FontWeight.w700,
                  Colors.white, TextAlign.center),
            ),
          ),
          GestureDetector(
            child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 5, top: 2, bottom: 2),
                  child: customText.kText("View All", 16, FontWeight.w700,
                      ColorConstants.kIconsGrey, TextAlign.center),
                )),
            onTap: () {
              sideDrawerController.pageIndex.value = 10;
              sideDrawerController.pageController.jumpToPage(10);
            },
          ),
          Container(
            height: size.height * 0.35,
            width: size.width,
            padding: EdgeInsets.only(top: size.width * 0.01),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount:
                  testimonialsList.length >= 4 ? 4 : testimonialsList.length,
              itemBuilder: (context, index) {
                return Container(
                  height: size.width * 0.35,
                  width: size.width * 0.5,
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                  // color: Colors.grey,
                  child: Column(
                    children: [
                      Container(
                        height: size.width * 0.35,
                        width: size.width * 0.35,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  ColorConstants.kTestimonialsDarkRed,
                                  ColorConstants.kTestimonialsLightRed,
                                ])),
                        child: Container(
                          margin: EdgeInsets.all(size.width * 0.015),
                          padding: EdgeInsets.all(size.width * 0.01),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 3),
                              borderRadius:
                                  BorderRadius.circular(size.width * 0.5),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "${testimonialsList[index]['img'].toString()}"),
                                  fit: BoxFit.fill)),
                          // child: Image.network("https://s3-alpha-sig.figma.com/img/6d87/6fab/4374e1c546bc9a8ed00585d8f1de4efe?Expires=1722211200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=bTVVRzfzlLfnc1c4yWIJmpih7PBddA-AVNBxWYkeHRoQjaiHkXHRzFs7l2cTbj1FrZofzQuF3x51MHfrScbxtdvEI81-tOYIayc1GodmAIpKZJm3eSIsshj3NbV7oIyAvFmEG5r35BUAWLW-RwlQSBBVSzoL0vXwHit9N9GyNPyUrZ0A0sB3NRQRJXRo~6~KDfjMEii--yrpZuyFsZ2LSayFHQtW~WQrr3zQWatDSMAvGra2jY~vQa7GlAU2FWGOR1J4zA~j1qD4wh8GSd5sREXBCAayP-wVxO3kwpdP719wITEqzEzBLwgRNhhsURoRZRKP6ILO6HOy4tbsrFB~NA__", fit: BoxFit.fill,),
                        ),
                      ),
                      customText.kText(
                          "${testimonialsList[index]['name'].toString()}",
                          16,
                          FontWeight.w900,
                          Colors.black,
                          TextAlign.center),
                      customText.kText(
                          "${testimonialsList[index]['position'].toString()}",
                          16,
                          FontWeight.w900,
                          Colors.black,
                          TextAlign.center),
                      Text(
                        "${testimonialsList[index]['description'].toString()}",
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontFamily: "Raleway"),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                        textAlign: TextAlign.start,
                      )
                      // customText.kText("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.", 10, FontWeight.w400, Colors.black, TextAlign.center)
                    ],
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
