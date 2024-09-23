import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kaarobaar/constants/color_constants.dart';
import 'package:kaarobaar/controllers/side_drawerController.dart';
import 'package:kaarobaar/utils/text.dart';
import 'package:kaarobaar/views/screens/about_us.dart';
import 'package:kaarobaar/views/screens/add_business.dart';
import 'package:kaarobaar/views/screens/add_event.dart';
import 'package:kaarobaar/views/screens/advertise_withUs.dart';
import 'package:kaarobaar/views/screens/advertisement_details.dart';
import 'package:kaarobaar/views/screens/blog_detail_screen.dart';
import 'package:kaarobaar/views/screens/blogs_screen.dart';
import 'package:kaarobaar/views/screens/category.dart';
import 'package:kaarobaar/views/screens/change_password.dart';
import 'package:kaarobaar/views/screens/contact_admin.dart';
import 'package:kaarobaar/views/screens/dashboard_screen.dart';
import 'package:kaarobaar/views/screens/events_screen.dart';
import 'package:kaarobaar/views/screens/faq_screen.dart';
import 'package:kaarobaar/views/screens/my_account.dart';
import 'package:kaarobaar/views/screens/my_business.dart';
import 'package:kaarobaar/views/screens/offers_detail.dart';
import 'package:kaarobaar/views/screens/our_services_detail.dart';
import 'package:kaarobaar/views/screens/popular_commuitites.dart';
import 'package:kaarobaar/views/screens/privacy_policy.dart';
import 'package:kaarobaar/views/screens/search_screen.dart';
import 'package:kaarobaar/views/screens/special_offers.dart';
import 'package:kaarobaar/views/screens/terms_coditions.dart';
import 'package:kaarobaar/views/screens/testimonials_screen.dart';

class SideMenuDrawer extends StatefulWidget {
  const SideMenuDrawer({super.key});

  @override
  State<SideMenuDrawer> createState() => _SideMenuDrawerState();
}

class _SideMenuDrawerState extends State<SideMenuDrawer> {
  dynamic size;
  final customText = CustomText();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  SideDrawerController sideDrawerController = Get.put(SideDrawerController());

  // @override
  // void initState() {
  //   super.initState();
  //   pageController.jumpToPage(0);
  // }

