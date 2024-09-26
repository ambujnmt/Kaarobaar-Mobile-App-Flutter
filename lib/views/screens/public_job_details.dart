import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaarobaar/controllers/side_drawerController.dart';
import 'package:kaarobaar/services/api_services.dart';
import 'package:kaarobaar/utils/helper.dart';
import 'package:kaarobaar/utils/text.dart';

class PublicJobDetails extends StatefulWidget {
  const PublicJobDetails({super.key});

  @override
  State<PublicJobDetails> createState() => _PublicJobDetailsState();
}

class _PublicJobDetailsState extends State<PublicJobDetails> {
  SideDrawerController sideDrawerController = Get.put(SideDrawerController());
  final customText = CustomText(), helper = Helper();
  final api = API();
  bool isApiLoading = false;
  Map<String, dynamic> publicJobDetail = {};

  publicJobDetailById() async {
    setState(() {
      isApiLoading = true;
    });

    final response =
        await api.publicJobDetail(sideDrawerController.jobDetailId);

    setState(() {
      publicJobDetail = response['result'];
    });

    setState(() {
      isApiLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('job detail id-------${sideDrawerController.jobDetailId}');
    publicJobDetailById();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: isApiLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Card(
                  elevation: 8,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: customText.kText('Company Name:  ', 18,
                              FontWeight.w700, Colors.black, TextAlign.start),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: customText.kText(
                              '${publicJobDetail['company_name']}',
                              16,
                              FontWeight.w400,
                              Colors.black,
                              TextAlign.start),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customText.kText(
                                  'Job Title:  ',
                                  18,
                                  FontWeight.w700,
                                  Colors.black,
                                  TextAlign.start),
                              customText.kText(
                                  '${publicJobDetail['job_title']}',
                                  16,
                                  FontWeight.w400,
                                  Colors.black,
                                  TextAlign.start),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customText.kText(
                                  'Location:  ',
                                  18,
                                  FontWeight.w700,
                                  Colors.black,
                                  TextAlign.start),
                              customText.kText(
                                  '${publicJobDetail['job_location']}',
                                  16,
                                  FontWeight.w400,
                                  Colors.black,
                                  TextAlign.start),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customText.kText(
                                  'Qualifications:  ',
                                  18,
                                  FontWeight.w700,
                                  Colors.black,
                                  TextAlign.start),
                              Container(
                                width: width * .52,
                                child: customText.kText(
                                    '${publicJobDetail['job_qualification']}',
                                    16,
                                    FontWeight.w400,
                                    Colors.black,
                                    TextAlign.start),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customText.kText('Salary:  ', 18, FontWeight.w700,
                                  Colors.black, TextAlign.start),
                              customText.kText(
                                  '${publicJobDetail['job_salary']}',
                                  16,
                                  FontWeight.w400,
                                  Colors.black,
                                  TextAlign.start),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customText.kText(
                                  'Vacancies:  ',
                                  18,
                                  FontWeight.w700,
                                  Colors.black,
                                  TextAlign.start),
                              customText.kText(
                                  '${publicJobDetail['vacancy']}',
                                  16,
                                  FontWeight.w400,
                                  Colors.black,
                                  TextAlign.start),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customText.kText(
                                  'Posted On:  ',
                                  18,
                                  FontWeight.w700,
                                  Colors.black,
                                  TextAlign.start),
                              customText.kText(
                                  '${publicJobDetail['created_at']}',
                                  16,
                                  FontWeight.w400,
                                  Colors.black,
                                  TextAlign.start),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: customText.kText('Description:  ', 18,
                              FontWeight.w700, Colors.black, TextAlign.start),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: customText.kText(
                              '${publicJobDetail['job_description']}',
                              16,
                              FontWeight.w400,
                              Colors.black,
                              TextAlign.start),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: customText.kText('Contact Information:  ', 18,
                              FontWeight.w700, Colors.black, TextAlign.start),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customText.kText('Email:  ', 18, FontWeight.w700,
                                  Colors.black, TextAlign.start),
                              customText.kText(
                                  '${publicJobDetail['job_email']}',
                                  16,
                                  FontWeight.w400,
                                  Colors.black,
                                  TextAlign.start),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customText.kText('Mobile:  ', 18, FontWeight.w700,
                                  Colors.black, TextAlign.start),
                              customText.kText(
                                  '${publicJobDetail['job_mobile']}',
                                  16,
                                  FontWeight.w400,
                                  Colors.black,
                                  TextAlign.start),
                            ],
                          ),
                        ),
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(bottom: 20),
                            height: 30,
                            width: width * .450,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(8),
                                gradient: const RadialGradient(
                                  center: Alignment(0.19, -0.9),
                                  colors: [
                                    Color(0xffa40000),
                                    Color(0xff262626)
                                  ],
                                  radius: 4.0,
                                )),
                            child: Center(
                              child: customText.kText(
                                  "Back to Job Listings",
                                  16,
                                  FontWeight.w700,
                                  Colors.white,
                                  TextAlign.center),
                            ),
                          ),
                          onTap: () {
                            // FocusScope.of(context).unfocus();
                            sideDrawerController.pageIndex.value = 24;
                            // sideDrawerController.jobDetailId =
                            //     publicJobsListData[index]["id"];
                            sideDrawerController.pageController.jumpToPage(24);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
