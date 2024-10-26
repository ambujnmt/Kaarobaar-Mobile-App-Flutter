import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:kaarobaar/constants/color_constants.dart';
import 'package:kaarobaar/utils/helper.dart';
import 'package:kaarobaar/utils/text.dart';
import 'package:kaarobaar/views/authorization/login_screen.dart';

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({super.key});

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  dynamic size;
  final customText = CustomText(), helper = Helper();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Container(
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.only(top: size.height * 0.01),
                  height: size.width * 0.08,
                  child: Image.asset("assets/images/logoText.png")),
              Container(
                height: size.height * 0.65,
                width: size.width * 0.8,
                margin: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05,
                    vertical: size.height * 0.08),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(size.width * 0.05)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.05,
                        horizontal: size.width * 0.02),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size.width * 0.05),
                        gradient: const RadialGradient(
                          center: Alignment(0.8, -0.35),
                          colors: [
                            ColorConstants.kGradientRed,
                            ColorConstants.kGradientBlack,
                          ],
                          radius: 1.3,
                        )),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: size.width * 0.2,
                          backgroundColor: Colors.white,
                          child: Container(
                            height: size.width * 0.15,
                            width: size.width * 0.15,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius:
                                    BorderRadius.circular(size.width * 0.03)),
                            child: const Center(
                              child: Icon(Icons.check_rounded,
                                  color: Colors.white, size: 45),
                            ),
                          ),
                        ),
                        customText.kText("Successful!", 35, FontWeight.w900,
                            Colors.white, TextAlign.center),
                        SizedBox(
                          height: size.width * 0.05,
                        ),
                        customText.kText(
                          "Your password has been changed successfully",
                          20,
                          FontWeight.w400,
                          Colors.white,
                          TextAlign.center,
                          maxLines: 2,
                        ),
                        SizedBox(
                          height: size.width * 0.2,
                        ),
                        GestureDetector(
                          child: Container(
                            height: size.height * 0.07,
                            width: size.width * 0.6,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(size.width * 0.03)),
                            child: Center(
                              child: customText.kText(
                                  "Go to home",
                                  30,
                                  FontWeight.w900,
                                  Colors.black,
                                  TextAlign.center),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          },
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
