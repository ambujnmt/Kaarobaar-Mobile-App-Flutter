import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:kaarobaar/constants/color_constants.dart';
import 'package:kaarobaar/services/api_services.dart';
import 'package:kaarobaar/utils/text.dart';

class TermsConditions extends StatefulWidget {
  const TermsConditions({super.key});

  @override
  State<TermsConditions> createState() => _TermsConditionsState();
}

class _TermsConditionsState extends State<TermsConditions> {
  dynamic size;
  final customText = CustomText();
  bool isApiLoading = false;
  final api = API();
  Map<String, dynamic> termsAndConditons = {};

  termsAndCondition() async {
    setState(() {
      isApiLoading = true;
    });

    final response = await api.termsCondition();

    setState(() {
      termsAndConditons = response['result'];
    });

    setState(() {
      isApiLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    termsAndCondition();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
        // body: Center(
        //   child: Text("Terms Conditions"),
        // ),
        body: isApiLoading
            ? Center(
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
                        child: customText.kText("Terms & Conditions", 20,
                            FontWeight.w700, Colors.white, TextAlign.center),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HtmlWidget(
                              termsAndConditons['description'],
                              textStyle: customText.kTextStyle(
                                  16, FontWeight.w500, Colors.black),
                            ),
                            // customText.kText(
                            //     "${termsAndConditons['description']}",
                            //     20,
                            //     FontWeight.w700,
                            //     ColorConstants.kQuestionRed,
                            //     TextAlign.start),
                            // Padding(
                            //   padding: EdgeInsets.symmetric(vertical: size.width * 0.02),
                            //   child: customText.kText(
                            //       "Lorem ipsum dolor sit amet consectetur adipisicing elit. "
                            //       "Atque cupiditate cum provident at! Dolorum fuga, deserunt est atque excepturi "
                            //       "voluptas architecto exercitationem cumque delectus iste facilis quaerat in "
                            //       "minima totam.",
                            //       16,
                            //       FontWeight.w500,
                            //       Colors.black,
                            //       TextAlign.start),
                            // ),
                            // customText.kText("Terms", 20, FontWeight.w700,
                            //     ColorConstants.kQuestionRed, TextAlign.start),
                            // Padding(
                            //   padding: EdgeInsets.symmetric(vertical: size.width * 0.02),
                            //   child: customText.kText(
                            //       "Lorem ipsum dolor sit amet consectetur adipisicing elit. "
                            //       "Atque cupiditate cum provident at! Dolorum fuga, deserunt est atque excepturi "
                            //       "voluptas architecto exercitationem cumque delectus iste facilis quaerat in minima "
                            //       "totam. Lorem ipsum dolor sit amet consectetur adipisicing elit. Atque cupiditate "
                            //       "cum provident at! Dolorum fuga, deserunt est atque excepturi voluptas architecto "
                            //       "exercitationem cumque delectus iste facilis quaerat in minima totam. Lorem ipsum "
                            //       "dolor sit amet consectetur adipisicing elit. Atque cupiditate cum provident at! "
                            //       "Dolorum fuga, deserunt est atque excepturi voluptas architecto exercitationem "
                            //       "cumque delectus iste facilis quaerat in minima totam. Lorem ipsum dolor sit amet "
                            //       "consectetur adipisicing elit. Atque cupiditate cum provident at! Dolorum fuga, "
                            //       "deserunt est atque excepturi voluptas architecto exercitationem cumque delectus "
                            //       "iste facilis quaerat in minima totam.",
                            //       16,
                            //       FontWeight.w500,
                            //       Colors.black,
                            //       TextAlign.start),
                            // ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ));
  }
}
