import 'package:flutter/material.dart';
import 'package:kaarobaar/constants/color_constants.dart';
import 'package:kaarobaar/services/api_services.dart';
import 'package:kaarobaar/utils/text.dart';

class FAQ extends StatefulWidget {
  const FAQ({super.key});

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  dynamic size;
  final customText = CustomText();
  int? openQuestion;
  bool isApiLoading = false;
  final api = API();
  List<dynamic> faqListData = [];

  faqList() async {
    setState(() {
      isApiLoading = true;
    });

    final response = await api.faqList();

    setState(() {
      faqListData = response['result'];
    });

    setState(() {
      isApiLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    faqList();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
        body: isApiLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                height: size.height * 0.77,
                width: size.width,
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                // color: Colors.grey.shade300,
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
                        child: customText.kText("Karobaar FAQ &Help", 20,
                            FontWeight.w700, Colors.white, TextAlign.center),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: faqListData.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            child: Container(
                              // height: 40,
                              width: size.width,
                              padding: EdgeInsets.all(size.width * 0.01),
                              margin:
                                  EdgeInsets.only(bottom: size.width * 0.05),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: ColorConstants.kGradientLightGreen,
                                      width: 1.5),
                                  borderRadius:
                                      BorderRadius.circular(size.width * 0.03),
                                  boxShadow: const [
                                    BoxShadow(
                                        blurRadius: 4,
                                        offset: Offset(0, 4),
                                        color: Colors.grey)
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.83,
                                        // color: Colors.yellow,
                                        child: Text(
                                          "${faqListData[index]['question']}",
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color:
                                                  ColorConstants.kQuestionRed,
                                              fontFamily: "Raleway"),
                                        ),
                                      ),
                                      Icon(
                                        openQuestion == index
                                            ? Icons.keyboard_arrow_up_rounded
                                            : Icons.keyboard_arrow_down_rounded,
                                        size: 30,
                                      )
                                    ],
                                  ),
                                  Visibility(
                                    visible:
                                        openQuestion == index ? true : false,
                                    child: Text(
                                      "${faqListData[index]['answer']}",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                          fontFamily: "Raleway"),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            onTap: () {
                              if (openQuestion == index) {
                                openQuestion = null;
                              } else {
                                openQuestion = index;
                              }
                              setState(() {});
                            },
                          );
                        },
                      ),
                    )
                  ],
                ),
              ));
  }
}
