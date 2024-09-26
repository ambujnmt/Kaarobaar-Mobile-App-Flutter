import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaarobaar/constants/color_constants.dart';
import 'package:kaarobaar/controllers/side_drawerController.dart';
import 'package:kaarobaar/utils/helper.dart';
import 'package:kaarobaar/utils/text.dart';

class AddEditMyJob extends StatefulWidget {
  const AddEditMyJob({super.key});

  @override
  State<AddEditMyJob> createState() => _AddEditMyJobState();
}

class _AddEditMyJobState extends State<AddEditMyJob> {
  final customText = CustomText(), helper = Helper();
  dynamic size;
  bool isApiCalling = false;
  SideDrawerController sideDrawerController = Get.put(SideDrawerController());

  TextEditingController jobTitleController = TextEditingController();
  TextEditingController jobTypeController = TextEditingController();
  TextEditingController jobDescriptionController = TextEditingController();
  TextEditingController jobLocationController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController vacancyControlller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                controller: jobTitleController,
                decoration: InputDecoration(
                  hintText: "Job Title",
                  hintStyle: customText.kTextStyle(
                      16, FontWeight.w400, ColorConstants.kIconsGrey),
                ),
              ),
              SizedBox(
                height: size.width * 0.05,
              ),
              TextField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                controller: jobTypeController,
                decoration: InputDecoration(
                  hintText: "Job Type",
                  hintStyle: customText.kTextStyle(
                      16, FontWeight.w400, ColorConstants.kIconsGrey),
                ),
              ),
              SizedBox(
                height: size.width * 0.05,
              ),
              TextField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                controller: jobDescriptionController,
                decoration: InputDecoration(
                  hintText: "Job Description",
                  hintStyle: customText.kTextStyle(
                      16, FontWeight.w400, ColorConstants.kIconsGrey),
                ),
              ),
              SizedBox(
                height: size.width * 0.05,
              ),
              TextField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                controller: jobLocationController,
                decoration: InputDecoration(
                  hintText: "Job Location",
                  hintStyle: customText.kTextStyle(
                      16, FontWeight.w400, ColorConstants.kIconsGrey),
                ),
              ),
              SizedBox(
                height: size.width * 0.05,
              ),
              TextField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                controller: qualificationController,
                decoration: InputDecoration(
                  hintText: "Qualification",
                  hintStyle: customText.kTextStyle(
                      16, FontWeight.w400, ColorConstants.kIconsGrey),
                ),
              ),
              SizedBox(
                height: size.width * 0.05,
              ),
              TextField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "Contact Email",
                  hintStyle: customText.kTextStyle(
                      16, FontWeight.w400, ColorConstants.kIconsGrey),
                ),
              ),
              SizedBox(
                height: size.width * 0.05,
              ),
              TextField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                controller: mobileController,
                decoration: InputDecoration(
                  hintText: "Mobile",
                  hintStyle: customText.kTextStyle(
                      16, FontWeight.w400, ColorConstants.kIconsGrey),
                ),
              ),
              SizedBox(
                height: size.width * 0.05,
              ),
              TextField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                controller: salaryController,
                decoration: InputDecoration(
                  hintText: "Salary",
                  hintStyle: customText.kTextStyle(
                      16, FontWeight.w400, ColorConstants.kIconsGrey),
                ),
              ),
              SizedBox(
                height: size.width * 0.05,
              ),
              TextField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                controller: vacancyControlller,
                decoration: InputDecoration(
                  hintText: "No. Of Vacancy",
                  hintStyle: customText.kTextStyle(
                      16, FontWeight.w400, ColorConstants.kIconsGrey),
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
                        : sideDrawerController.myBusinessId.isEmpty
                            ? customText.kText("Register", 30, FontWeight.w700,
                                Colors.white, TextAlign.center)
                            : customText.kText("Update", 30, FontWeight.w700,
                                Colors.white, TextAlign.center),
                  ),
                ),
                onTap: () {
                  // addBusiness();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
