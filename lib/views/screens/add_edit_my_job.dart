import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaarobaar/constants/color_constants.dart';
import 'package:kaarobaar/controllers/side_drawerController.dart';
import 'package:kaarobaar/services/api_services.dart';
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
  final api = API();
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

  Map<String, dynamic> myJobDetail = {};

  addEditJob() async {
    if (jobTitleController.text.isNotEmpty &&
        (!jobTitleController.text.startsWith(" "))) {
      if (jobTypeController.text.isNotEmpty &&
          (!jobTypeController.text.startsWith(" "))) {
        if (jobDescriptionController.text.isNotEmpty &&
            (!jobDescriptionController.text.startsWith(" "))) {
          if (jobLocationController.text.isNotEmpty &&
              (!jobLocationController.text.startsWith(" "))) {
            if (qualificationController.text.isNotEmpty &&
                (!qualificationController.text.startsWith(" "))) {
              if (EmailValidator.validate(emailController.text)) {
                if (mobileController.text.length == 10) {
                  if (salaryController.text.isNotEmpty &&
                      (!salaryController.text.startsWith(" "))) {
                    if (vacancyControlller.text.isNotEmpty &&
                        (!vacancyControlller.text.startsWith(" "))) {
                      setState(() {
                        isApiCalling = true;
                      });
                      var response;
                      if (sideDrawerController.myJobDetailId.isEmpty &&
                          sideDrawerController.businessId.isEmpty) {
                        print('inside the add job');
                        response = await api.addJobs(
                            sideDrawerController.businessListingId,
                            jobTitleController.text,
                            jobTypeController.text,
                            jobDescriptionController.text,
                            jobLocationController.text,
                            qualificationController.text,
                            emailController.text,
                            mobileController.text,
                            salaryController.text,
                            vacancyControlller.text);
                      } else {
                        print('inside the edit job');
                        response = await api.updateJobs(
                            sideDrawerController.businessId,
                            sideDrawerController.myJobDetailId,
                            jobTitleController.text,
                            jobTypeController.text,
                            jobDescriptionController.text,
                            jobLocationController.text,
                            qualificationController.text,
                            emailController.text,
                            mobileController.text,
                            salaryController.text,
                            vacancyControlller.text);
                      }

                      setState(() {
                        isApiCalling = false;
                      });
                      if (response["status"] == 1) {
                        helper.successDialog(context, response["message"]);
                        print('Job Added successfully');
                        sideDrawerController.pageIndex.value = 26;
                        sideDrawerController.pageController.jumpToPage(26);
                      } else {
                        helper.errorDialog(context, response["message"]);
                      }
                    } else {
                      helper.errorDialog(
                          context, "Please enter number of vacancy");
                    }
                  } else {
                    helper.errorDialog(context, "Please enter salary");
                  }
                } else {
                  helper.errorDialog(context, "Please enter mobile");
                }
              } else {
                helper.errorDialog(context, "Please enter email");
              }
            } else {
              helper.errorDialog(context, "Please enter qualication");
            }
          } else {
            helper.errorDialog(context, "Please enter job location");
          }
        } else {
          helper.errorDialog(context, "Please enter job description");
        }
      } else {
        helper.errorDialog(context, "Please enter job type");
      }
    } else {
      helper.errorDialog(context, "Please enter job title");
    }
  }

  // job detail by id
  myJobDetailById() async {
    setState(() {
      isApiCalling = true;
    });

    final response =
        await api.publicJobDetail(sideDrawerController.myJobDetailId);

    setState(() {
      myJobDetail = response['result'];
    });

    setState(() {
      isApiCalling = false;
    });
    if (response['status'] == 1) {
      jobTitleController.text = myJobDetail['job_title'] ?? "";
      jobTypeController.text = myJobDetail['job_type'] ?? "";
      jobDescriptionController.text = myJobDetail['job_description'] ?? "";
      jobLocationController.text = myJobDetail['job_location'] ?? "";
      qualificationController.text = myJobDetail['job_qualification'] ?? "";
      emailController.text = myJobDetail['job_email'] ?? "";
      mobileController.text = myJobDetail['job_mobile'] ?? "";
      salaryController.text = myJobDetail['job_salary'] ?? "";
      vacancyControlller.text = myJobDetail['vacancy'] ?? "";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (sideDrawerController.myJobDetailId.isNotEmpty &&
        sideDrawerController.businessId.isNotEmpty) {
      myJobDetailById();
    }
    print(
        'business listing id---------${sideDrawerController.businessListingId}');
  }

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
                keyboardType: TextInputType.number,
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
                keyboardType: TextInputType.number,
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
                            ? customText.kText("Submit", 30, FontWeight.w700,
                                Colors.white, TextAlign.center)
                            : customText.kText("Update", 30, FontWeight.w700,
                                Colors.white, TextAlign.center),
                  ),
                ),
                onTap: () {
                  addEditJob();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