  customDrawer() {
    return Container(
      height: size.height,
      width: size.width,
      color: Colors.yellow.shade200,
      child: Stack(
        children: [
          Container(
              height: size.height * 0.25,
              width: size.width,
              padding: EdgeInsets.fromLTRB(
                  size.width * 0.03, 0, size.width * 0.03, 0),
              decoration: const BoxDecoration(
                  gradient: RadialGradient(
                center: Alignment(0.25, -2.5),
                colors: [Color(0xffa40000), Color(0xff262626)],
                radius: 2.1,
              )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.12,
                    width: size.width * 0.8,
                    child: Row(
                      children: [
                        Container(
                          height: size.width * 0.25,
                          padding: EdgeInsets.all(size.width * 0.01),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset("assets/images/sampleGirl.png"),
                        ),
                        SizedBox(width: size.width * 0.02),
                        Expanded(
                          child: customText.kText("Lucifer", 30,
                              FontWeight.w900, Colors.white, TextAlign.start),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    child: SizedBox(
                      height: size.height * 0.12,
                      width: size.width * 0.11,
                      child: Align(
                          alignment: Alignment.topCenter,
                          child: Image.asset("assets/images/reply.png")),
                    ),
                    onTap: () {
                      sideDrawerController.pageIndex.value = 0;
                      sideDrawerController.pageController.jumpToPage(0);
                      scaffoldKey.currentState!.closeEndDrawer();
                    },
                  )
                ],
              )),
          Positioned(
            top: size.height * 0.22,
            child: Container(
              height: size.height,
              width: size.width,
              padding: EdgeInsets.fromLTRB(size.width * 0.05, size.width * 0.15,
                  size.width * 0.05, size.width * 0.02),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(size.width * 0.05),
                    topRight: Radius.circular(size.width * 0.05),
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    child: SizedBox(
                      height: size.height * 0.05,
                      child: customText.kText("Add a Business", 22,
                          FontWeight.w700, Colors.black, TextAlign.start),
                    ),
                    onTap: () {
                      sideDrawerController.pageIndex.value = 2;
                      sideDrawerController.pageController.jumpToPage(2);
                      scaffoldKey.currentState!.closeEndDrawer();
                    },
                  ),
                  GestureDetector(
                    child: SizedBox(
                      height: size.height * 0.05,
                      child: customText.kText("My Business", 22,
                          FontWeight.w700, Colors.black, TextAlign.start),
                    ),
                    onTap: () {
                      sideDrawerController.pageIndex.value = 22;
                      sideDrawerController.pageController.jumpToPage(22);
                      scaffoldKey.currentState!.closeEndDrawer();
                    },
                  ),
                  GestureDetector(
                    child: SizedBox(
                      height: size.height * 0.05,
                      child: customText.kText("Advertise With Us", 22,
                          FontWeight.w700, Colors.black, TextAlign.start),
                    ),
                    onTap: () {
                      sideDrawerController.pageIndex.value = 3;
                      sideDrawerController.pageController.jumpToPage(3);
                      scaffoldKey.currentState!.closeEndDrawer();
                    },
                  ),
                  GestureDetector(
                    child: SizedBox(
                      height: size.height * 0.05,
                      child: customText.kText("Categories", 22, FontWeight.w700,
                          Colors.black, TextAlign.start),
                    ),
                    onTap: () {
                      sideDrawerController.pageIndex.value = 4;
                      sideDrawerController.pageController.jumpToPage(4);
                      scaffoldKey.currentState!.closeEndDrawer();
                    },
                  ),
                  GestureDetector(
                    child: SizedBox(
                      height: size.height * 0.05,
                      child: customText.kText("Add Events", 22, FontWeight.w700,
                          Colors.black, TextAlign.start),
                    ),
                    onTap: () {
                      sideDrawerController.pageIndex.value = 17;
                      sideDrawerController.pageController.jumpToPage(17);
                      scaffoldKey.currentState!.closeEndDrawer();
                    },
                  ),
                  GestureDetector(
                    child: SizedBox(
                      height: size.height * 0.05,
                      child: customText.kText("Events", 22, FontWeight.w700,
                          Colors.black, TextAlign.start),
                    ),
                    onTap: () {
                      sideDrawerController.pageIndex.value = 5;
                      sideDrawerController.pageController.jumpToPage(5);
                      scaffoldKey.currentState!.closeEndDrawer();
                    },
                  ),
                  GestureDetector(
                    child: SizedBox(
                      height: size.height * 0.05,
                      child: customText.kText("About Us", 22, FontWeight.w700,
                          Colors.black, TextAlign.start),
                    ),
                    onTap: () {
                      sideDrawerController.pageIndex.value = 6;
                      sideDrawerController.pageController.jumpToPage(6);
                      scaffoldKey.currentState!.closeEndDrawer();
                    },
                  ),
                  GestureDetector(
                    child: SizedBox(
                      height: size.height * 0.05,
                      child: customText.kText("Special Offers", 22,
                          FontWeight.w700, Colors.black, TextAlign.start),
                    ),
                    onTap: () {
                      sideDrawerController.pageIndex.value = 7;
                      sideDrawerController.pageController.jumpToPage(7);
                      scaffoldKey.currentState!.closeEndDrawer();
                    },
                  ),
                  GestureDetector(
                    child: SizedBox(
                      height: size.height * 0.05,
                      child: customText.kText("Blogs", 22, FontWeight.w700,
                          Colors.black, TextAlign.start),
                    ),
                    onTap: () {
                      sideDrawerController.pageIndex.value = 8;
                      sideDrawerController.pageController.jumpToPage(8);
                      scaffoldKey.currentState!.closeEndDrawer();
                    },
                  ),
                  GestureDetector(
                    child: SizedBox(
                      height: size.height * 0.05,
                      child: customText.kText("FAQ", 22, FontWeight.w700,
                          Colors.black, TextAlign.start),
                    ),
                    onTap: () {
                      sideDrawerController.pageIndex.value = 9;
                      sideDrawerController.pageController.jumpToPage(9);
                      scaffoldKey.currentState!.closeEndDrawer();
                    },
                  ),
                  GestureDetector(
                    child: SizedBox(
                      height: size.height * 0.05,
                      child: customText.kText("Testimonials", 22,
                          FontWeight.w700, Colors.black, TextAlign.start),
                    ),
                    onTap: () {
                      sideDrawerController.pageIndex.value = 10;
                      sideDrawerController.pageController.jumpToPage(10);
                      scaffoldKey.currentState!.closeEndDrawer();
                    },
                  ),
                  GestureDetector(
                    child: SizedBox(
                      height: size.height * 0.05,
                      child: customText.kText("Terms & Conditions", 22,
                          FontWeight.w700, Colors.black, TextAlign.start),
                    ),
                    onTap: () {
                      sideDrawerController.pageIndex.value = 11;
                      sideDrawerController.pageController.jumpToPage(11);
                      scaffoldKey.currentState!.closeEndDrawer();
                    },
                  ),
                  GestureDetector(
                    child: SizedBox(
                      height: size.height * 0.05,
                      child: customText.kText("Privacy Policy", 22,
                          FontWeight.w700, Colors.black, TextAlign.start),
                    ),
                    onTap: () {
                      sideDrawerController.pageIndex.value = 12;
                      sideDrawerController.pageController.jumpToPage(12);
                      scaffoldKey.currentState!.closeEndDrawer();
                    },
                  ),
                  GestureDetector(
                    child: SizedBox(
                      height: size.height * 0.05,
                      child: customText.kText("Contact Admin ", 22,
                          FontWeight.w700, Colors.black, TextAlign.start),
                    ),
                    onTap: () {
                      sideDrawerController.pageIndex.value = 13;
                      sideDrawerController.pageController.jumpToPage(13);
                      scaffoldKey.currentState!.closeEndDrawer();
                    },
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.2,
            left: size.width / 3.5,
            child: GestureDetector(
              child: Container(
                height: size.height * 0.05,
                width: size.width * 0.45,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(size.width * 0.05),
                    gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          ColorConstants.kGradientDarkGreen,
                          ColorConstants.kGradientLightGreen
                        ]),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0, 3),
                          color: Colors.grey.shade400,
                          spreadRadius: 1,
                          blurRadius: 2)
                    ]),
                child: Center(
                  child: customText.kText("My Account", 25, FontWeight.w900,
                      Colors.white, TextAlign.center),
                ),
              ),
              onTap: () {
                sideDrawerController.pageIndex.value = 1;
                sideDrawerController.pageController.jumpToPage(1);
                scaffoldKey.currentState!.closeEndDrawer();
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      endDrawer: customDrawer(),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            Container(
                height: size.height * 0.2,
                width: size.width,
                padding: EdgeInsets.fromLTRB(
                    size.width * 0.03, size.width * 0.12, size.width * 0.03, 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(size.width * 0.05),
                      bottomRight: Radius.circular(size.width * 0.05),
                    ),
                    gradient: const RadialGradient(
                      center: Alignment(0.25, -2.5),
                      colors: [Color(0xffa40000), Color(0xff262626)],
                      radius: 2.1,
                    )),
                child: Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          child: const Icon(
                            Icons.list_rounded,
                            color: Colors.white,
                            size: 40,
                          ),
                          onTap: () {
                            scaffoldKey.currentState!.openEndDrawer();
                          },
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: size.width * 0.075),
                          height: size.height * 0.03,
                          child: Image.asset("assets/images/whiteLogoText.png"),
                        ),
                        Obx(() => sideDrawerController.pageIndex != 0
                            ? GestureDetector(
                                child: SizedBox(
                                  height: size.height * 0.05,
                                  width: size.width * 0.11,
                                  // color: Colors.blue,
                                  child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Image.asset(
                                          "assets/images/reply.png")),
                                ),
                                onTap: () {
                                  sideDrawerController.pageIndex.value = 0;
                                  sideDrawerController.pageController
                                      .jumpToPage(0);
                                },
                              )
                            : const SizedBox())
                      ],
                    ),
                    SizedBox(
                      height: size.width * 0.02,
                    ),
                    Obx(() => sideDrawerController.pageIndex == 0 ||
                            sideDrawerController.pageIndex == 4 ||
                            sideDrawerController.pageIndex == 7 ||
                            sideDrawerController.pageIndex == 8 ||
                            sideDrawerController.pageIndex == 9 ||
                            sideDrawerController.pageIndex == 10 ||
                            sideDrawerController.pageIndex == 11 ||
                            sideDrawerController.pageIndex == 12 ||
                            sideDrawerController.pageIndex == 13 ||
                            sideDrawerController.pageIndex == 14 ||
                            sideDrawerController.pageIndex == 15 ||
                            sideDrawerController.pageIndex == 16
                        ? GestureDetector(
                            child: Container(
                              height: size.height * 0.06,
                              width: size.width * 0.8,
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.02),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.circular(size.width * 0.03)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  customText.kText(
                                      "Search",
                                      20,
                                      FontWeight.w700,
                                      ColorConstants.kTextGrey,
                                      TextAlign.left),
                                  const Icon(Icons.search,
                                      size: 30, color: ColorConstants.kTextGrey)
                                ],
                              ),
                            ),
                            onTap: () {
                              sideDrawerController.pageIndex.value = 16;
                              sideDrawerController.pageController
                                  .jumpToPage(16);
                            })
                        : const SizedBox())
                  ],
                )),
            Expanded(
              child: Container(
                  color: Colors.grey.shade400,
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: sideDrawerController.pageController,
                    children: const [
                      DashboardScreen(),
                      MyAccount(),
                      AddBusiness(),
                      AdvertiseWithUs(),
                      Categories(),
                      Events(),
                      AboutUs(),
                      SpecialOffers(),
                      Blogs(),
                      FAQ(),
                      Testimonials(),
                      TermsConditions(),
                      PrivacyPolicy(),
                      ContactAdmin(),
                      ChangePassword(),
                      PopularCommunities(),
                      SearchScreen(),
                      AddEvent(),
                      AdvertisementDetails(),
                      OurServicesDetail(), // page number 19
                      BlogDetailScreen(),
                      OffersDetail(),
                      MyBusiness(), // page number 22
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
