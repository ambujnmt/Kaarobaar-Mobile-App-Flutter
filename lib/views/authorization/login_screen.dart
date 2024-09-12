import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kaarobaar/constants/color_constants.dart';
import 'package:kaarobaar/controllers/login_controller.dart';
import 'package:kaarobaar/services/api_services.dart';
import 'package:kaarobaar/utils/helper.dart';
import 'package:kaarobaar/utils/text.dart';
import 'package:kaarobaar/views/authorization/forgot_password.dart';
import 'package:kaarobaar/views/authorization/register_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:kaarobaar/views/screens/dashboard_screen.dart';
import 'package:kaarobaar/views/side_menuDrawer.dart';
import 'dart:developer';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  dynamic size;
  bool hidePass = true, isApiCalling = false;
  final customText = CustomText(),
      helper = Helper(),
      api = API(),
      box = GetStorage();
  double systemBarSpace = 0;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginController loginController = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      systemBarSpace = 1.5;
    } else if (Platform.isIOS) {
      systemBarSpace = -30;
    }
    // getAccessToken();
  }

  getAccessToken() async {
    final response = await api.getAccessToken();

    log("get accessToken response :- $response");

    if (response["status"] == 1) {
      loginController.accessToken = response["token"];

      box.write("accessToken", loginController.accessToken);

      log("access token in login screen :- ${loginController.accessToken}");
    }
  }

  login() async {
    if (EmailValidator.validate(emailController.text)) {
      if ((!passwordController.text.contains(" ")) &&
          passwordController.text.length >= 6) {
        setState(() {
          isApiCalling = true;
        });

        final response =
            await api.login(emailController.text, passwordController.text);

        setState(() {
          isApiCalling = false;
        });

        if (response["status"] == 1) {
          print(' if status----200');
          helper.successDialog(context, response["message"]);

          loginController.accessToken = response['result']['access_token'];
          loginController.userId = response['result']['user_id'];

          box.write('accessToken', response['result']['access_token']);
          box.write('userId', response['result']['user_id']);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SideMenuDrawer()),
          );
        } else {
          helper.errorDialog(context, response["message"]);
          print('else 1 ----200');
        }
      } else {
        helper.errorDialog(
            context, "Password should be atleast 6 characters and valid");
      }
    } else {
      helper.errorDialog(context, "Please input valid email address");
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
                          image: AssetImage("assets/images/bgImage.png"))),
                  child: Padding(
                    padding: Platform.isIOS
                        ? EdgeInsets.fromLTRB(size.width * 0.1,
                            size.width * 0.3, size.width * 0.1, 0)
                        : EdgeInsets.fromLTRB(size.width * 0.1,
                            size.width * 0.22, size.width * 0.1, 0),
                    child: Image.asset("assets/images/logoText.png"),
                  ),
                ),
              ),
              Container(
                height: size.height * 0.78,
                width: size.width,
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05,
                    vertical: size.height * 0.07),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(size.width * 0.1))),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customText.kText("Login", 30, FontWeight.w800,
                            Colors.black, TextAlign.left),
                        customText.kText("Please sign in to continue", 18,
                            FontWeight.w400, Colors.black, TextAlign.left),
                        SizedBox(
                          height: size.width * 0.1,
                        ),
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          controller: emailController,
                          decoration: InputDecoration(
                              hintText: "Email",
                              hintStyle: customText.kTextStyle(16,
                                  FontWeight.w400, ColorConstants.kIconsGrey),
                              prefixIcon: const Icon(
                                Icons.email,
                                color: ColorConstants.kIconsGrey,
                                size: 35,
                              )),
                        ),
                        SizedBox(
                          height: size.width * 0.03,
                        ),
                        TextField(
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          controller: passwordController,
                          obscureText: hidePass,
                          decoration: InputDecoration(
                              hintText: "Password",
                              hintStyle: customText.kTextStyle(16,
                                  FontWeight.w400, ColorConstants.kIconsGrey),
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: ColorConstants.kIconsGrey,
                                size: 35,
                              ),
                              suffixIcon: GestureDetector(
                                child: hidePass
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
                                    hidePass = !hidePass;
                                  });
                                },
                              )),
                        ),
                        SizedBox(
                          height: size.width * 0.03,
                        ),
                        GestureDetector(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: customText.kText("Forgot Password?", 18,
                                FontWeight.w700, Colors.black, TextAlign.start),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ForgotPassword(),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: size.width * 0.3,
                        ),
                        GestureDetector(
                          child: Container(
                            height: size.width * 0.13,
                            width: size.width,
                            decoration: BoxDecoration(
                                // color: ColorConstants.kGradientDarkGreen,
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
                                  : customText.kText(
                                      "Login",
                                      30,
                                      FontWeight.w700,
                                      Colors.white,
                                      TextAlign.center),
                            ),
                          ),
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            login();
                            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SideMenuDrawer() ));
                          },
                        ),
                        SizedBox(
                          height: size.width * 0.03,
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
                              child: customText.kText(
                                  "Registration",
                                  30,
                                  FontWeight.w700,
                                  Colors.white,
                                  TextAlign.center),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen()));
                          },
                        )
                      ]),
                ),
              )
            ],
          ),
        ));
  }
}
