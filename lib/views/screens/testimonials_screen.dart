import 'package:flutter/material.dart';
import 'package:kaarobaar/constants/color_constants.dart';
import 'package:kaarobaar/utils/text.dart';

class Testimonials extends StatefulWidget {
  const Testimonials({super.key});

  @override
  State<Testimonials> createState() => _TestimonialsState();
}

class _TestimonialsState extends State<Testimonials> {

  dynamic size;
  final customText = CustomText();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      // body: Center(
      //   child: Text("Testimonials"),
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
                child: customText.kText("Testimonials", 20, FontWeight.w700, Colors.white, TextAlign.center),
              ),
            ),
            SizedBox(
              height: size.height * 0.67,
              width: size.width,
              // color: Colors.grey.shade400,
              child: GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                  childAspectRatio: 1/1.8,
                ),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(size.width * 0.01),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(size.width * 0.03)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: size.width * 0.35,
                          width: size.width * 0.35,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    ColorConstants.kTestimonialsDarkRed,
                                    ColorConstants.kTestimonialsLightRed,
                                  ]
                              )
                          ),
                          child: Container(
                            margin: EdgeInsets.all(size.width * 0.015),
                            padding: EdgeInsets.all(size.width * 0.01),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white, width: 3),
                                borderRadius: BorderRadius.circular(size.width * 0.5),
                                image: const DecorationImage(
                                    image: NetworkImage("https://s3-alpha-sig.figma.com/img/6d87/6fab/4374e1c546bc9a8ed00585d8f1de4efe?Expires=1722211200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=bTVVRzfzlLfnc1c4yWIJmpih7PBddA-AVNBxWYkeHRoQjaiHkXHRzFs7l2cTbj1FrZofzQuF3x51MHfrScbxtdvEI81-tOYIayc1GodmAIpKZJm3eSIsshj3NbV7oIyAvFmEG5r35BUAWLW-RwlQSBBVSzoL0vXwHit9N9GyNPyUrZ0A0sB3NRQRJXRo~6~KDfjMEii--yrpZuyFsZ2LSayFHQtW~WQrr3zQWatDSMAvGra2jY~vQa7GlAU2FWGOR1J4zA~j1qD4wh8GSd5sREXBCAayP-wVxO3kwpdP719wITEqzEzBLwgRNhhsURoRZRKP6ILO6HOy4tbsrFB~NA__"),
                                    fit: BoxFit.fill
                                )
                            ),
                            // child: Image.network("https://s3-alpha-sig.figma.com/img/6d87/6fab/4374e1c546bc9a8ed00585d8f1de4efe?Expires=1722211200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=bTVVRzfzlLfnc1c4yWIJmpih7PBddA-AVNBxWYkeHRoQjaiHkXHRzFs7l2cTbj1FrZofzQuF3x51MHfrScbxtdvEI81-tOYIayc1GodmAIpKZJm3eSIsshj3NbV7oIyAvFmEG5r35BUAWLW-RwlQSBBVSzoL0vXwHit9N9GyNPyUrZ0A0sB3NRQRJXRo~6~KDfjMEii--yrpZuyFsZ2LSayFHQtW~WQrr3zQWatDSMAvGra2jY~vQa7GlAU2FWGOR1J4zA~j1qD4wh8GSd5sREXBCAayP-wVxO3kwpdP719wITEqzEzBLwgRNhhsURoRZRKP6ILO6HOy4tbsrFB~NA__", fit: BoxFit.fill,),
                          ),
                        ),
                        customText.kText("Jerry", 16, FontWeight.w900, Colors.black, TextAlign.center),
                        customText.kText("Kaarobaar Founder", 16, FontWeight.w900, Colors.black, TextAlign.center),
                        const Text(
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black, fontFamily: "Raleway"),
                          overflow: TextOverflow.ellipsis, maxLines: 5,
                          textAlign: TextAlign.start,
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

}
