import 'package:flutter/material.dart';
import 'package:kaarobaar/constants/color_constants.dart';
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

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController msgController = TextEditingController();

  contactAdmin() async {

    if(nameController.text.isNotEmpty && (!nameController.text.startsWith(" "))){
      if(EmailValidator.validate(emailController.text)) {
        if(phoneNoController.text.length == 10) {
          if(msgController.text.isNotEmpty && (!msgController.text.startsWith(" "))) {

            // setState(() {
            //   isApiCalling = true;
            // });
            //
            // final response = await api.contactAdmin();
            //
            // setState(() {
            //   isApiCalling = false;
            // });
            //
            // if(response["statusCode"] == 200) {
            //   helper.successDialog(context, response["message"]);
            // } else {
            //   helper.errorDialog(context, response["message"]);
            // }

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
                child: customText.kText("Contact Admin", 30, FontWeight.w700, Colors.black, TextAlign.start),
              ),
              Container(
                height: size.height * 0.06,
                width: size.width,
                padding: EdgeInsets.only(left: size.width * 0.02),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.0, color: ColorConstants.kIconsGrey),
                  ),
                ),
                child: TextField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  controller: nameController,
                  style: customText.kTextStyle(20, FontWeight.w500, Colors.black),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Name",
                    hintStyle: customText.kTextStyle(16, FontWeight.w400, ColorConstants.kIconsGrey),
                  ),
                ),
              ),
              SizedBox(height: size.width * 0.05,),
              Container(
                height: size.height * 0.06,
                width: size.width,
                padding: EdgeInsets.only(left: size.width * 0.02),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.0, color: ColorConstants.kIconsGrey),
                  ),
                ),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  controller: emailController,
                  style: customText.kTextStyle(20, FontWeight.w500, Colors.black),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Email",
                    hintStyle: customText.kTextStyle(16, FontWeight.w400, ColorConstants.kIconsGrey),
                  ),
                ),
              ),
              SizedBox(height: size.width * 0.05,),
              Container(
                height: size.height * 0.06,
                width: size.width,
                padding: EdgeInsets.only(left: size.width * 0.02),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.0, color: ColorConstants.kIconsGrey),
                  ),
                ),
                child: TextField(
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  controller: phoneNoController,
                  style: customText.kTextStyle(20, FontWeight.w500, Colors.black),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Contact Number",
                    hintStyle: customText.kTextStyle(16, FontWeight.w400, ColorConstants.kIconsGrey),
                  ),
                ),
              ),
              SizedBox(height: size.width * 0.05,),
              Container(
                width: size.width,
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.0, color: ColorConstants.kIconsGrey),
                  ),
                ),
                child: TextField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  controller: msgController,
                  maxLines: null,
                  style: customText.kTextStyle(20, FontWeight.w500, Colors.black),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Message",
                    hintStyle: customText.kTextStyle(16, FontWeight.w400, ColorConstants.kIconsGrey),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.2,),
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
                      )
                  ),
                  child: Center(
                    child: customText.kText("Submit", 30, FontWeight.w700, Colors.white, TextAlign.center),
                  ),
                ),
                onTap: () {
                  // contactAdmin();
                },
              )
            ],
          ),
        ),
      )
    );
  }

}
