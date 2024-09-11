import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kaarobaar/constants/color_constants.dart';
import 'package:kaarobaar/controllers/side_drawerController.dart';
import 'package:kaarobaar/utils/text.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  dynamic size;
  final customText = CustomText();
  
  SideDrawerController sideDrawerController = Get.put(SideDrawerController());

  List<String> tempList = [
    "All",
    "Jobs",
    "Events",
    "Shops",
    "Places",
    "All",
    "Jobs",
    "Events",
    "Shops",
    "Places"
  ];

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height * 0.78,
        width: size.width,
        // color: Colors.grey.shade400,
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.02, vertical: size.height * 0.02),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.05,
              width: size.width,
              // color: Colors.grey.shade800,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: tempList.length,
                itemBuilder: (context, index) {
                  return Container(
                    // margin: EdgeInsets.all(size.width * 0.015),
                    margin: EdgeInsets.fromLTRB(0, size.width * 0.015, size.width * 0.030, size.width * 0.015),
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                    decoration: BoxDecoration(
                      color: ColorConstants.kTabsGrey,
                      borderRadius: BorderRadius.circular(size.width * 0.02)
                    ),
                    child: Center(
                      child: customText.kText(tempList[index], 18, FontWeight.w700, Colors.black, TextAlign.center)
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: size.height * 0.02,),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(vertical: 5),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 1/1,
                ),
                itemCount: 19,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: ColorConstants.kIndicatorDots,
                      borderRadius: BorderRadius.circular(size.width * 0.02)
                    ),
                    child: Center(
                      child: Text((index + 1).toString()),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      )
    );
  }

}
