import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SideDrawerController extends GetxController {
  RxInt pageIndex = 0.obs;
  PageController pageController = PageController();

  String ourServiceId = "";
  String blogId = "";
  String offersId = "";
  String myBusinessId = "";
}
