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
  Map<String, dynamic> offersDetailList = {};
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
    print(" offer id: ${sideDrawerController.offersId}");
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
                      "${offersDetailList["business_name"]}",
                      20,
                      FontWeight.w700,
                      Colors.black,
                      TextAlign.center,
                    ),
                    offersDetailList['offer_image'] == ""
                        ? Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: const DecorationImage(
                                image: AssetImage(
                                  'assets/images/no_image.jpeg',
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          )
                        : Container(
                            height: size.height * 0.2,
                            width: size.width,
                            margin: EdgeInsets.symmetric(
                                vertical: size.width * 0.03),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: NetworkImage(
                                    offersDetailList["offer_image"]),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                    HtmlWidget(
                      offersDetailList["offer_name"],
                      textStyle: customText.kTextStyle(
                          16, FontWeight.w500, Colors.black),
                    ),
                    HtmlWidget(
                      offersDetailList["offer_description"],
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
