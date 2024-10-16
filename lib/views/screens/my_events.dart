import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaarobaar/constants/color_constants.dart';
import 'package:kaarobaar/controllers/side_drawerController.dart';
import 'package:kaarobaar/services/api_services.dart';
import 'package:kaarobaar/utils/helper.dart';
import 'package:kaarobaar/utils/text.dart';

class ListByUserEvents extends StatefulWidget {
  const ListByUserEvents({super.key});

  @override
  State<ListByUserEvents> createState() => _ListByUserEventsState();
}

class _ListByUserEventsState extends State<ListByUserEvents> {
  final customText = CustomText(), helper = Helper();
  final api = API();
  bool isApiCalling = false;
  List<dynamic> myEventsListData = [];

  SideDrawerController sideDrawerController = Get.put(SideDrawerController());

  // Function to show an alert dialog
  void _showAlertDialog(BuildContext context, Function() deleteItem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: const Text(''),
          content: Container(
            margin: const EdgeInsets.only(top: 20),
            child: const Text(
              ' Are you sure want to delete this job ?',
              style: TextStyle(fontFamily: 'Raleway'),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                    fontFamily: 'Raleway', color: Color.fromRGBO(164, 0, 0, 1)),
              ),
            ),
            TextButton(
              onPressed: () {
                // Perform any action here, then close the dialog
                deleteItem();
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(
                    fontFamily: 'Raleway', color: Color.fromRGBO(9, 103, 9, 1)),
              ),
            ),
          ],
        );
      },
    );
  }

  getMyEvents() async {
    setState(() {
      isApiCalling = true;
    });
    final response = await api.myEventList();
    setState(() {
      myEventsListData = response['result'];
    });
    setState(() {
      isApiCalling = false;
    });

    print(' get my job ----$myEventsListData');
  }

  @override
  void initState() {
    super.initState();
    getMyEvents();
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
                itemCount: myEventsListData.length,
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customText.kText(
                                  'Event title:  ',
                                  18,
                                  FontWeight.w700,
                                  Colors.black,
                                  TextAlign.start),
                              Container(
                                width: width * .5,
                                child: customText.kText(
                                    '${myEventsListData[index]['event_title']}',
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customText.kText(
                                  'Event Location:  ',
                                  18,
                                  FontWeight.w700,
                                  Colors.black,
                                  TextAlign.start),
                              customText.kText(
                                  '${myEventsListData[index]['event_location']}',
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
                                  'Event Date:  ',
                                  18,
                                  FontWeight.w700,
                                  Colors.black,
                                  TextAlign.start),
                              customText.kText(
                                  '${myEventsListData[index]['event_date']}',
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
                                  'Event Time:  ',
                                  18,
                                  FontWeight.w700,
                                  Colors.black,
                                  TextAlign.start),
                              customText.kText(
                                  '${myEventsListData[index]['event_time']}',
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
                                  'Event Description:  ',
                                  18,
                                  FontWeight.w700,
                                  Colors.black,
                                  TextAlign.start),
                              customText.kText(
                                  '${myEventsListData[index]['event_description']}',
                                  16,
                                  FontWeight.w400,
                                  Colors.black,
                                  TextAlign.start)
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                      ColorConstants.kGradientDarkGreen,
                                      ColorConstants.kGradientLightGreen
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
                                // sideDrawerController.pageIndex.value = 27;
                                // sideDrawerController.myJobDetailId =
                                //     myEventsListData[index]["id"];
                                // sideDrawerController.businessId =
                                //     myEventsListData[index]["business_id"];
                                // sideDrawerController.pageController
                                //     .jumpToPage(27);
                              },
                            ),
                            GestureDetector(
                              child: Container(
                                height: 30,
                                width: 100,
                                decoration: BoxDecoration(
                                  // color: Colors.black,
                                  borderRadius: BorderRadius.circular(8),
                                  gradient: const RadialGradient(
                                    center: Alignment(0.19, -0.9),
                                    colors: [
                                      // Color(0xffa40000),
                                      // Color(0xff262626)
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
                                        await api.deleteMyEvent(
                                            myEventsListData[index]['id']);
                                    if (deleteResponse['status'] == 1) {
                                      helper.successDialog(
                                          context, deleteResponse['message']);
                                    } else {
                                      helper.errorDialog(
                                          context, deleteResponse['message']);
                                    }
                                    getMyEvents();
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
    );
  }
}
