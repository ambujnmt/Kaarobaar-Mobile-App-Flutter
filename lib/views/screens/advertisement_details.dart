import 'package:flutter/material.dart';
import 'package:kaarobaar/constants/color_constants.dart';
import 'package:kaarobaar/utils/helper.dart';
import 'package:kaarobaar/utils/text.dart';

class AdvertisementDetails extends StatefulWidget {
  const AdvertisementDetails({super.key});

  @override
  State<AdvertisementDetails> createState() => _AdvertisementDetailsState();
}

class _AdvertisementDetailsState extends State<AdvertisementDetails> {

  dynamic size;
  final customText = CustomText(), helper = Helper();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: Container(
          height: size.height * 0.77,
          width: size.width,
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
          child: Column(
            children: [
              Container(
                height: size.height * 0.38,
                width: size.width,
                margin: EdgeInsets.symmetric(vertical: size.width * 0.01),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: size.height * 0.2,
                      width: size.width,
                      margin: EdgeInsets.only(bottom: size.width * 0.02),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(size.width * 0.05)
                      ),
                      child: Image.asset("assets/images/cameraImg.png", fit: BoxFit.fill,),
                    ),
                    Container(
                      height: size.height * 0.065,
                      width: size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: customText.kText("Flutter Developer (Corporate Office)", 18, FontWeight.w700, Colors.black, TextAlign.center),
                    ),

                    SizedBox(
                      height: size.height * 0.1,
                      width: size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: size.width * 0.08,
                            child: Image.asset("assets/images/map.png"),
                          ),
                          SizedBox(
                            width: size.width * 0.85,
                            child: customText.kText("Office 24 Brentham Old Power Station, Western Avenue London - W5 1HS", 18, FontWeight.w500, ColorConstants.kIconsGrey, TextAlign.start),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.38,
                width: size.width,
                child: Column(
                  children: [
                    SizedBox(
                      height: size.width * 0.13,
                      width: size.width,
                      child: TabBar(
                        labelPadding: EdgeInsets.zero,
                        indicatorColor: ColorConstants.kCircleRed,
                        dividerColor: ColorConstants.kGradientDarkGreen,
                        indicatorPadding: EdgeInsets.zero,
                        tabs: [
                          Tab(child: customText.kText("Job Detail", 11, FontWeight.w700, Colors.black, TextAlign.start)),
                          Tab(child: customText.kText("About Company", 11, FontWeight.w700, Colors.black, TextAlign.start),),
                          Tab(child: customText.kText("Review", 11, FontWeight.w700, Colors.black, TextAlign.start),),
                          Tab(child: customText.kText("Benefits", 11, FontWeight.w700, Colors.black, TextAlign.start),),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          Container(
                            height: size.width * 0.13,
                            width: size.width,
                            padding: const EdgeInsets.all(5),
                            child: SingleChildScrollView(
                              child: customText.kText("Lorem ipsum dolor sit amet consectetur adipisicing elit. Atque cupiditate cum provident at! Dolorum fuga, deserunt est atque excepturi voluptas architecto exercitationem cumque delectus iste facilis quaerat in minima totam. Lorem ipsum dolor sit amet consectetur adipisicing elit. Nulla eligendi laudantium obcaecati numquam quisquam vitae ratione nihil. Quasi laborum tempora laboriosam libero aliquam distinctio, sapiente nemo, ex expedita nam error! Lorem ipsum dolor sit amet, consectetur adipisicing elit. lkfkjlsdfjlksdjflsjdldjslfjlsdjflsjdlfjsdlfjsjdlfjlsdkjflksjklfjskljdfljfsdlkjfdljsdfljsdflkjdsfljdsljflksdjflsjdflsfdjlsdfljsldfjlsdfjlsdjfkljsdklfjskldhvnkvnksojdf dsljflksd sdlfjsdf sdfjsldfjs ljdsf jsldjfs ldsf sdfc sdlfjlsdjf flsdfsdf sldjf sdj sdfj",14, FontWeight.w500, Colors.black, TextAlign.start),
                            ),
                          ),
                          Container(
                            height: size.width * 0.13,
                            width: size.width,
                            padding: const EdgeInsets.all(5),
                            child: SingleChildScrollView(
                              child: customText.kText("Lorem ipsum dolor sit amet consectetur adipisicing elit. Atque cupiditate cum provident at! Dolorum fuga, deserunt est atque excepturi voluptas architecto exercitationem cumque delectus iste facilis quaerat in minima totam. Lorem ipsum dolor sit amet consectetur adipisicing elit. Nulla eligendi laudantium obcaecati numquam quisquam vitae ratione nihil. Quasi laborum tempora laboriosam libero aliquam distinctio, sapiente nemo, ex expedita nam error! Lorem ipsum dolor sit amet, consectetur adipisicing elit. lkfkjlsdfjlksdjflsjdldjslfjlsdjflsjdlfjsdlfjsjdlfjlsdkjflksjklfjskljdfljfsdlkjfdljsdfljsdflkjdsfljdsljflksdjflsjdflsfdjlsdfljsldfjlsdfjlsdjfkljsdklfjskldhvnkvnksojdf dsljflksd sdlfjsdf sdfjsldfjs ljdsf jsldjfs ldsf sdfc sdlfjlsdjf flsdfsdf sldjf sdj sdfj",14, FontWeight.w500, Colors.black, TextAlign.start),
                            ),
                          ),
                          Container(
                            height: size.width * 0.13,
                            width: size.width,
                            padding: const EdgeInsets.all(5),
                            child: SingleChildScrollView(
                              child: customText.kText("Lorem ipsum dolor sit amet consectetur adipisicing elit. Atque cupiditate cum provident at! Dolorum fuga, deserunt est atque excepturi voluptas architecto exercitationem cumque delectus iste facilis quaerat in minima totam. Lorem ipsum dolor sit amet consectetur adipisicing elit. Nulla eligendi laudantium obcaecati numquam quisquam vitae ratione nihil. Quasi laborum tempora laboriosam libero aliquam distinctio, sapiente nemo, ex expedita nam error! Lorem ipsum dolor sit amet, consectetur adipisicing elit. lkfkjlsdfjlksdjflsjdldjslfjlsdjflsjdlfjsdlfjsjdlfjlsdkjflksjklfjskljdfljfsdlkjfdljsdfljsdflkjdsfljdsljflksdjflsjdflsfdjlsdfljsldfjlsdfjlsdjfkljsdklfjskldhvnkvnksojdf dsljflksd sdlfjsdf sdfjsldfjs ljdsf jsldjfs ldsf sdfc sdlfjlsdjf flsdfsdf sldjf sdj sdfj",14, FontWeight.w500, Colors.black, TextAlign.start),
                            ),
                          ),
                          Container(
                            height: size.width * 0.13,
                            width: size.width,
                            padding: const EdgeInsets.all(5),
                            child: SingleChildScrollView(
                              child: customText.kText("Lorem ipsum dolor sit amet consectetur adipisicing elit. Atque cupiditate cum provident at! Dolorum fuga, deserunt est atque excepturi voluptas architecto exercitationem cumque delectus iste facilis quaerat in minima totam. Lorem ipsum dolor sit amet consectetur adipisicing elit. Nulla eligendi laudantium obcaecati numquam quisquam vitae ratione nihil. Quasi laborum tempora laboriosam libero aliquam distinctio, sapiente nemo, ex expedita nam error! Lorem ipsum dolor sit amet, consectetur adipisicing elit. lkfkjlsdfjlksdjflsjdldjslfjlsdjflsjdlfjsdlfjsjdlfjlsdkjflksjklfjskljdfljfsdlkjfdljsdfljsdflkjdsfljdsljflksdjflsjdflsfdjlsdfljsldfjlsdfjlsdjfkljsdklfjskldhvnkvnksojdf dsljflksd sdlfjsdf sdfjsldfjs ljdsf jsldjfs ldsf sdfc sdlfjlsdjf flsdfsdf sldjf sdj sdfj",14, FontWeight.w500, Colors.black, TextAlign.start),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}
