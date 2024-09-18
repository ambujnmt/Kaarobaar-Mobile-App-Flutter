import 'package:flutter/material.dart';
import 'package:kaarobaar/constants/color_constants.dart';
import 'package:kaarobaar/utils/helper.dart';
import 'package:kaarobaar/utils/text.dart';
import 'package:email_validator/email_validator.dart';

class AddBusiness extends StatefulWidget {
  const AddBusiness({super.key});

  @override
  State<AddBusiness> createState() => _AddBusinessState();
}

class _AddBusinessState extends State<AddBusiness> {
  dynamic size;
  bool isApiCalling = false;
  final customText = CustomText(), helper = Helper();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController businessNameController = TextEditingController();
  TextEditingController businessTypeController = TextEditingController();
  TextEditingController businessAddressController = TextEditingController();
  TextEditingController vatNoController = TextEditingController();

  addBusiness() async {
    if (firstNameController.text.isNotEmpty &&
        (!firstNameController.text.startsWith(" "))) {
      if (lastNameController.text.isNotEmpty &&
          (!lastNameController.text.startsWith(" "))) {
        if (EmailValidator.validate(emailController.text)) {
          if (phoneController.text.length == 10) {
            if (businessNameController.text.isNotEmpty &&
                (!businessNameController.text.startsWith(" "))) {
              if (businessTypeController.text.isNotEmpty &&
                  (!businessTypeController.text.startsWith(" "))) {
                if (businessAddressController.text.isNotEmpty &&
                    (!businessAddressController.text.startsWith(" "))) {
                  if (vatNoController.text.isNotEmpty &&
                      (!vatNoController.text.startsWith(" "))) {
                    // setState(() {
                    //   isApiCalling = true;
                    // });
                    //
                    // final response = await api.addBusiness();
                    //
                    // setState(() {
                    //   isApiCalling = false;
                    // });

                    // if(response["statusCode"] == 200){
                    //   helper.successDialog(context, response["message"]);
                    // } else {
                    //   helper.errorDialog(context, response["message"]);
                    // }
                  } else {
                    helper.errorDialog(context, "Please enter vat number");
                  }
                } else {
                  helper.errorDialog(context, "Please enter business address");
                }
              } else {
                helper.errorDialog(context, "Please enter business type");
              }
            } else {
              helper.errorDialog(context, "Please enter business name");
            }
          } else {
            helper.errorDialog(
                context, "Please enter valid 10 digit phone number");
          }
        } else {
          helper.errorDialog(context, "Please enter valid email address");
        }
      } else {
        helper.errorDialog(context, "Please enter valid last name");
      }
    } else {
      helper.errorDialog(context, "Please enter valid first name");
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
                    child: customText.kText("Add Business", 30, FontWeight.w700,
                        Colors.black, TextAlign.start),
                  ),
                  TextField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    controller: firstNameController,
                    decoration: InputDecoration(
                      hintText: "Name",
                      hintStyle: customText.kTextStyle(
                          16, FontWeight.w400, ColorConstants.kIconsGrey),
                      // prefixIcon: const Icon(Icons.person, color: ColorConstants.kIconsGrey, size: 35,),
                    ),
                  ),
                  SizedBox(
                    height: size.width * 0.05,
                  ),
                  TextField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    controller: lastNameController,
                    decoration: InputDecoration(
                      hintText: "Last Name",
                      hintStyle: customText.kTextStyle(
                          16, FontWeight.w400, ColorConstants.kIconsGrey),
                      // prefixIcon: const Icon(Icons.person, color: ColorConstants.kIconsGrey, size: 35,),
                    ),
                  ),
                  SizedBox(
                    height: size.width * 0.05,
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: customText.kTextStyle(
                          16, FontWeight.w400, ColorConstants.kIconsGrey),
                      // prefixIcon: const Icon(Icons.email, color: ColorConstants.kIconsGrey, size: 35,),
                    ),
                  ),
                  SizedBox(
                    height: size.width * 0.05,
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    controller: phoneController,
                    decoration: InputDecoration(
                      hintText: "Contact Number",
                      hintStyle: customText.kTextStyle(
                          16, FontWeight.w400, ColorConstants.kIconsGrey),
                      // prefixIcon: const Icon(Icons.phone_android, color: ColorConstants.kIconsGrey, size: 35,),
                    ),
                  ),
                  SizedBox(
                    height: size.width * 0.05,
                  ),
                  TextField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    controller: businessNameController,
                    decoration: InputDecoration(
                      hintText: "Business Name",
                      hintStyle: customText.kTextStyle(
                          16, FontWeight.w400, ColorConstants.kIconsGrey),
                      // prefixIcon: const Icon(Icons.store, color: ColorConstants.kIconsGrey, size: 35,),
                    ),
                  ),
                  SizedBox(
                    height: size.width * 0.05,
                  ),
                  TextField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    controller: businessTypeController,
                    decoration: InputDecoration(
                      hintText: "Business Type",
                      hintStyle: customText.kTextStyle(
                          16, FontWeight.w400, ColorConstants.kIconsGrey),
                      // prefixIcon: const Icon(Icons.category, color: ColorConstants.kIconsGrey, size: 35,),
                    ),
                  ),
                  SizedBox(
                    height: size.width * 0.05,
                  ),
                  TextField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.sentences,
                    controller: businessAddressController,
                    decoration: InputDecoration(
                      hintText: "Business Address",
                      hintStyle: customText.kTextStyle(
                          16, FontWeight.w400, ColorConstants.kIconsGrey),
                      // prefixIcon: const Icon(Icons.location_on, color: ColorConstants.kIconsGrey, size: 35,),
                    ),
                  ),
                  SizedBox(
                    height: size.width * 0.05,
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    controller: vatNoController,
                    decoration: InputDecoration(
                      hintText: "VAT Number",
                      hintStyle: customText.kTextStyle(
                          16, FontWeight.w400, ColorConstants.kIconsGrey),
                      // prefixIcon: const Icon(Icons.onetwothree, color: ColorConstants.kIconsGrey, size: 35,),
                    ),
                  ),
                  SizedBox(
                    height: size.width * 0.15,
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
                        child: isApiCalling
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : customText.kText("Register", 30, FontWeight.w700,
                                Colors.white, TextAlign.center),
                      ),
                    ),
                    onTap: () {
                      addBusiness();
                    },
                  )
                ],
              ),
            )));
  }
}
