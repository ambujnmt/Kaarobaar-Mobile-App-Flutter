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

  // Function to show an alert dialog
  void _showAlertDialog(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: const Text(''),
          content: Container(
            margin: const EdgeInsets.only(top: 20),
            child: const Text(
              'Admin approval is pending. Once it is approved will be visible to all',
              style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Container(
                height: h * .030,
                width: w * .2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const RadialGradient(
                    center: Alignment(0.19, -0.9),
                    colors: [
                      ColorConstants.kGradientDarkGreen,
                      ColorConstants.kGradientLightGreen
                    ],
                    radius: 4.0,
                  ),
                ),
                child: const Center(
                  child: Text(
                    'OK',
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  addEditJob() async {
    if (jobTitleController.text.isNotEmpty &&
        (!jobTitleController.text.startsWith(" "))) {
      if (dropdownvalue.isNotEmpty && dropdownvalue != "Select") {
        if (jobDescriptionController.text.isNotEmpty &&
            (!jobDescriptionController.text.startsWith(" "))) {
          if (jobLocationController.text.isNotEmpty &&
              (!jobLocationController.text.startsWith(" "))) {
            if (qualificationController.text.isNotEmpty &&
                (!qualificationController.text.startsWith(" "))) {
              if (EmailValidator.validate(emailController.text)) {
                if (mobileController.text.length >= 10 &&
                    mobileController.text.length <= 12) {
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
                            dropdownvalue.toString(),
                            jobDescriptionController.text,
                            jobLocationController.text,
                            qualificationController.text,
                            emailController.text,
                            mobileController.text,
                            salaryController.text,
                            vacancyControlller.text);

                        if (response['status'] == 1) {
                          _showAlertDialog(context);
                        }
                      } else {
                        print('inside the edit job');
                        response = await api.updateJobs(
                            sideDrawerController.businessId,
                            sideDrawerController.myJobDetailId,
                            jobTitleController.text,
                            dropdownvalue.toString(),
                            jobDescriptionController.text,
                            jobLocationController.text,
                            qualificationController.text,
                            emailController.text,
                            mobileController.text,
                            salaryController.text,
                            vacancyControlller.text);

                        if (response['status'] == 1) {
                          sideDrawerController.myJobDetailId = "";
                          _showAlertDialog(context);
                        }
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
                  helper.errorDialog(context, "Please enter valid mobile");
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
      dropdownvalue = myJobDetail['job_type'] ?? "";
      jobDescriptionController.text = myJobDetail['job_description'] ?? "";
      jobLocationController.text = myJobDetail['job_location'] ?? "";
      qualificationController.text = myJobDetail['job_qualification'] ?? "";
      emailController.text = myJobDetail['job_email'] ?? "";
      mobileController.text = myJobDetail['job_mobile'] ?? "";
      salaryController.text = myJobDetail['job_salary'] ?? "";
      vacancyControlller.text = myJobDetail['vacancy'] ?? "";
    }
  }

  String dropdownvalue = 'Select';
  var items = [
    'Select',
    'Full Time',
    'Part Time',
    'Hybrid',
    'Work From Home',
  ];

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
              // TextField(
              //   keyboardType: TextInputType.text,
              //   textInputAction: TextInputAction.next,
              //   textCapitalization: TextCapitalization.words,
              //   controller: jobTypeController,
              //   decoration: InputDecoration(
              //     hintText: "Job Type",
              //     hintStyle: customText.kTextStyle(
              //         16, FontWeight.w400, ColorConstants.kIconsGrey),
              //   ),
              // ),
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: ColorConstants.kIconsGrey, width: 1),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: ColorConstants.kIconsGrey, width: 1),
                  ),
                ),
                style: customText.kTextStyle(
                  16,
                  FontWeight.w200,
                  ColorConstants.kIconsGrey,
                ),
                isExpanded: true,
                value: dropdownvalue,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(
                      items,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                    print("Drop down value: ${dropdownvalue}");
                  });
                },
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
                maxLength: 12,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                controller: mobileController,
                decoration: InputDecoration(
                  counterText: "",
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
