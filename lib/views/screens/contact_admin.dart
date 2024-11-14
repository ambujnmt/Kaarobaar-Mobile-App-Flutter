import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaarobaar/constants/color_constants.dart';
import 'package:kaarobaar/controllers/side_drawerController.dart';
import 'package:kaarobaar/services/api_services.dart';
import 'package:kaarobaar/utils/helper.dart';
import 'package:kaarobaar/utils/text.dart';
import 'package:email_validator/email_validator.dart';

class ContactAdmin extends StatefulWidget {
  const ContactAdmin({super.key});

  @override
  State<ContactAdmin> createState() => _ContactAdminState();
}

class _ContactAdminState extends State<ContactAdmin> {
  dynamic size;
  bool isApiCalling = false;
  final customText = CustomText(), helper = Helper();
  final api = API();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController msgController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  SideDrawerController sideDrawerController = Get.put(SideDrawerController());

  contactAdmin() async {
    if (nameController.text.isNotEmpty &&
        (!nameController.text.startsWith(" "))) {
      if (EmailValidator.validate(emailController.text)) {
        if (phoneNoController.text.length >= 10 &&
            phoneNoController.text.length <= 12) {
          if (msgController.text.isNotEmpty &&
              (!msgController.text.startsWith(" "))) {
            if (addressController.text.isNotEmpty &&
                !addressController.text.startsWith(" ")) {
              setState(() {
                isApiCalling = true;
              });

              final response = await api.contactToAdmin(
                nameController.text,
                emailController.text,
                phoneNoController.text,
                msgController.text,
                addressController.text,
              );

              setState(() {
                isApiCalling = false;
              });

              if (response["status"] == 1) {
                helper.successDialog(context, response["message"]);
                sideDrawerController.pageIndex.value = 0;
                sideDrawerController.pageController.jumpToPage(0);
              } else {
                helper.errorDialog(context, response["message"]);
              }
            } else {
              helper.errorDialog(context, "Please enter address");
            }
          } else {
            helper.errorDialog(context, "Please enter description");
          }
        } else {
          helper.errorDialog(context, "Please enter valid contact number");
        }
      } else {
        helper.errorDialog(context, "Please enter valid email");
      }
    } else {
      helper.errorDialog(context, "Please enter name");
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      height: size.height * 0.77,
      width: size.width,
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
              child: customText.kText("Contact Admin", 30, FontWeight.w700,
                  Colors.black, TextAlign.start),
            ),
            Container(
              height: size.height * 0.06,
              width: size.width,
              padding: EdgeInsets.only(left: size.width * 0.02),
              decoration: const BoxDecoration(
                border: Border(
                  bottom:
                      BorderSide(width: 1.0, color: ColorConstants.kIconsGrey),
                ),
              ),
              child: TextField(
                maxLength: 30,
                buildCounter: (BuildContext context,
                    {int? currentLength, int? maxLength, bool? isFocused}) {
                  return null;
                },
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                controller: nameController,
                style: customText.kTextStyle(20, FontWeight.w500, Colors.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Name",
                  hintStyle: customText.kTextStyle(
                      16, FontWeight.w400, ColorConstants.kIconsGrey),
                ),
              ),
            ),
            SizedBox(
              height: size.width * 0.05,
            ),
            Container(
              height: size.height * 0.06,
              width: size.width,
              padding: EdgeInsets.only(left: size.width * 0.02),
              decoration: const BoxDecoration(
                border: Border(
                  bottom:
                      BorderSide(width: 1.0, color: ColorConstants.kIconsGrey),
                ),
              ),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                controller: emailController,
                style: customText.kTextStyle(20, FontWeight.w500, Colors.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Email",
                  hintStyle: customText.kTextStyle(
                      16, FontWeight.w400, ColorConstants.kIconsGrey),
                ),
              ),
            ),
            SizedBox(
              height: size.width * 0.05,
            ),
            Container(
              height: size.height * 0.06,
              width: size.width,
              padding: EdgeInsets.only(left: size.width * 0.02),
              decoration: const BoxDecoration(
                border: Border(
                  bottom:
                      BorderSide(width: 1.0, color: ColorConstants.kIconsGrey),
                ),
              ),
              child: TextField(
                maxLength: 12,
                buildCounter: (BuildContext context,
                    {int? currentLength, int? maxLength, bool? isFocused}) {
                  return null;
                },
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                controller: phoneNoController,
                style: customText.kTextStyle(20, FontWeight.w500, Colors.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Contact Number",
                  hintStyle: customText.kTextStyle(
                      16, FontWeight.w400, ColorConstants.kIconsGrey),
                ),
              ),
            ),
            SizedBox(
              height: size.width * 0.05,
            ),
            Container(
              width: size.width,
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              decoration: const BoxDecoration(
                border: Border(
                  bottom:
                      BorderSide(width: 1.0, color: ColorConstants.kIconsGrey),
                ),
              ),
              child: TextField(
                maxLength: 150,
                buildCounter: (BuildContext context,
                    {int? currentLength, int? maxLength, bool? isFocused}) {
                  return null;
                },
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                controller: msgController,
                maxLines: null,
                style: customText.kTextStyle(20, FontWeight.w500, Colors.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Message",
                  hintStyle: customText.kTextStyle(
                      16, FontWeight.w400, ColorConstants.kIconsGrey),
                ),
              ),
            ),
            SizedBox(
              height: size.width * 0.05,
            ),
            Container(
              width: size.width,
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              decoration: const BoxDecoration(
                border: Border(
                  bottom:
                      BorderSide(width: 1.0, color: ColorConstants.kIconsGrey),
                ),
              ),
              child: TextField(
                buildCounter: (BuildContext context,
                    {int? currentLength, int? maxLength, bool? isFocused}) {
                  return null;
                },
                maxLength: 100,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                controller: addressController,
                maxLines: null,
                style: customText.kTextStyle(20, FontWeight.w500, Colors.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Address",
                  hintStyle: customText.kTextStyle(
                      16, FontWeight.w400, ColorConstants.kIconsGrey),
                ),
              ),
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
                      : customText.kText("Submit", 30, FontWeight.w700,
                          Colors.white, TextAlign.center),
                ),
              ),
              onTap: () {
                contactAdmin();
              },
            )
          ],
        ),
      ),
    ));
  }
}
