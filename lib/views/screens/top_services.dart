import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaarobaar/constants/color_constants.dart';
import 'package:kaarobaar/controllers/side_drawerController.dart';
import 'package:kaarobaar/services/api_services.dart';
import 'package:kaarobaar/utils/text.dart';

class TopServices extends StatefulWidget {
  const TopServices({super.key});

  @override
  State<TopServices> createState() => _TopServicesState();
}

class _TopServicesState extends State<TopServices> {
  dynamic size;
  final customText = CustomText();
  List<dynamic> viewAllTopServicesList = [];
  bool isApiCalling = false;
  final api = API();
  SideDrawerController sideDrawerController = Get.put(SideDrawerController());

  // get popular communities  list
  viewAllTopServices() async {
    setState(() {
      isApiCalling = true;
    });
    final response = await api.homeTopServices();
    setState(() {
      viewAllTopServicesList = response['result'];
    });
    setState(() {
      isApiCalling = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewAllTopServices();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: isApiCalling
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : viewAllTopServicesList.isEmpty
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
                                "Top Services",
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
                            itemCount: viewAllTopServicesList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  sideDrawerController.pageIndex.value = 31;
                                  sideDrawerController.topServicesDetailId =
                                      viewAllTopServicesList[index]["id"];
                                  sideDrawerController.pageController
                                      .jumpToPage(31);
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
                                        child: viewAllTopServicesList[index]
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
                                                "${viewAllTopServicesList[index]['featured_image'].toString()}",
                                                fit: BoxFit.fill,
                                              ),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.45,
                                        // height: size.width * 0.09,
                                        child: customText.kText(
                                            "${viewAllTopServicesList[index]['business_title'].toString()}",
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
