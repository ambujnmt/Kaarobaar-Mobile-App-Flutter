import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kaarobaar/constants/color_constants.dart';
import 'package:kaarobaar/utils/helper.dart';
import 'package:kaarobaar/utils/text.dart';
import 'package:email_validator/email_validator.dart';
import 'package:kaarobaar/views/authorization/otp_screen.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  dynamic size;
  bool isApiCalling = false;
  final customText = CustomText(), helper = Helper();
  double systemBarSpace = 0;

  TextEditingController forgotEmailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if(Platform.isAndroid) {
      systemBarSpace = 1.5;
    } else if(Platform.isIOS) {
      systemBarSpace = -30;
    }
  }

  forgotPassword() async {

    if(EmailValidator.validate(forgotEmailController.text)) {

      // setState(() {
      //   isApiCalling = true;
      // });
      //
      // final response = await api.forgotPassword(forgotEmailController.text);
      //
      // setState(() {
      //   isApiCalling = false;
      // });
      //
      // if(response["statusCode"] == 200){
      //   helper.successDialog(context, response["message"]);
      // } else {
      //   helper.errorDialog(context, response["message"]);
      // }

    } else {
      helper.errorDialog(context, "Please enter a valid email");
    }

  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      body: SizedBox(
        height : size.height,
        width: size.width,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              top: systemBarSpace,
              child: Container(
                height: size.height * 0.38,
                width: size.width,
                alignment: Alignment.topCenter,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/bgImage.png")
                    )
                ),
                child: Padding(
                  padding: Platform.isIOS
                      ? EdgeInsets.fromLTRB(size.width * 0.1, size.width * 0.3, size.width * 0.1, 0)
                      : EdgeInsets.fromLTRB(size.width * 0.1, size.width * 0.22, size.width * 0.1, 0),
                  child: Image.asset("assets/images/logoText.png"),
                ),
              ),
            ),
            Container(
              height: size.height * 0.78,
              width: size.width,
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.height * 0.07),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(size.width * 0.1))
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    customText.kText("Forgot Password", 30, FontWeight.w800, Colors.black, TextAlign.left),
                    customText.kText("Enter your email address. We will send OTP code for verification for the next step.",
                      18, FontWeight.w400, Colors.black, TextAlign.left),

                    SizedBox(height: size.width * 0.1,),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      controller: forgotEmailController,
                      decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: customText.kTextStyle(16, FontWeight.w400, ColorConstants.kIconsGrey),
                          prefixIcon: const Icon(Icons.email, color: ColorConstants.kIconsGrey, size: 35,)
                      ),
                    ),

                    SizedBox(height: size.width * 0.58,),
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
                          child: isApiCalling
                            ? const CircularProgressIndicator(color: Colors.white,)
                            : customText.kText("Submit", 30, FontWeight.w700, Colors.white, TextAlign.center),
                        ),
                      ),
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const OTPScreen() ));
                        // forgotPassword();
                      },
                    )

                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }

}
