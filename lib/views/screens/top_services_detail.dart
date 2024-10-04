import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:kaarobaar/controllers/side_drawerController.dart';
import 'package:kaarobaar/services/api_services.dart';

import '../../utils/text.dart';

class TopServicesDetail extends StatefulWidget {
  const TopServicesDetail({super.key});

  @override
  State<TopServicesDetail> createState() => _TopServicesDetailState();
}

class _TopServicesDetailState extends State<TopServicesDetail> {
  SideDrawerController sideDrawerController = Get.put(SideDrawerController());
  bool isApiLoading = false;
  final api = API();
  List<dynamic> servicesDetailData = [];
  final customText = CustomText();

  getTopServicesDetail() async {
    setState(() {
      isApiLoading = true;
    });

    final response =
        await api.myBusinessDetail(sideDrawerController.topServicesDetailId);

    setState(() {
      servicesDetailData = response['result'];
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
    print(
        'top services detail id: ${sideDrawerController.topServicesDetailId}');
    getTopServicesDetail();
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
          : servicesDetailData.isEmpty
              ? Container(
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
                                    '${servicesDetailData[0]['featured_image']}'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.calendar_month),
                            const SizedBox(width: 10),
                            customText.kText(
                                "${servicesDetailData[0]['created_at']}",
                                15,
                                FontWeight.w400,
                                Colors.black,
                                TextAlign.center),
                          ],
                        ),
                        const SizedBox(height: 10),
                        customText.kText(
                            "${servicesDetailData[0]['business_title']}",
                            15,
                            FontWeight.w700,
                            Colors.black,
                            TextAlign.center),
                        const SizedBox(height: 10),
                        customText.kText(
                            "${servicesDetailData[0]['business_description']}",
                            15,
                            FontWeight.w700,
                            Colors.black,
                            TextAlign.center),
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
                                "${servicesDetailData[0]['mobile']}",
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
                            customText.kText("Email:", 15, FontWeight.w700,
                                Colors.black, TextAlign.center),
                            const SizedBox(width: 10),
                            customText.kText(
                                "${servicesDetailData[0]['email']}",
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
                            customText.kText("Address:", 15, FontWeight.w700,
                                Colors.black, TextAlign.center),
                            const SizedBox(width: 10),
                            customText.kText(
                                "${servicesDetailData[0]['address']}",
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
                            customText.kText("City:", 15, FontWeight.w700,
                                Colors.black, TextAlign.center),
                            const SizedBox(width: 10),
                            customText.kText(
                                "${servicesDetailData[0]['city_name']}",
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
                            customText.kText("Country:", 15, FontWeight.w700,
                                Colors.black, TextAlign.center),
                            const SizedBox(width: 10),
                            customText.kText(
                                "${servicesDetailData[0]['country_name']}",
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
                                "${servicesDetailData[0]['zipcode']}",
                                15,
                                FontWeight.w400,
                                Colors.black,
                                TextAlign.center),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
