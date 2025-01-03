import 'package:flutter/material.dart';
import 'package:kaarobaar/constants/color_constants.dart';
import 'package:kaarobaar/controllers/business_controllers.dart';
import 'package:kaarobaar/controllers/side_drawerController.dart';
import 'package:kaarobaar/services/api_services.dart';
import 'package:kaarobaar/utils/text.dart';
import 'package:get/get.dart';

class MyBusiness extends StatefulWidget {
  const MyBusiness({super.key});

  @override
  State<MyBusiness> createState() => _MyBusinessState();
}

class _MyBusinessState extends State<MyBusiness> {
  dynamic size;
  final customText = CustomText();
  List<dynamic> myBusinessListData = [];
  bool isApiCalling = false;
  final api = API();
  SideDrawerController sideDrawerController = Get.put(SideDrawerController());
  BusinessController businessController = Get.put(BusinessController());

  // Function to show an alert dialog
  void _showAlertDialog(BuildContext context, Function() deleteItem) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: const Text(''),
          content: Container(
            margin: const EdgeInsets.only(top: 20),
            child: const Text(
              ' Are you sure want to delete this business ?',
              style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Container(
                height: h * .030,
                width: w * .2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const RadialGradient(
                    center: Alignment(0.19, -0.9),
                    colors: [
                      Color(0xffD50000),
                      Color(0xff760000),
                    ],
                    radius: 4.0,
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                // Perform any action here, then close the dialog
                deleteItem();
                Navigator.of(context).pop();
              },
              child: Container(
                height: h * .030,
                width: w * .2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const RadialGradient(
                    center: Alignment(0.19, -0.9),
                    colors: [
                      ColorConstants.kGradientDarkGreen,
                      ColorConstants.kGradientLightGreen
                    ],
                    radius: 4.0,
                  ),
                ),
                child: const Center(
                  child: Text(
                    'OK',
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // get my business  list
  int statusValue = 0;
  getMyBusiness() async {
    setState(() {
      isApiCalling = true;
    });
    final response = await api.businessListByUser();
    setState(() {
      statusValue = response['status'];
      print("Status Value: ${statusValue} ");
      businessController.businessList.value = response['result'];
    });
    setState(() {
      isApiCalling = false;
    });

    print('Get my business list----${businessController.businessList}');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMyBusiness();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    final double h = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: isApiCalling
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : statusValue == 0
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: size.height * 0.05,
                      width: size.width * 0.8,
                      margin: EdgeInsets.all(20),
                      // margin: EdgeInsets.symmetric(vertical: size.width * 0.05),
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
                        child: customText.kText("My Business", 20,
                            FontWeight.w700, Colors.white, TextAlign.center),
                      ),
                    ),
                    Expanded(
                        child: Container(
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(8)),
                          height: 50,
                          width: size.width * .400,
                          child: Center(
                            child: customText.kText(
                                "No data found",
                                15,
                                FontWeight.w700,
                                Colors.black,
                                TextAlign.center),
                          ),
                        ),
                      ),
                    ))
                  ],
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
                                "My Business",
                                20,
                                FontWeight.w700,
                                Colors.white,
                                TextAlign.center),
                          ),
                        ),
                        Obx(() => Container(
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
                                  childAspectRatio: 1 / 2.3,
                                ),
                                itemCount:
                                    businessController.businessList.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    // margin: EdgeInsets.all(size.width * 0.02),
                                    padding: EdgeInsets.all(size.width * 0.02),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                ColorConstants.kIndicatorDots),
                                        borderRadius: BorderRadius.circular(
                                            size.width * 0.03)),
                                    child: Column(
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            // ontap
                                            print("ontap business");
                                            sideDrawerController
                                                .pageIndex.value = 30;
                                            sideDrawerController
                                                    .fromMyBusinessList =
                                                "fromMyBusinessList";
                                            sideDrawerController.detailTwoId =
                                                businessController
                                                    .businessList[index]["id"];
                                            sideDrawerController.pageController
                                                .jumpToPage(30);
                                          },
                                          child: Container(
                                            height: size.width * 0.38,
                                            width: size.width * 0.38,
                                            margin: EdgeInsets.only(
                                                bottom: size.width * 0.02),
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade800,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        size.width * 0.03)),
                                            child: businessController
                                                        .businessList[index]
                                                            ['featured_image']
                                                        .toString() ==
                                                    ""
                                                ? Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      image:
                                                          const DecorationImage(
                                                        image: AssetImage(
                                                          'assets/images/no_image.jpeg',
                                                        ),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  )
                                                : Image.network(
                                                    "${businessController.businessList[index]['featured_image'].toString()}",
                                                    fit: BoxFit.fill,
                                                  ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: size.width * 0.45,
                                          height: size.width * 0.09,
                                          child: customText.kText(
                                              "${businessController.businessList[index]['business_title'].toString()}",
                                              15,
                                              FontWeight.w700,
                                              Colors.black,
                                              TextAlign.center),
                                        ),
                                        SizedBox(
                                          width: size.width * 0.45,
                                          height: size.width * 0.09,
                                          child: customText.kText(
                                              "${businessController.businessList[index]['address'].toString()}",
                                              15,
                                              FontWeight.w400,
                                              Colors.black,
                                              TextAlign.center),
                                        ),
                                        SizedBox(
                                          width: size.width * 0.45,
                                          // height: size.width * 0.09,
                                          // height: h * .120,
                                          child: customText.kText(
                                              "${businessController.businessList[index]['business_description'].toString()}",
                                              15,
                                              FontWeight.w400,
                                              Colors.black,
                                              TextAlign.center),
                                        ),

                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 25),
                                          height: h * .050,
                                          width: double.infinity,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  sideDrawerController
                                                      .pageIndex.value = 2;
                                                  sideDrawerController
                                                          .fromEditBusiness =
                                                      "fromEditBusiness";
                                                  sideDrawerController
                                                          .myBusinessId =
                                                      businessController
                                                              .businessList[
                                                          index]["id"];
                                                  sideDrawerController
                                                      .pageController
                                                      .jumpToPage(2);
                                                },
                                                child: Container(
                                                  height: 30,
                                                  width: width * .2,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              size.width *
                                                                  0.05),
                                                      gradient:
                                                          const LinearGradient(
                                                              begin: Alignment
                                                                  .centerLeft,
                                                              end: Alignment
                                                                  .centerRight,
                                                              colors: [
                                                            ColorConstants
                                                                .kGradientDarkGreen,
                                                            ColorConstants
                                                                .kGradientLightGreen
                                                          ])),
                                                  child: const Center(
                                                    child: Icon(
                                                      Icons.edit,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              GestureDetector(
                                                onTap: () {
                                                  _showAlertDialog(
                                                    context,
                                                    () async {
                                                      await api.deleteBusiness(
                                                          businessController
                                                                  .businessList[
                                                              index]['id']);
                                                      getMyBusiness();
                                                    },
                                                  );
                                                },
                                                child: Container(
                                                  height: 30,
                                                  width: width * .2,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.white),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            size.width * 0.05),
                                                    gradient:
                                                        const LinearGradient(
                                                      begin:
                                                          Alignment.centerLeft,
                                                      end:
                                                          Alignment.centerRight,
                                                      colors: [
                                                        // Color(0xffa40000),
                                                        // Color(0xff262626)
                                                        Color(0xffD50000),
                                                        Color(0xff760000),
                                                      ],
                                                    ),
                                                    // color: Color(0xffEE0200),
                                                  ),
                                                  child: const Center(
                                                    child: Icon(
                                                      Icons.delete,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        GestureDetector(
                                          onTap: () {
                                            sideDrawerController
                                                .pageIndex.value = 27;
                                            sideDrawerController
                                                    .businessListingId =
                                                businessController
                                                    .businessList[index]["id"];
                                            sideDrawerController.pageController
                                                .jumpToPage(27);
                                          },
                                          child: Container(
                                            height: 30,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.white),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        size.width * 0.05),
                                                gradient: const LinearGradient(
                                                    begin: Alignment.centerLeft,
                                                    end: Alignment.centerRight,
                                                    colors: [
                                                      ColorConstants
                                                          .kGradientDarkGreen,
                                                      ColorConstants
                                                          .kGradientLightGreen
                                                    ])),
                                            child: Center(
                                              child: customText.kText(
                                                  "Post Job",
                                                  15,
                                                  FontWeight.w600,
                                                  Colors.white,
                                                  TextAlign.center),
                                            ),
                                          ),
                                        ),

                                        GestureDetector(
                                          onTap: () {
                                            sideDrawerController
                                                .pageIndex.value = 17;
                                            sideDrawerController
                                                    .businessListingId =
                                                businessController
                                                    .businessList[index]["id"];
                                            sideDrawerController.pageController
                                                .jumpToPage(17);
                                          },
                                          child: Container(
                                            height: 30,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.white),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        size.width * 0.05),
                                                gradient: const LinearGradient(
                                                    begin: Alignment.centerLeft,
                                                    end: Alignment.centerRight,
                                                    colors: [
                                                      ColorConstants
                                                          .kGradientDarkGreen,
                                                      ColorConstants
                                                          .kGradientLightGreen
                                                    ])),
                                            child: Center(
                                              child: customText.kText(
                                                  "Post Event",
                                                  15,
                                                  FontWeight.w600,
                                                  Colors.white,
                                                  TextAlign.center),
                                            ),
                                          ),
                                        ),

                                        // post special offer
                                        GestureDetector(
                                          onTap: () {
                                            sideDrawerController
                                                .pageIndex.value = 35;
                                            sideDrawerController
                                                    .businessListingId =
                                                businessController
                                                    .businessList[index]["id"];
                                            sideDrawerController.pageController
                                                .jumpToPage(35);
                                          },
                                          child: Container(
                                            height: 30,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.white),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        size.width * 0.05),
                                                gradient: const LinearGradient(
                                                    begin: Alignment.centerLeft,
                                                    end: Alignment.centerRight,
                                                    colors: [
                                                      ColorConstants
                                                          .kGradientDarkGreen,
                                                      ColorConstants
                                                          .kGradientLightGreen
                                                    ])),
                                            child: Center(
                                              child: customText.kText(
                                                  "Post Offer",
                                                  15,
                                                  FontWeight.w600,
                                                  Colors.white,
                                                  TextAlign.center),
                                            ),
                                          ),
                                        ),

                                        // move to page number 17

                                        // Linear gradient color button
                                        // Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.spaceBetween,
                                        //   crossAxisAlignment: CrossAxisAlignment.start,
                                        //   children: [
                                        //     SizedBox(
                                        //       height: size.width * 0.07,
                                        //       child: Image.asset("assets/images/map.png"),
                                        //     ),
                                        //     SizedBox(
                                        //         width: size.width * 0.33,
                                        //         height: size.height * 0.09,
                                        //         child: customText.kText(
                                        //             "20102 Kabul Range Road, Afghanistan 1001.",
                                        //             13,
                                        //             FontWeight.w500,
                                        //             Colors.black,
                                        //             TextAlign.left))
                                        //   ],
                                        // ),
                                        // Container(
                                        //   height: size.height * 0.05,
                                        //   width: size.width * 0.8,
                                        //   // margin: EdgeInsets.symmetric(vertical: size.width * 0.02),
                                        //   padding: EdgeInsets.symmetric(
                                        //       horizontal: size.width * 0.02),
                                        //   decoration: BoxDecoration(
                                        //       // border: Border.all(color: Colors.white),
                                        //       borderRadius: BorderRadius.circular(
                                        //           size.width * 0.02),
                                        //       gradient: const LinearGradient(
                                        //           begin: Alignment.centerLeft,
                                        //           end: Alignment.centerRight,
                                        //           colors: [
                                        //             ColorConstants.kGradientDarkGreen,
                                        //             ColorConstants.kGradientLightGreen
                                        //           ])),
                                        //   child: Row(
                                        //     mainAxisAlignment:
                                        //         MainAxisAlignment.spaceBetween,
                                        //     children: [
                                        //       customText.kText(
                                        //           "Event",
                                        //           14,
                                        //           FontWeight.w700,
                                        //           Colors.white,
                                        //           TextAlign.center),
                                        //       CircleAvatar(
                                        //         radius: size.width * 0.042,
                                        //         child: SizedBox(
                                        //             height: size.width * 0.055,
                                        //             child: Image.asset(
                                        //                 "assets/images/call.png")),
                                        //       )
                                        //     ],
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  );
                                })))
                      ],
                    ),
                  ),
                ),
    );
  }
}
