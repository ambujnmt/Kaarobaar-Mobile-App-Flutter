import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:kaarobaar/controllers/side_drawerController.dart';
import 'package:kaarobaar/services/api_services.dart';
import 'package:kaarobaar/utils/text.dart';

class CommunityDetailTwo extends StatefulWidget {
  const CommunityDetailTwo({super.key});

  @override
  State<CommunityDetailTwo> createState() => _CommunityDetailTwoState();
}

class _CommunityDetailTwoState extends State<CommunityDetailTwo> {
  final customText = CustomText();
  SideDrawerController sideDrawerController = Get.put(SideDrawerController());
  bool isApiLoading = false;
  final api = API();
  List<dynamic> detailTwoListData = [];

  getDetailTwo() async {
    setState(() {
      isApiLoading = true;
    });

    final response =
        await api.myBusinessDetail(sideDrawerController.detailTwoId);

    setState(() {
      detailTwoListData = response['result'];
    });

    setState(() {
      isApiLoading = false;
    });
    if (response['status'] == 1) {
      print('status 1');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print('detail two id--------${sideDrawerController.detailTwoId}');
    getDetailTwo();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    dynamic size = MediaQuery.of(context).size;
    return Scaffold(
      body: isApiLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : detailTwoListData.isEmpty
              ? Container(
                  height: size.height * 0.25,
                  width: size.width,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(12)),
                      height: 50,
                      width: size.width * .400,
                      child: Center(
                        child: customText.kText("No data found", 15,
                            FontWeight.w700, Colors.black, TextAlign.center),
                      ),
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: height * .200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                                image: NetworkImage(
                                    '${detailTwoListData[0]['featured_image']}'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Card(
                          elevation: 10,
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 10, top: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.calendar_month),
                                    const SizedBox(width: 10),
                                    customText.kText(
                                        "${detailTwoListData[0]['created_at']}",
                                        15,
                                        FontWeight.w400,
                                        Colors.black,
                                        TextAlign.center),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    customText.kText(
                                        "Title:",
                                        15,
                                        FontWeight.w700,
                                        Colors.black,
                                        TextAlign.center),
                                    const SizedBox(width: 10),
                                    customText.kText(
                                        "${detailTwoListData[0]['business_title']}",
                                        15,
                                        FontWeight.w400,
                                        Colors.black,
                                        TextAlign.center),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    customText.kText(
                                        "Contact Number:",
                                        15,
                                        FontWeight.w700,
                                        Colors.black,
                                        TextAlign.center),
                                    const SizedBox(width: 10),
                                    customText.kText(
                                        "${detailTwoListData[0]['mobile']}",
                                        15,
                                        FontWeight.w400,
                                        Colors.black,
                                        TextAlign.center),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    customText.kText(
                                        "Email:",
                                        15,
                                        FontWeight.w700,
                                        Colors.black,
                                        TextAlign.center),
                                    const SizedBox(width: 10),
                                    customText.kText(
                                        "${detailTwoListData[0]['email']}",
                                        15,
                                        FontWeight.w400,
                                        Colors.black,
                                        TextAlign.center),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    customText.kText(
                                        "Address:",
                                        15,
                                        FontWeight.w700,
                                        Colors.black,
                                        TextAlign.center),
                                    const SizedBox(width: 10),
                                    customText.kText(
                                        "${detailTwoListData[0]['address']}",
                                        15,
                                        FontWeight.w400,
                                        Colors.black,
                                        TextAlign.center),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    customText.kText(
                                        "City:",
                                        15,
                                        FontWeight.w700,
                                        Colors.black,
                                        TextAlign.center),
                                    const SizedBox(width: 10),
                                    customText.kText(
                                        "${detailTwoListData[0]['city_name']}",
                                        15,
                                        FontWeight.w400,
                                        Colors.black,
                                        TextAlign.center),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    customText.kText(
                                        "State:",
                                        15,
                                        FontWeight.w700,
                                        Colors.black,
                                        TextAlign.center),
                                    const SizedBox(width: 10),
                                    customText.kText(
                                        "${detailTwoListData[0]['state_name'] ?? ""}",
                                        15,
                                        FontWeight.w400,
                                        Colors.black,
                                        TextAlign.center),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    customText.kText(
                                        "Country:",
                                        15,
                                        FontWeight.w700,
                                        Colors.black,
                                        TextAlign.center),
                                    const SizedBox(width: 10),
                                    customText.kText(
                                        "${detailTwoListData[0]['country_name']}",
                                        15,
                                        FontWeight.w400,
                                        Colors.black,
                                        TextAlign.center),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    customText.kText(
                                        "Postal Code:",
                                        15,
                                        FontWeight.w700,
                                        Colors.black,
                                        TextAlign.center),
                                    const SizedBox(width: 10),
                                    customText.kText(
                                        "${detailTwoListData[0]['zipcode'] ?? ""}",
                                        15,
                                        FontWeight.w400,
                                        Colors.black,
                                        TextAlign.center),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                customText.kText(
                                    "Description:",
                                    15,
                                    FontWeight.w700,
                                    Colors.black,
                                    TextAlign.center),
                                const SizedBox(height: 10),
                                Container(
                                  width: width,
                                  child: Text(
                                    "${detailTwoListData[0]['business_description']}",
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                        fontFamily: "Raleway"),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
