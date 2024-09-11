import 'package:flutter/material.dart';
import 'package:kaarobaar/constants/color_constants.dart';
import 'package:kaarobaar/utils/text.dart';

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {

  dynamic size;
  final customText = CustomText();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      // body: Center(
      //   child: Text("Events"),
      // ),
      body: Container(
        height: size.height * 0.77,
        width: size.width,
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
        child: Column(
          children: [
            Container(
              height: size.height * 0.05,
              width: size.width * 0.8,
              margin: EdgeInsets.symmetric(vertical: size.width * 0.05),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(size.width * 0.05),
                  gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        ColorConstants.kGradientDarkGreen,
                        ColorConstants.kGradientLightGreen
                      ]
                  )
              ),
              child: Center(
                child: customText.kText("Events Details", 20, FontWeight.w700, Colors.white, TextAlign.center),
              ),
            ),
            SizedBox(
              height: size.height * 0.67,
              width: size.width,
              // color: Colors.yellow,
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 10),
                itemCount: 7,
                itemBuilder: (context, index) {
                  return Container(
                    height: size.height * 0.55,
                    width: size.width,
                    margin: const EdgeInsets.only(bottom: 10),
                    // color: Colors.grey.shade300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: size.height * 0.2,
                          width: size.width,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(size.width * 0.05),
                          ),
                          child: Image.asset("assets/images/cameraImg.png", fit: BoxFit.fill,),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customText.kText("${index + 1} Events", 30, FontWeight.w700, Colors.black, TextAlign.start),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: size.width * 0.08,
                                    child: Image.asset("assets/images/calender.png"),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.35,
                                    child: customText.kText("Time : 3:51 PM", 16, FontWeight.w500, Colors.grey.shade800, TextAlign.start)
                                  ),
                                  SizedBox(
                                    width: size.width * 0.4,
                                    child: customText.kText("Date : 17/08/2024", 16, FontWeight.w500, Colors.grey.shade800, TextAlign.start)
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: size.width * 0.08,
                                    child: Image.asset("assets/images/map.png"),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.8,
                                    child: customText.kText("Office 24 Brentham Old Power Station, Western Avenue LONDON - W5 1HS", 16, FontWeight.w500, Colors.grey.shade800, TextAlign.start)
                                  ),

                                ],
                              ),
                            ],
                          ),
                        ),
                        const Text(
                          "Lorem ipsum dolor sit amet consectetur adipisicing elit. "
                              "Atque cupiditate cum provident at! Dolorum fuga, deserunt "
                              "est atque excepturi voluptas architecto exercitationem cumque "
                              "delectus iste facilis quaerat in minima totam. Lorem ipsum dolor "
                              "sit amet consectetur adipisicing elit. Nulla eligendi laudantium "
                              "obcaecati numquam quisquam vitae ratione nihil. Quasi laborum tempora "
                              "laboriosam libero aliquam distinctio, sapiente nemo, ex expedita nam "
                              "error! Lorem ipsum dolor sit amet, consectetur adipisicing elit.",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black,
                              fontFamily: "Raleway"), textAlign: TextAlign.start, overflow: TextOverflow.ellipsis,
                          maxLines: 7,
                        ),

                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      )
    );
  }

}
