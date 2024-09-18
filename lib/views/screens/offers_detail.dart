import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:kaarobaar/controllers/side_drawerController.dart';
import 'package:kaarobaar/services/api_services.dart';
import 'package:kaarobaar/utils/helper.dart';
import 'package:kaarobaar/utils/text.dart';

class OffersDetail extends StatefulWidget {
  const OffersDetail({super.key});

  @override
  State<OffersDetail> createState() => _OffersDetailState();
}

class _OffersDetailState extends State<OffersDetail> {
  final customText = CustomText(), api = API(), helper = Helper();
  bool isApiLoading = false;
  dynamic size;
  List<dynamic> offersDetailList = [];
  SideDrawerController sideDrawerController = Get.put(SideDrawerController());

  offersListDetail() async {
    setState(() {
      isApiLoading = true;
    });

    final response = await api.offersDetail(sideDrawerController.offersId);

    setState(() {
      offersDetailList = response['result'];
    });

    setState(() {
      isApiLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    offersListDetail();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: isApiLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customText.kText(
                      "${offersDetailList[0]["title"]}",
                      20,
                      FontWeight.w700,
                      Colors.black,
                      TextAlign.center,
                    ),
                    offersDetailList[0]['image'] == ""
                        ? Container()
                        : Container(
                            height: size.height * 0.2,
                            width: size.width,
                            margin: EdgeInsets.symmetric(
                                vertical: size.width * 0.03),
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
                              offersDetailList[0]['image'].toString(),
                              fit: BoxFit.fill,
                            ),
                          ),
                    HtmlWidget(
                      offersDetailList[0]["short_content"],
                      textStyle: customText.kTextStyle(
                          16, FontWeight.w500, Colors.black),
                    ),
                    HtmlWidget(
                      offersDetailList[0]["description"],
                      textStyle: customText.kTextStyle(
                          16, FontWeight.w500, Colors.black),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
