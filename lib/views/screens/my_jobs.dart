import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaarobaar/constants/color_constants.dart';
import 'package:kaarobaar/controllers/side_drawerController.dart';
import 'package:kaarobaar/services/api_services.dart';
import 'package:kaarobaar/utils/helper.dart';
import 'package:kaarobaar/utils/text.dart';

class MyJobs extends StatefulWidget {
  const MyJobs({super.key});

  @override
  State<MyJobs> createState() => _MyJobsState();
}

class _MyJobsState extends State<MyJobs> {
  final customText = CustomText(), helper = Helper();
  final api = API();
  bool isApiCalling = false;
  List<dynamic> myJobsListData = [];

  SideDrawerController sideDrawerController = Get.put(SideDrawerController());

  // Function to show an alert dialog
  void _showAlertDialog(BuildContext context, Function() deleteItem) {
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
              ' Are you sure want to delete this job ?',
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
                      Color(0xffD50000),
                      Color(0xff760000),
                    ],
                    radius: 4.0,
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                // Perform any action here, then close the dialog
                deleteItem();
                Navigator.of(context).pop();
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
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // get public jobs list api
  int statusValue = 0;
  getMyJobs() async {
    setState(() {
      isApiCalling = true;
    });
    final response = await api.myJobsListing();
    setState(() {
      statusValue = response['status'];
      print("Status Value: ${statusValue} ");
      myJobsListData = response['result'];
    });
    setState(() {
      isApiCalling = false;
    });

    print(' get my jobs ----$myJobsListData');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('init page --- ${sideDrawerController.pageIndex.value}');
    getMyJobs();
    if (statusValue == 0) {
      isApiCalling = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: Colors.white,
      body: isApiCalling
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : statusValue == 0
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: height * 0.05,
                      width: width * 0.8,
                      margin: EdgeInsets.all(20),
                      // margin: EdgeInsets.symmetric(vertical: size.width * 0.05),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(width * 0.05),
                          gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                ColorConstants.kGradientDarkGreen,
                                ColorConstants.kGradientLightGreen
                              ])),
                      child: Center(
                        child: customText.kText("My Jobs", 20, FontWeight.w700,
                            Colors.white, TextAlign.center),
                      ),
                    ),
                    Expanded(
                        child: Container(
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(8)),
                          height: 50,
                          width: width * .400,
                          child: Center(
                            child: customText.kText(
                                "No data found",
                                15,
                                FontWeight.w700,
                                Colors.black,
                                TextAlign.center),
                          ),
                        ),
                      ),
                    ))
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        height: height * 0.05,
                        width: width * 0.8,
                        margin: const EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 10),
                        // margin: EdgeInsets.symmetric(vertical: size.width * 0.05),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(width * 0.05),
                            gradient: const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  ColorConstants.kGradientDarkGreen,
                                  ColorConstants.kGradientLightGreen
                                ])),
                        child: Center(
                          child: customText.kText("My Jobs", 20,
                              FontWeight.w700, Colors.white, TextAlign.center),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                          margin: const EdgeInsets.all(10),
                          child: ListView.builder(
                            padding: const EdgeInsets.only(top: 0),
                            itemCount: myJobsListData.length,
                            itemBuilder: (BuildContext context, int index) =>
                                Card(
                              // elevation: 4,
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                // height: height * .250,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  // color: Colors.lightGreen,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          customText.kText(
                                              'Job title:  ',
                                              18,
                                              FontWeight.w700,
                                              Colors.black,
                                              TextAlign.start),
                                          Container(
                                            width: width * .5,
                                            child: customText.kText(
                                                '${myJobsListData[index]['job_title']}',
                                                16,
                                                FontWeight.w400,
                                                Colors.black,
                                                TextAlign.start),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          customText.kText(
                                              'Job type:  ',
                                              18,
                                              FontWeight.w700,
                                              Colors.black,
                                              TextAlign.start),
                                          customText.kText(
                                              '${myJobsListData[index]['job_type']}',
                                              16,
                                              FontWeight.w400,
                                              Colors.black,
                                              TextAlign.start)
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          customText.kText(
                                              'Location:  ',
                                              18,
                                              FontWeight.w700,
                                              Colors.black,
                                              TextAlign.start),
                                          customText.kText(
                                              '${myJobsListData[index]['job_location']}',
                                              16,
                                              FontWeight.w400,
                                              Colors.black,
                                              TextAlign.start)
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          customText.kText(
                                              'Qualification:  ',
                                              18,
                                              FontWeight.w700,
                                              Colors.black,
                                              TextAlign.start),
                                          customText.kText(
                                              '${myJobsListData[index]['job_qualification']}',
                                              16,
                                              FontWeight.w400,
                                              Colors.black,
                                              TextAlign.start)
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                        bottom: 5,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              customText.kText(
                                                  'Salary:  ',
                                                  18,
                                                  FontWeight.w700,
                                                  Colors.black,
                                                  TextAlign.start),
                                              customText.kText(
                                                  '${myJobsListData[index]['job_salary']}',
                                                  16,
                                                  FontWeight.w400,
                                                  Colors.black,
                                                  TextAlign.start),
                                              const SizedBox(width: 24),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              customText.kText(
                                                  'Vacancy:  ',
                                                  18,
                                                  FontWeight.w700,
                                                  Colors.black,
                                                  TextAlign.start),
                                              customText.kText(
                                                  '${myJobsListData[index]['vacancy']}',
                                                  16,
                                                  FontWeight.w400,
                                                  Colors.black,
                                                  TextAlign.start),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          customText.kText(
                                              'Posted on:  ',
                                              18,
                                              FontWeight.w700,
                                              Colors.black,
                                              TextAlign.start),
                                          Container(
                                            child: customText.kText(
                                                '${myJobsListData[index]['created_at']}',
                                                16,
                                                FontWeight.w400,
                                                Colors.black,
                                                TextAlign.start),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          customText.kText(
                                              'Approval Status:  ',
                                              18,
                                              FontWeight.w700,
                                              Colors.black,
                                              TextAlign.start),
                                          Container(
                                            child: customText.kText(
                                                myJobsListData[index]
                                                            ['job_status'] ==
                                                        "0"
                                                    ? 'Pending'
                                                    : 'Approved',
                                                16,
                                                FontWeight.w400,
                                                Colors.black,
                                                TextAlign.start),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          child: Container(
                                            height: 30,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              gradient: const RadialGradient(
                                                center: Alignment(0.19, -0.9),
                                                colors: [
                                                  ColorConstants
                                                      .kGradientDarkGreen,
                                                  ColorConstants
                                                      .kGradientLightGreen
                                                ],
                                                radius: 4.0,
                                              ),
                                            ),
                                            child: Center(
                                              child: customText.kText(
                                                  "Edit",
                                                  16,
                                                  FontWeight.w700,
                                                  Colors.white,
                                                  TextAlign.center),
                                            ),
                                          ),
                                          onTap: () {
                                            // FocusScope.of(context).unfocus();
                                            sideDrawerController
                                                .pageIndex.value = 27;
                                            sideDrawerController.myJobDetailId =
                                                myJobsListData[index]["id"];
                                            sideDrawerController.businessId =
                                                myJobsListData[index]
                                                    ["business_id"];
                                            sideDrawerController.pageController
                                                .jumpToPage(27);
                                          },
                                        ),
                                        GestureDetector(
                                          child: Container(
                                            height: 30,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              // color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              gradient: const RadialGradient(
                                                center: Alignment(0.19, -0.9),
                                                colors: [
                                                  Color(0xffD50000),
                                                  Color(0xff760000),
                                                ],
                                                radius: 4.0,
                                              ),
                                              // color: Color(0xffEE0200),
                                            ),
                                            child: Center(
                                              child: customText.kText(
                                                  "Delete",
                                                  16,
                                                  FontWeight.w700,
                                                  Colors.white,
                                                  TextAlign.center),
                                            ),
                                          ),
                                          onTap: () {
                                            _showAlertDialog(
                                              context,
                                              () async {
                                                final deleteResponse =
                                                    await api.deleteMyJobs(
                                                        myJobsListData[index]
                                                            ['id']);
                                                if (deleteResponse['status'] ==
                                                    1) {
                                                  helper.successDialog(
                                                      context,
                                                      deleteResponse[
                                                          'message']);
                                                } else {
                                                  helper.errorDialog(
                                                      context,
                                                      deleteResponse[
                                                          'message']);
                                                }
                                                getMyJobs();
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
    );
  }
}
