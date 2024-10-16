import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:kaarobaar/constants/color_constants.dart';
import 'package:kaarobaar/controllers/side_drawerController.dart';
import 'package:kaarobaar/services/api_services.dart';
import 'package:kaarobaar/utils/helper.dart';
import 'package:kaarobaar/utils/text.dart';
import 'dart:developer';
import 'package:image_picker/image_picker.dart';
import 'package:kaarobaar/views/screens/display_image.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  dynamic size;
  final customText = CustomText(), helper = Helper();
  String eventDate = "",
      eventTime = "",
      tempPickedDate = "",
      currentDate = "",
      eventImage = "";
  TextEditingController eventNameController = TextEditingController();
  TextEditingController eventLocationController = TextEditingController();
  TextEditingController eventDescController = TextEditingController();
  bool isApiCalling = false;
  final api = API();
  SideDrawerController sideDrawerController = Get.put(SideDrawerController());
  Map<String, dynamic> getEventDetailData = {};

  galleryCameraDialog() {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorConstants.kTestimonialsLightRed,
          title: customText.kText("Pick image from", 25, FontWeight.w700,
              Colors.white, TextAlign.start),
          actions: <Widget>[
            TextButton(
              child: customText.kText("Gallery", 20, FontWeight.w600,
                  Colors.white, TextAlign.start),
              onPressed: () {
                pickImage(1);
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: customText.kText(
                  "Camera", 20, FontWeight.w600, Colors.white, TextAlign.start),
              onPressed: () {
                pickImage(2);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  pickImage(int from) async {
    final picker = ImagePicker();
    final XFile? photo;

    if (from == 1) {
      photo =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 30);
    } else {
      photo =
          await picker.pickImage(source: ImageSource.camera, imageQuality: 30);
    }

    eventImage = photo!.path;
    setState(() {});

    log("checking event Image :- $eventImage");

    if (photo != null) {
      // Do something with the image file (pickedImage.path)
    }
  }

  addEventForm() async {
    if (eventNameController.text.isNotEmpty &&
        (!eventNameController.text.startsWith(" "))) {
      if (eventDate.isNotEmpty) {
        if (eventTime.isNotEmpty) {
          if (eventLocationController.text.isNotEmpty &&
              (!eventLocationController.text.startsWith(" "))) {
            if (eventImage.isNotEmpty) {
              if (eventDescController.text.isNotEmpty &&
                  !eventDescController.text.startsWith(' ')) {
                setState(() {
                  isApiCalling = true;
                });

                var response;

                if (sideDrawerController.myEventsId.isEmpty) {
                  print('inside the add event function');
                  response = await api.addEvent(
                    sideDrawerController.businessListingId,
                    eventNameController.text,
                    eventDate.toString(),
                    eventTime.toString(),
                    eventLocationController.text,
                    eventImage.toString(),
                    eventDescController.text,
                  );
                } else {
                  print('inside the event edit function');
                  response = await api.updateEventDetails(
                    eventNameController.text,
                    eventDate.toString(),
                    eventTime.toString(),
                    eventLocationController.text,
                    eventImage.toString(),
                    eventDescController.text,
                    sideDrawerController.myEventsId,
                    sideDrawerController.eventBusinessId,
                  );
                }

                setState(() {
                  isApiCalling = false;
                });

                if (response["status"] == 1) {
                  helper.successDialog(context, response["message"]);
                  sideDrawerController.pageIndex.value = 0;
                  sideDrawerController.pageController.jumpToPage(0);
                } else {
                  helper.errorDialog(context, response["message"]);
                }
              } else {
                helper.errorDialog(context, 'Please enter event description');
              }
            } else {
              helper.errorDialog(context, "Please upload image");
            }
          } else {
            helper.errorDialog(context, "Please enter event location");
          }
        } else {
          helper.errorDialog(context, "Please select event time");
        }
      } else {
        helper.errorDialog(context, "Please select event date");
      }
    } else {
      helper.errorDialog(context, "Please enter event name");
    }
  }

  getEventsDetail() async {
    setState(() {
      isApiCalling = true;
    });

    final response = await api.myEventDetail(sideDrawerController.myEventsId);

    setState(() {
      getEventDetailData = response['result'];
    });

    setState(() {
      isApiCalling = false;
    });
    if (response['status'] == 1) {
      print('status 1');
      eventNameController.text = getEventDetailData['event_title'];
      eventDate = getEventDetailData['event_date'];
      eventTime = getEventDetailData['event_time'];
      eventLocationController.text = getEventDetailData['event_location'];
      eventImage = getEventDetailData['event_image'];
      eventDescController.text = getEventDetailData['event_description'];
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('my event list id: ${sideDrawerController.businessListingId}');
    print('my event id for edit:  ${sideDrawerController.myEventsId}');
    if (sideDrawerController.myEventsId.isNotEmpty) {
      getEventsDetail();
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      height: size.height * 0.77,
      width: size.width,
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
      // color: Colors.lightBlue.shade100,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
              child: customText.kText("Add Event Details", 30, FontWeight.w700,
                  Colors.black, TextAlign.start),
            ),
            Container(
              height: size.height * 0.06,
              width: size.width,
              padding: EdgeInsets.only(left: size.width * 0.02),
              decoration: const BoxDecoration(
                border: Border(
                  bottom:
                      BorderSide(width: 1.0, color: ColorConstants.kIconsGrey),
                ),
              ),
              child: TextField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                controller: eventNameController,
                style: customText.kTextStyle(20, FontWeight.w500, Colors.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Name",
                  hintStyle: customText.kTextStyle(
                      16, FontWeight.w400, ColorConstants.kIconsGrey),
                ),
              ),
            ),
            SizedBox(
              height: size.width * 0.05,
            ),
            GestureDetector(
              child: Container(
                height: size.height * 0.06,
                width: size.width,
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        width: 1.0, color: ColorConstants.kIconsGrey),
                  ),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: eventDate != ""
                      ? customText.kText(eventDate, 20, FontWeight.w500,
                          Colors.black, TextAlign.start)
                      : customText.kText("Date", 16, FontWeight.w500,
                          ColorConstants.kIconsGrey, TextAlign.start),
                ),
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2200));

                currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
                tempPickedDate = DateFormat('dd-MM-yyyy').format(pickedDate!);

                if (pickedDate != null) {
                  if (pickedDate.isAfter(DateTime.now()) ||
                      tempPickedDate == currentDate) {
                    eventDate = DateFormat('dd-MM-yyyy').format(pickedDate);
                    setState(() {});
                  } else {
                    helper.errorDialog(context, "Please select valid date");
                  }
                } else {
                  helper.errorDialog(context, "Date is not picked");
                }
                print('event date: $eventDate');
              },
            ),
            SizedBox(
              height: size.width * 0.05,
            ),
            GestureDetector(
              child: Container(
                height: size.height * 0.06,
                width: size.width,
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        width: 1.0, color: ColorConstants.kIconsGrey),
                  ),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: eventTime != ""
                      ? customText.kText(eventTime, 20, FontWeight.w500,
                          Colors.black, TextAlign.start)
                      : customText.kText("Time", 16, FontWeight.w500,
                          ColorConstants.kIconsGrey, TextAlign.start),
                ),
              ),
              onTap: () async {
                if (currentDate != "") {
                  TimeOfDay initialTime = TimeOfDay.now();
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: initialTime,
                  );

                  if (pickedTime != null) {
                    if (tempPickedDate == currentDate) {
                      if (pickedTime.hour > DateTime.now().hour) {
                        eventTime = pickedTime.format(context);
                      } else if (pickedTime.hour == DateTime.now().hour) {
                        if (pickedTime.minute > DateTime.now().minute) {
                          eventTime = pickedTime.format(context);
                        } else {
                          helper.successDialog(
                              context, "Please select future time");
                        }
                      }
                    } else {
                      eventTime = pickedTime.format(context);
                    }

                    setState(() {});
                  } else {
                    helper.errorDialog(context, "Time is not selected");
                  }
                } else {
                  helper.errorDialog(context, "Select event date first");
                }
                print('event time: $eventTime');
              },
            ),
            SizedBox(
              height: size.width * 0.05,
            ),
            Container(
              height: size.height * 0.06,
              width: size.width,
              padding: EdgeInsets.only(left: size.width * 0.02),
              decoration: const BoxDecoration(
                border: Border(
                  bottom:
                      BorderSide(width: 1.0, color: ColorConstants.kIconsGrey),
                ),
              ),
              child: TextField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                controller: eventLocationController,
                style: customText.kTextStyle(20, FontWeight.w500, Colors.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Location",
                  hintStyle: customText.kTextStyle(
                      16, FontWeight.w400, ColorConstants.kIconsGrey),
                ),
              ),
            ),
            SizedBox(
              height: size.width * 0.05,
            ),
            eventImage == ""
                ? GestureDetector(
                    child: Container(
                      height: size.height * 0.06,
                      width: size.width,
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.02),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 1.0, color: ColorConstants.kIconsGrey),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: customText.kText(
                            "Upload Image",
                            16,
                            FontWeight.w500,
                            ColorConstants.kIconsGrey,
                            TextAlign.start),
                      ),
                    ),
                    onTap: () {
                      galleryCameraDialog();
                    },
                  )
                : Container(
                    height: size.height * 0.06,
                    width: size.width,
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.02),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            width: 1.0, color: ColorConstants.kIconsGrey),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          child: customText.kText("Image uploaded(View)", 20,
                              FontWeight.w500, Colors.black, TextAlign.start),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DisplayImage(image: eventImage)));

                            print('event image: $eventImage');
                          },
                        ),
                        GestureDetector(
                          child: const Icon(Icons.delete,
                              size: 30, color: ColorConstants.kGradientRed),
                          onTap: () {
                            setState(() {
                              eventImage = "";
                            });
                          },
                        )
                      ],
                    ),
                  ),
            SizedBox(
              height: size.width * 0.05,
            ),
            Container(
              width: size.width,
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              decoration: const BoxDecoration(
                border: Border(
                  bottom:
                      BorderSide(width: 1.0, color: ColorConstants.kIconsGrey),
                ),
              ),
              child: TextField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                controller: eventDescController,
                maxLines: null,
                style: customText.kTextStyle(20, FontWeight.w500, Colors.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Event Description",
                  hintStyle: customText.kTextStyle(
                      16, FontWeight.w400, ColorConstants.kIconsGrey),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.1,
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
                  child: customText.kText("Continue", 30, FontWeight.w700,
                      Colors.white, TextAlign.center),
                ),
              ),
              onTap: () {
                // ontap of continue
                addEventForm();
              },
            )
          ],
        ),
      ),
    ));
  }
}
