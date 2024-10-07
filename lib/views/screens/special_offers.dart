import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaarobaar/constants/color_constants.dart';
import 'package:kaarobaar/controllers/side_drawerController.dart';
import 'package:kaarobaar/services/api_services.dart';
import 'package:kaarobaar/utils/text.dart';

class SpecialOffers extends StatefulWidget {
  const SpecialOffers({super.key});

  @override
  State<SpecialOffers> createState() => _SpecialOffersState();
}

class _SpecialOffersState extends State<SpecialOffers> {
  bool isApiLoading = false;
  final customText = CustomText();
  final api = API();
  List<dynamic> offersListData = [];
  dynamic size;
  SideDrawerController sideDrawerController = Get.put(SideDrawerController());

  offersList() async {
    setState(() {
      isApiLoading = true;
    });

    final response = await api.offersList();

    setState(() {
      offersListData = response['result'];
    });

    setState(() {
      isApiLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    offersList();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
        // body: Center(
        //   child: Text("Blogs"),
        // ),
        body: isApiLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                height: size.height * 0.77,
                width: size.width,
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
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
                        child: customText.kText("Offers", 20, FontWeight.w700,
                            Colors.white, TextAlign.center),
                      ),
                    ),
                    SizedBox(
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
                        ),
                        itemCount: offersListData.length,
                        itemBuilder: (context, index) {
                          return Container(
                            // margin: EdgeInsets.all(size.width * 0.02),
                            padding: EdgeInsets.all(size.width * 0.01),
                            decoration: BoxDecoration(
                                // border: Border.all(color: ColorConstants.kIndicatorDots),
                                borderRadius:
                                    BorderRadius.circular(size.width * 0.03)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                offersListData[index]['image'].toString() == ""
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
                                    : Container(
                                        height: size.width * 0.38,
                                        width: size.width * 0.5,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade800,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(
                                                '${offersListData[index]['image']}'),
                                          ),
                                        ),
                                      ),
                                SizedBox(
                                  width: size.width * 0.45,
                                  height: size.width * 0.12,
                                  child: Text(
                                    // "Blog ${index + 1}",
                                    "${offersListData[index]['title']}",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                        fontFamily: "Raleway"),
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.45,
                                  height: size.width * 0.2,
                                  child: Text(
                                    // "Blog ${index + 1}",
                                    "${offersListData[index]['short_content']}",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                        fontFamily: "Raleway"),
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                  ),
                                ),
                                GestureDetector(
                                  child: Align(
                                    alignment: index % 2 == 0
                                        ? Alignment.bottomLeft
                                        : Alignment.bottomRight,
                                    child: Container(
                                      height: size.width * 0.09,
                                      width: size.width * 0.3,
                                      // margin: EdgeInsets.symmetric(vertical: size.width * 0.03, horizontal: size.width * 0.25),
                                      decoration: BoxDecoration(
                                        // color: Colors.black,
                                        borderRadius: BorderRadius.circular(
                                            size.width * 0.03),
                                        // gradient: const RadialGradient(
                                        //   center: Alignment(0.19, -0.9),
                                        //   colors: [
                                        //     Color(0xffa40000),
                                        //     Color(0xff262626)
                                        //   ],
                                        //   radius: 4.0,
                                        // ),
                                        color: Color(0xffEE0200),
                                      ),
                                      child: Center(
                                        child: customText.kText(
                                            "Read More",
                                            16,
                                            FontWeight.w700,
                                            Colors.white,
                                            TextAlign.center),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    // FocusScope.of(context).unfocus();
                                    sideDrawerController.pageIndex.value = 21;
                                    sideDrawerController.offersId =
                                        offersListData[index]["id"];
                                    sideDrawerController.pageController
                                        .jumpToPage(21);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ));
  }
}
