import 'package:flutter/material.dart';
import 'package:kaarobaar/constants/color_constants.dart';
import 'package:kaarobaar/services/api_services.dart';
import 'package:kaarobaar/utils/text.dart';

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

  // get my business  list
  getMyBusiness() async {
    setState(() {
      isApiCalling = true;
    });
    final response = await api.businessListByUser();
    setState(() {
      myBusinessListData = response['result'];
    });
    setState(() {
      isApiCalling = false;
    });

    print('Get my business list----$myBusinessListData');
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
    final double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: isApiCalling
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
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
                              childAspectRatio: 1 / 1.7,
                            ),
                            itemCount: myBusinessListData.length,
                            itemBuilder: (context, index) {
                              return Container(
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
                                      child: myBusinessListData[index]
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
                                              "${myBusinessListData[index]['featured_image'].toString()}",
                                              fit: BoxFit.fill,
                                            ),
                                    ),
                                    SizedBox(
                                      width: size.width * 0.45,
                                      height: size.width * 0.09,
                                      child: customText.kText(
                                          "${myBusinessListData[index]['business_title'].toString()}",
                                          15,
                                          FontWeight.w700,
                                          Colors.black,
                                          TextAlign.center),
                                    ),
                                    SizedBox(
                                      width: size.width * 0.45,
                                      height: size.width * 0.09,
                                      child: customText.kText(
                                          "${myBusinessListData[index]['address'].toString()}",
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
                                          "${myBusinessListData[index]['business_description'].toString()}",
                                          15,
                                          FontWeight.w400,
                                          Colors.black,
                                          TextAlign.center),
                                    ),

                                    Container(
                                      margin: const EdgeInsets.only(top: 5),
                                      height: h * .050,
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 60,
                                            decoration: BoxDecoration(
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
                                            child: const Center(
                                              child: Icon(
                                                Icons.edit,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              // delete user by id
                                              await api.deleteBusiness(
                                                  myBusinessListData[index]
                                                      ['id']);
                                            },
                                            child: Container(
                                              height: 30,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.white),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          size.width * 0.05),
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
                                    )
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
                            }))
                  ],
                ),
              ),
            ),
    );
  }
}
