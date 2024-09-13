import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaarobaar/constants/color_constants.dart';
import 'package:kaarobaar/controllers/side_drawerController.dart';
import 'package:kaarobaar/services/api_services.dart';
import 'package:kaarobaar/utils/helper.dart';
import 'package:kaarobaar/utils/text.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  dynamic size;
  final customText = CustomText(), helper = Helper(), api = API();
  bool isApiCalling = false;
  bool oldPassHide = true, newPassHide = true, confirmPassHide = true;
  TextEditingController oldPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  SideDrawerController sideDrawerController = Get.put(SideDrawerController());

  changePassword() async {
    if ((!oldPassController.text.contains(" ")) &&
        oldPassController.text.length >= 6) {
      if ((!newPassController.text.contains(" ")) &&
          newPassController.text.length >= 6) {
        if ((!confirmPassController.text.contains(" ")) &&
            confirmPassController.text.length >= 6) {
          if (newPassController.text == confirmPassController.text) {
            setState(() {
              isApiCalling = true;
            });

            final response = await api.changePassword(
              oldPassController.text,
              newPassController.text,
              confirmPassController.text,
            );

            setState(() {
              isApiCalling = false;
            });

            if (response["status"] == 1) {
              helper.successDialog(context, response["message"]);
              sideDrawerController.pageIndex.value = 1;
              sideDrawerController.pageController.jumpToPage(1);
            } else {
              helper.errorDialog(context, response["message"]);
            }
          }
        } else {
          helper.errorDialog(context,
              "Confirm password should be atleast 6 characters amd valid");
        }
      } else {
        helper.errorDialog(
            context, "New password should be atleast 6 characters and valid");
      }
    } else {
      helper.errorDialog(
          context, "Old password should be atleast 6 characters and valid");
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.width * 0.12,
              ),
              customText.kText("Password Change", 30, FontWeight.bold,
                  Colors.black, TextAlign.start),
              // SizedBox(
              //   width: size.width * 0.62,
              //   child: customText.kText("Password Change", 30, FontWeight.bold, Colors.black, TextAlign.start),
              // ),
              SizedBox(
                height: size.width * 0.12,
              ),
              TextField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                controller: oldPassController,
                obscureText: oldPassHide,
                decoration: InputDecoration(
                    hintText: "Old Password",
                    hintStyle: customText.kTextStyle(
                        16, FontWeight.w400, ColorConstants.kIconsGrey),
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: ColorConstants.kIconsGrey,
                      size: 35,
                    ),
                    suffixIcon: GestureDetector(
                      child: oldPassHide
                          ? const Icon(
                              Icons.visibility_off_outlined,
                              size: 35,
                              color: ColorConstants.kIconsGrey,
                            )
                          : const Icon(
                              Icons.visibility_outlined,
                              size: 35,
                              color: ColorConstants.kIconsGrey,
                            ),
                      onTap: () {
                        setState(() {
                          oldPassHide = !oldPassHide;
                        });
                      },
                    )),
              ),
              SizedBox(
                height: size.width * 0.05,
              ),
              TextField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                controller: newPassController,
                obscureText: newPassHide,
                decoration: InputDecoration(
                    hintText: "New Password",
                    hintStyle: customText.kTextStyle(
                        16, FontWeight.w400, ColorConstants.kIconsGrey),
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: ColorConstants.kIconsGrey,
                      size: 35,
                    ),
                    suffixIcon: GestureDetector(
                      child: newPassHide
                          ? const Icon(
                              Icons.visibility_off_outlined,
                              size: 35,
                              color: ColorConstants.kIconsGrey,
                            )
                          : const Icon(
                              Icons.visibility_outlined,
                              size: 35,
                              color: ColorConstants.kIconsGrey,
                            ),
                      onTap: () {
                        setState(() {
                          newPassHide = !newPassHide;
                        });
                      },
                    )),
              ),
              SizedBox(
                height: size.width * 0.05,
              ),
              TextField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                controller: confirmPassController,
                obscureText: confirmPassHide,
                decoration: InputDecoration(
                    hintText: "Confirm Password",
                    hintStyle: customText.kTextStyle(
                        16, FontWeight.w400, ColorConstants.kIconsGrey),
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: ColorConstants.kIconsGrey,
                      size: 35,
                    ),
                    suffixIcon: GestureDetector(
                      child: confirmPassHide
                          ? const Icon(
                              Icons.visibility_off_outlined,
                              size: 35,
                              color: ColorConstants.kIconsGrey,
                            )
                          : const Icon(
                              Icons.visibility_outlined,
                              size: 35,
                              color: ColorConstants.kIconsGrey,
                            ),
                      onTap: () {
                        setState(() {
                          confirmPassHide = !confirmPassHide;
                        });
                      },
                    )),
              ),
              SizedBox(
                height: size.height * 0.2,
              ),
              GestureDetector(
                child: Container(
                  height: size.width * 0.13,
                  width: size.width,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(size.width * 0.02),
                      gradient: const RadialGradient(
                        center: Alignment(0.19, -0.9),
                        colors: [
                          ColorConstants.kGradientDarkGreen,
                          ColorConstants.kGradientBlack,
                        ],
                        radius: 4.0,
                      )),
                  child: Center(
                    child: isApiCalling
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : customText.kText("Save & Change", 30, FontWeight.w700,
                            Colors.white, TextAlign.center),
                  ),
                ),
                onTap: () {
                  changePassword();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
