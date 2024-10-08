import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:kaarobaar/controllers/side_drawerController.dart';
import 'package:kaarobaar/services/api_services.dart';
import 'package:kaarobaar/utils/helper.dart';
import 'package:kaarobaar/utils/text.dart';

class BlogDetailScreen extends StatefulWidget {
  const BlogDetailScreen({super.key});

  @override
  State<BlogDetailScreen> createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  final customText = CustomText(), api = API(), helper = Helper();
  bool isApiLoading = false;
  dynamic size;
  List<dynamic> blogDetailList = [];
  SideDrawerController sideDrawerController = Get.put(SideDrawerController());

  blogListDetail() async {
    setState(() {
      isApiLoading = true;
    });

    final response = await api.blogListDetail(sideDrawerController.blogId);

    setState(() {
      blogDetailList = response['result'];
    });

    setState(() {
      isApiLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    blogListDetail();
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
                      "${blogDetailList[0]["title"]}",
                      20,
                      FontWeight.w700,
                      Colors.black,
                      TextAlign.center,
                    ),
                    blogDetailList[0]['image'] == ""
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
                              borderRadius:
                                  BorderRadius.circular(size.width * 0.05),
                              // image: DecorationImage(
                              //     image: NetworkImage(
                              //         servicesListData[index]
                              //             ["image"]),
                              //     fit: BoxFit.cover),
                            ),
                            child: Image.network(
                              blogDetailList[0]['image'].toString(),
                              fit: BoxFit.fill,
                            ),
                          ),
                    HtmlWidget(
                      blogDetailList[0]["short_content"],
                      textStyle: customText.kTextStyle(
                          16, FontWeight.w500, Colors.black),
                    ),
                    HtmlWidget(
                      blogDetailList[0]["description"],
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
