import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaarobaar/constants/color_constants.dart';
import 'package:kaarobaar/controllers/side_drawerController.dart';
import 'package:kaarobaar/services/api_services.dart';
import 'package:kaarobaar/utils/text.dart';

class PopularCommunities extends StatefulWidget {
  const PopularCommunities({super.key});

  @override
  State<PopularCommunities> createState() => _PopularCommunitiesState();
}

class _PopularCommunitiesState extends State<PopularCommunities> {
  dynamic size;
  final customText = CustomText();
  List<dynamic> popularCommunitiesList = [];
  bool isApiCalling = false;
  final api = API();

  SideDrawerController sideDrawerController = Get.put(SideDrawerController());

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPopularCommunities();
    print('Popular communities all list');
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: isApiCalling
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : popularCommunitiesList.isEmpty
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
                                  // childAspectRatio: 1 / 1.8,
                                  childAspectRatio: 1 / 1.4,
                                ),
                                itemCount: popularCommunitiesList.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      sideDrawerController.pageIndex.value = 29;
                                      sideDrawerController.pageController
                                          .jumpToPage(29);
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
                                            child: popularCommunitiesList[index]
                                                            ['image']
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
                                                    "${popularCommunitiesList[index]['image'].toString()}",
                                                    fit: BoxFit.fill,
                                                  ),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.45,
                                            height: size.width * 0.09,
                                            child: customText.kText(
                                                "${popularCommunitiesList[index]['category_name'].toString()}",
                                                15,
                                                FontWeight.w700,
                                                Colors.black,
                                                TextAlign.center),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.45,
                                            height: size.width * 0.09,
                                            child: customText.kText(
                                                "${popularCommunitiesList[index]['listing'].toString()} Listing",
                                                15,
                                                FontWeight.w400,
                                                Colors.black,
                                                TextAlign.center),
                                          ),
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
