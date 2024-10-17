import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SideDrawerController extends GetxController {
  RxInt pageIndex = 0.obs;
  PageController pageController = PageController();

  String ourServiceId = "";
  String blogId = "";
  String offersId = "";
  String myBusinessId = "";
  String jobDetailId = "";
  String businessListingId = "";
  String myJobDetailId = "";
  String businessId = "";
  String communityByCategoryId = "";
  String detailTwoId = "";
  String topServicesDetailId = "";
  String featuredDetailId = "";
  String myEventsId = "";
  String eventBusinessId = "";
}
