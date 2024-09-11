import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kaarobaar/constants/color_constants.dart';
import 'package:kaarobaar/utils/helper.dart';
import 'package:kaarobaar/utils/text.dart';
import 'package:kaarobaar/views/authorization/create_password.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'dart:developer';

class OTPScreen extends StatefulWidget {
  final email, from;
  const OTPScreen({super.key, this.email, this.from});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {

  dynamic size;
  bool hidePass = true, isApiCalling = false;
  final customText = CustomText(), helper = Helper();
  double systemBarSpace = 0;
  String remainingTimer = "60", otp = "";
  int resendOTPTimes = 0;

  @override
  void initState() {
    super.initState();
    if(Platform.isAndroid) {
      systemBarSpace = 1.5;
    } else if(Platform.isIOS) {
      systemBarSpace = -30;
    }
    startTimer();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);

    Timer.periodic(
      oneSec,
          (Timer timer) {
        if(timer.tick < 61) {
          log("countdown 60 to 0 :- ${60 - timer.tick}");
          setState(() {
            remainingTimer = (60 - timer.tick).toString();
          });
        } else {
          log("timer is more then 60");
          setState(() {
            remainingTimer = "0";
          });
          timer.cancel();
        }
      },
    );
  }

  resendOTP() async {

    // resendOTPTimes++;
    //
    // final response = await api.forgotPassword(widget.email);
    //
    // if(response["status"] == true) {
    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("OTP sent successfully")));
    //   startTimer();
    // }

  }

  confirmOTP() async {

    if(otp.length == 4) {

      // setState(() {
      //   isApiCalling = true;
      // });
      //
      // final response = await api.confirmOTP();
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
      helper.errorDialog(context, "Please enter 4 digit valid OTP");
    }

  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      body: SizedBox(
        height: size.height,
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

                    customText.kText("You’ve got mail", 30, FontWeight.w800, Colors.black, TextAlign.left),
                    customText.kText("We have sent the otp verification code to your email address. Check your mail and enter the code below.",
                        18, FontWeight.w400, Colors.black, TextAlign.left),

                    SizedBox(height: size.width * 0.1,),
                    OTPTextField(
                      length: 4,
                      width: MediaQuery.of(context).size.width,
                      fieldWidth: 40,
                      keyboardType: TextInputType.number,
                      inputFormatter: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                      ],
                      style: const TextStyle(fontSize: 17),
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      fieldStyle: FieldStyle.underline,
                      onChanged: (String pin) {
                        log("otp :- $pin");
                        otp = pin;
                        setState(() {});
                      },
                    ),

                    SizedBox(height: size.width * 0.42,),
                    remainingTimer == "0"
                      ? Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            child: customText.kText("Resend OTP", 18, FontWeight.w900, Colors.blue.shade900, TextAlign.start),
                            onTap: () {
                              if(resendOTPTimes < 3) {
                                resendOTP();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Session time out please try again later !!!!")));
                              }
                            },
                          )
                        )
                      : Align(
                          alignment: Alignment.center,
                          // child: customText.kText("You can resend code request in $remainingTimer s", 18, FontWeight.w600, Colors.black, TextAlign.start),
                          child: RichText(
                            text: TextSpan(
                              text: "You can resend code request in",
                              style: customText.kTextStyle(18, FontWeight.w600, Colors.black),
                              children: [
                                TextSpan(
                                  text: " $remainingTimer ",
                                  style: customText.kTextStyle(20, FontWeight.w900, Colors.blue.shade900),
                                ),
                                TextSpan(
                                  text: "s",
                                  style: customText.kTextStyle(18, FontWeight.w600, Colors.black),
                                ),
                              ]
                            ),
                          )
                        ),
                    SizedBox(height: size.width * 0.1,),
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
                              : customText.kText("Confirm", 30, FontWeight.w700, Colors.white, TextAlign.center),
                        ),
                      ),
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        // confirmOTP();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const CreatePassword() ));
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
