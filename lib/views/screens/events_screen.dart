import 'package:flutter/material.dart';
import 'package:kaarobaar/constants/color_constants.dart';
import 'package:kaarobaar/services/api_services.dart';
import 'package:kaarobaar/utils/text.dart';

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  dynamic size;
  final customText = CustomText();
  bool isApiCalling = false;
  final api = API();
  List<dynamic> eventListData = [];
  // get events list screen
  getEventsList() async {
    setState(() {
      isApiCalling = true;
    });
    final response = await api.eventList();
    setState(() {
      eventListData = response['result'];
    });
    setState(() {
      isApiCalling = false;
    });

    print('event list data ----$eventListData');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEventsList();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
        // body: Center(
        //   child: Text("Events"),
        // ),
        body: eventListData.isEmpty
            ? Center(
                child: Container(
                  height: size.height * 0.25,
                  width: size.width,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(8)),
                      height: 50,
                      width: size.width * .400,
                      child: Center(
                        child: customText.kText("No data found", 15,
                            FontWeight.w700, Colors.black, TextAlign.center),
                      ),
                    ),
                  ),
                ),
              )
            : Container(
                height: size.height * 0.77,
                width: size.width,
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                child: Column(
                  children: [
                    Container(
                      height: size.height * 0.05,
                      width: size.width * 0.8,
                      margin: EdgeInsets.symmetric(vertical: size.width * 0.05),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius:
                              BorderRadius.circular(size.width * 0.05),
                          gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                ColorConstants.kGradientDarkGreen,
                                ColorConstants.kGradientLightGreen
                              ])),
                      child: Center(
                        child: customText.kText("Events Details", 20,
                            FontWeight.w700, Colors.white, TextAlign.center),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.67,
                      width: size.width,
                      // color: Colors.yellow,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(top: 10),
                        itemCount: eventListData.length,
                        itemBuilder: (context, index) {
                          return Container(
                            // height: size.height * 0.55,
                            width: size.width,
                            margin: const EdgeInsets.only(bottom: 30),
                            // color: Colors.grey.shade300,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: size.height * 0.2,
                                  width: size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(
                                        size.width * 0.05),
                                  ),
                                  child: eventListData[index]["event_image"]
                                              .toString() ==
                                          ""
                                      ? Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            image: const DecorationImage(
                                              image: AssetImage(
                                                'assets/images/no_image.jpeg',
                                              ),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        )
                                      : Image.network(
                                          "${eventListData[index]["event_image"]}",
                                          fit: BoxFit.fill,
                                        ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      customText.kText(
                                          "${eventListData[index]["event_title"]}",
                                          30,
                                          FontWeight.w700,
                                          Colors.black,
                                          TextAlign.start),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            height: size.width * 0.08,
                                            child: Image.asset(
                                                "assets/images/calender.png"),
                                          ),
                                          SizedBox(
                                              width: size.width * 0.35,
                                              child: customText.kText(
                                                  "Time :  ${eventListData[index]["event_time"]}",
                                                  16,
                                                  FontWeight.w500,
                                                  Colors.grey.shade800,
                                                  TextAlign.start)),
                                          SizedBox(
                                              width: size.width * 0.4,
                                              child: customText.kText(
                                                  "Date : ${eventListData[index]["event_date"]}",
                                                  16,
                                                  FontWeight.w500,
                                                  Colors.grey.shade800,
                                                  TextAlign.start)),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            height: size.width * 0.08,
                                            child: Image.asset(
                                                "assets/images/map.png"),
                                          ),
                                          SizedBox(
                                              width: size.width * 0.8,
                                              child: customText.kText(
                                                  "${eventListData[index]["event_location"]}",
                                                  16,
                                                  FontWeight.w500,
                                                  Colors.grey.shade800,
                                                  TextAlign.start)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "${eventListData[index]["event_description"]} ",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      fontFamily: "Raleway"),
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 5,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ));
  }
}
