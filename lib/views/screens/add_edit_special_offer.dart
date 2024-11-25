import 'dart:io';

import 'package:dio/dio.dart';
import 'package:drop_down_search_field/drop_down_search_field.dart';
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
import 'package:path_provider/path_provider.dart';

class AddEditSpecialOffer extends StatefulWidget {
  const AddEditSpecialOffer({super.key});

  @override
  State<AddEditSpecialOffer> createState() => _AddEditSpecialOfferState();
}

class _AddEditSpecialOfferState extends State<AddEditSpecialOffer> {
  dynamic size;
  final customText = CustomText(), helper = Helper();
  String eventDate = "",
      eventTime = "",
      tempPickedDate = "",
      currentDate = "",
      eventImage = "";
  bool cityCalling = false;
  String? selectedStateId;
  String? selectedCityId;
  String? selectedState;
  String? selectedCity;
  String profileURL = "";
  String? image1;
  bool imageSelected = false;
  bool isImageDownloading = false;
  TextEditingController offerNameController = TextEditingController();

  TextEditingController offerDescriptionController = TextEditingController();

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
      eventImage = photo!.path;
      imageSelected = true;
    } else {
      photo =
          await picker.pickImage(source: ImageSource.camera, imageQuality: 30);
      eventImage = photo!.path;
      imageSelected = true;
    }

    eventImage = photo!.path;
    setState(() {});

    log("checking event Image :- $eventImage");

    if (photo != null) {
      // Do something with the image file (pickedImage.path)
    }
  }

  addSpecialOffer() async {
    if (offerNameController.text.isNotEmpty &&
        (!offerNameController.text.startsWith(" "))) {
      if (eventImage.isNotEmpty) {
        if (offerDescriptionController.text.isNotEmpty &&
            !offerDescriptionController.text.startsWith(' ')) {
          setState(() {
            isApiCalling = true;
          });

          var response;

          // if (sideDrawerController.myEventsId.isEmpty) {
          // if (sideDrawerController.businessListingId.isEmpty) {
          print('inside the add special offer function');
          response = await api.addOffer(
            // sideDrawerController.businessListingId,
            // offerNameController.text,
            // eventImage.toString(),
            // offerDescriptionController.text,
            businessId: sideDrawerController.businessListingId,
            offerName: offerNameController.text,
            image: eventImage.toString(),
            offerDescription: offerDescriptionController.text,
          );
          // }
          // else {
          //   print('inside the edit special function');

          //   print("business id: ${sideDrawerController.eventBusinessId}");
          //   print("events id: ${sideDrawerController.myEventsId}");
          //   response = await api.updateOfferDetails(
          //     offerNameController.text,
          //     eventImage.toString(),
          //     offerDescriptionController.text,
          //     sideDrawerController.myEventsId,
          //     sideDrawerController.eventBusinessId,
          //   );

          //   if (response['status'] == 1) {
          //     sideDrawerController.myEventsId = "";
          //   }
          // }

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
          helper.errorDialog(context, 'Please enter offer description');
        }
      } else {
        helper.errorDialog(context, "Please upload image");
      }
    } else {
      helper.errorDialog(context, "Please enter offer name");
    }
  }

  // getEventsDetail() async {
  //   setState(() {
  //     isApiCalling = true;
  //   });

  //   final response = await api.myEventDetail(sideDrawerController.myEventsId);

  //   setState(() {
  //     getEventDetailData = response['result'];
  //   });

  //   setState(() {
  //     isApiCalling = false;
  //   });
  //   if (response['status'] == 1) {
  //     print('status 1');
  //     offerNameController.text = getEventDetailData['event_title'];
  //     eventImage = getEventDetailData['event_image'];
  //     offerDescriptionController.text = getEventDetailData['event_description'];
  //     selectedStateId = getEventDetailData['event_state_id'];
  //     selectedCityId = getEventDetailData['event_city_id'];
  //     profileURL = getEventDetailData['event_image'];
  //     // comment
  //     downloadAllImage();
  //   }
  // }

  downloadAllImage() async {
    late var appDocDir;

    if (Platform.isAndroid) {
      appDocDir = await getExternalStorageDirectory();
    } else if (Platform.isIOS) {
      appDocDir = await getApplicationDocumentsDirectory();
    }

    setState(() {
      isImageDownloading = true;
    });

    List temp = profileURL.toString().split(".");
    String fileExtension = temp.last;

    String fileUrl = profileURL;
    String savePath = "${appDocDir!.path}/image.$fileExtension";

    print("save path :- $savePath");

    await Dio().download(fileUrl, savePath, onReceiveProgress: (count, total) {
      print("${(count / total * 100).toStringAsFixed(0)}%");
    });

    // downloadedImages.add("${appDocDir!.path}/$fileName");

    eventImage = "${appDocDir!.path}/image.$fileExtension";
    print("image path 1 :- $eventImage");

    setState(() {
      isImageDownloading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print('my business id: ${sideDrawerController.businessListingId}');
    // print('my event id for edit:  ${sideDrawerController.myEventsId}');
    if (sideDrawerController.myEventsId.isNotEmpty) {
      // getEventsDetail();
    }
    print("page value is ==== ${sideDrawerController.pageIndex.value}");
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
              child: customText.kText("Add Special Offer", 30, FontWeight.w700,
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
                controller: offerNameController,
                style: customText.kTextStyle(20, FontWeight.w500, Colors.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: " Offer Name",
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
                            "Upload Offer Image",
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
                                builder: (context) => DisplayImage(
                                  image: eventImage,
                                ),
                              ),
                            );

                            print('offer image: $eventImage');
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
                maxLength: 200,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                controller: offerDescriptionController,
                maxLines: null,
                style: customText.kTextStyle(20, FontWeight.w500, Colors.black),
                decoration: InputDecoration(
                  counterText: "",
                  border: InputBorder.none,
                  hintText: "Offer Description",
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
                      : customText.kText("Continue", 30, FontWeight.w700,
                          Colors.white, TextAlign.center),
                ),
              ),
              onTap: () {
                // ontap of continue
                isApiCalling == false ? addSpecialOffer() : null;
              },
            )
          ],
        ),
      ),
    ));
  }
}
