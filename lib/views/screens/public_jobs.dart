import 'package:flutter/material.dart';
import 'package:kaarobaar/services/api_services.dart';
import 'package:kaarobaar/utils/helper.dart';
import 'package:kaarobaar/utils/text.dart';
import 'package:intl/intl.dart';

class PublicJobs extends StatefulWidget {
  const PublicJobs({super.key});

  @override
  State<PublicJobs> createState() => _PublicJobsState();
}

class _PublicJobsState extends State<PublicJobs> {
  final customText = CustomText(), helper = Helper();
  final api = API();
  bool isApiCalling = false;
  List<dynamic> publicJobsListData = [];

  // get public jobs list api
  getPublicJobs() async {
    setState(() {
      isApiCalling = true;
    });
    final response = await api.publicJobsListing();
    setState(() {
      publicJobsListData = response['result'];
    });
    setState(() {
      isApiCalling = false;
    });

    print(' get public jobs ----$publicJobsListData');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPublicJobs();
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
          : Container(
              margin: const EdgeInsets.all(10),
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 0),
                itemCount: publicJobsListData.length,
                itemBuilder: (BuildContext context, int index) => Card(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  customText.kText(
                                      'Job title:  ',
                                      18,
                                      FontWeight.w700,
                                      Colors.black,
                                      TextAlign.start),
                                  Container(
                                    width: width * .35,
                                    child: customText.kText(
                                        '${publicJobsListData[index]['job_title']}',
                                        16,
                                        FontWeight.w400,
                                        Colors.black,
                                        TextAlign.start),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 20),
                              GestureDetector(
                                child: Container(
                                  height: 30,
                                  width: 100,
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
                                        "See Details",
                                        16,
                                        FontWeight.w700,
                                        Colors.white,
                                        TextAlign.center),
                                  ),
                                ),
                                onTap: () {
                                  // FocusScope.of(context).unfocus();
                                  // sideDrawerController.pageIndex.value = 19;
                                  // sideDrawerController.ourServiceId = servicesListData[index]["id"];
                                  // sideDrawerController.pageController.jumpToPage(19);
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customText.kText(
                                  'Job type:  ',
                                  18,
                                  FontWeight.w700,
                                  Colors.black,
                                  TextAlign.start),
                              customText.kText(
                                  '${publicJobsListData[index]['job_type']}',
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
                                  '${publicJobsListData[index]['job_location']}',
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customText.kText(
                                  'Qualification:  ',
                                  18,
                                  FontWeight.w700,
                                  Colors.black,
                                  TextAlign.start),
                              customText.kText(
                                  '${publicJobsListData[index]['job_qualification']}',
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  customText.kText(
                                      'Salary:  ',
                                      18,
                                      FontWeight.w700,
                                      Colors.black,
                                      TextAlign.start),
                                  customText.kText(
                                      '${publicJobsListData[index]['job_salary']}',
                                      16,
                                      FontWeight.w400,
                                      Colors.black,
                                      TextAlign.start),
                                  const SizedBox(width: 24),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  customText.kText(
                                      'Vacancy:  ',
                                      18,
                                      FontWeight.w700,
                                      Colors.black,
                                      TextAlign.start),
                                  customText.kText(
                                      '${publicJobsListData[index]['vacancy']}',
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customText.kText(
                                  'Posted on:  ',
                                  18,
                                  FontWeight.w700,
                                  Colors.black,
                                  TextAlign.start),
                              customText.kText(
                                  '${publicJobsListData[index]['created_at']}',
                                  16,
                                  FontWeight.w400,
                                  Colors.black,
                                  TextAlign.start),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
    );
  }
}
