import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:kaarobaar/controllers/side_drawerController.dart';
import 'package:kaarobaar/services/api_services.dart';
import 'package:kaarobaar/utils/helper.dart';
import 'package:get/get.dart';
import '../../utils/text.dart';

class OurServicesDetail extends StatefulWidget {
  const OurServicesDetail({super.key});

  @override
  State<OurServicesDetail> createState() => _OurServicesDetailState();
}

class _OurServicesDetailState extends State<OurServicesDetail> {
  final customText = CustomText(), api = API(), helper = Helper();
  dynamic size;
  bool isApiLoading = false;
  List<dynamic> servicesDetailData = [];

  SideDrawerController sideDrawerController = Get.put(SideDrawerController());

  servicesDetail() async {
    print('services detail function call');
    setState(() {
      isApiLoading = true;
    });

    print('Function 1');

    final response = await api.servicesDetail(sideDrawerController.ourServiceId);
    print('Function 2');

    setState(() {
      servicesDetailData = response['result'];
    });
    print('Function 3');

    setState(() {
      isApiLoading = false;
    });

    print('Function 4');

    // if (response["status"] == 1) {
    //   servicesDetailData = response["result"];
    //   print('services data-------${servicesDetailData[0]['title']}');
    //   // log(" services list response :- $servicesListData");
    // }
    // setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    servicesDetail();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: isApiLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customText.kText(
                    "${servicesDetailData[0]["title"]}",
                    20,
                    FontWeight.w700,
                    Colors.black,
                    TextAlign.center,
                  ),
                  servicesDetailData[0]['image'] == ""
                      ? Container()
                      : Container(
                          height: size.height * 0.2,
                          width: size.width,
                          margin:
                              EdgeInsets.symmetric(vertical: size.width * 0.03),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius:
                                BorderRadius.circular(size.width * 0.05),
                            // image: DecorationImage(
                            //     image: NetworkImage(
                            //         servicesListData[index]
                            //             ["image"]),
                            //     fit: BoxFit.cover),
                          ),
                          child: Image.network(
                            servicesDetailData[0]['image'].toString(),
                            fit: BoxFit.fill,
                          ),
                        ),
                  HtmlWidget(
                    servicesDetailData[0]["short_content"],
                    textStyle: customText.kTextStyle(
                        16, FontWeight.w500, Colors.black),
                  ),
                ],
              ),
            ),
    );
  }
}
