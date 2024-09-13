import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kaarobaar/constants/color_constants.dart';
import 'package:kaarobaar/controllers/login_controller.dart';
import 'package:kaarobaar/controllers/side_drawerController.dart';
import 'package:kaarobaar/services/api_services.dart';
import 'package:kaarobaar/utils/text.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  dynamic size;
  final customText = CustomText(), api = API();

  SideDrawerController sideDrawerController = Get.put(SideDrawerController());
  LoginController loginController = Get.put(LoginController());
  String? userName = "";
  String? userEmail = "";
  String? password = "";
  String profileURL = "";
  bool isApiCalling = false;

  getProfileData() async {
    setState(() {
      isApiCalling = true;
    });
    final response = await api.getProfileData();
    setState(() {
      userName = response['result']['username'];
      userEmail = response['result']['email'];
      profileURL = response['result']['profile_img'];
    });
    setState(() {
      isApiCalling = false;
    });

    print(' user name----$userName');
    print('user email--- $userEmail');
    print('response my account------- ${response}');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("loginController.userId test :- ${loginController.userId}");
    getProfileData();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: isApiCalling
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.width * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: size.width * 0.62,
                          child: customText.kText("My Account", 30,
                              FontWeight.bold, Colors.black, TextAlign.start),
                        ),
                        profileURL.isEmpty
                            ? Container(
                                // height: size.width * 0.25,
                                // padding: EdgeInsets.all(size.width * 0.01),
                                padding: const EdgeInsets.all(40),
                                decoration: const BoxDecoration(
                                  color: ColorConstants.kCircleRed,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/person.jpg'),
                                  ),
                                ),
                                // child: Image.asset("assets/images/sampleGirl.png"),
                              )
                            : Container(
                                // height: size.width * 0.25,
                                // padding: EdgeInsets.all(size.width * 0.01),

                                padding: const EdgeInsets.all(40),
                                decoration: BoxDecoration(
                                  color: ColorConstants.kCircleRed,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(profileURL),
                                  ),
                                ),
                                // child: Image.network(profileURL),
                              )
                      ],
                    ),
                    SizedBox(
                      height: size.width * 0.05,
                    ),
                    Container(
                      height: size.height * 0.06,
                      width: size.width,
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.02),
                      decoration: const BoxDecoration(
                        // color: Colors.grey.shade200,
                        border: Border(
                          bottom: BorderSide(
                              width: 1.0, color: ColorConstants.kIconsGrey),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: customText.kText(
                            "$userName",
                            20,
                            FontWeight.w500,
                            ColorConstants.kIconsGrey,
                            TextAlign.start),
                      ),
                    ),
                    SizedBox(
                      height: size.width * 0.05,
                    ),
                    Container(
                      height: size.height * 0.06,
                      width: size.width,
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.02),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 1.0, color: ColorConstants.kIconsGrey),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: customText.kText(
                            "$userEmail",
                            20,
                            FontWeight.w500,
                            ColorConstants.kIconsGrey,
                            TextAlign.start),
                      ),
                    ),
                    SizedBox(
                      height: size.width * 0.05,
                    ),
                    Container(
                        height: size.height * 0.06,
                        width: size.width,
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.02),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                width: 1.0, color: ColorConstants.kIconsGrey),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            customText.kText("**********", 20, FontWeight.w500,
                                ColorConstants.kIconsGrey, TextAlign.start),
                            GestureDetector(
                              child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: customText.kText(
                                      "Change",
                                      14,
                                      FontWeight.w500,
                                      ColorConstants.kIconsGrey,
                                      TextAlign.right)),
                              onTap: () {
                                sideDrawerController.pageIndex.value = 14;
                                sideDrawerController.pageController
                                    .jumpToPage(14);
                              },
                            )
                          ],
                        )),
                    // const Spacer(),
                    SizedBox(
                      height: size.height * 0.2,
                    ),
                    GestureDetector(
                      child: Container(
                        height: size.width * 0.13,
                        width: size.width,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius:
                                BorderRadius.circular(size.width * 0.02),
                            gradient: const RadialGradient(
                              center: Alignment(0.19, -0.9),
                              colors: [
                                ColorConstants.kGradientDarkGreen,
                                ColorConstants.kGradientBlack,
                              ],
                              radius: 4.0,
                            )),
                        child: Center(
                          child: customText.kText("Continue", 30,
                              FontWeight.w700, Colors.white, TextAlign.center),
                        ),
                      ),
                      onTap: () {},
                    )
                  ],
                ),
              ));
  }
}
