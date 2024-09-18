import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kaarobaar/controllers/login_controller.dart';

class API {
  String baseUrl = "https://mean-experts.com/kaarobaar/api";
  LoginController loginController = Get.put(LoginController());

  // get access token api
  getAccessToken() async {
    var url = '$baseUrl/auth/system_token';

    http.Response response = await http.get(Uri.parse(url));

    log("api services getAccessToken response :- ${response.body}");
    return jsonDecode(response.body);
  }

  // user registration api
  register(String name, String email, String password) async {
    var url = "$baseUrl/auth/userRegistration";

    Map<String, dynamic> body = {
      "token": loginController.accessToken,
      "username": name,
      "email": email,
      "password": password,
      "confirm_password": password,
    };

    http.Response response = await http.post(Uri.parse(url), body: body);

    log("api services registration response :- ${response.body}");
    return jsonDecode(response.body);
  }

  // user log in api function
  login(String email, String password) async {
    //   https://mean-experts.com/kaarobaar/api/auth/userLogin
    var url = "$baseUrl/auth/userLogin";

    Map<String, dynamic> body = {
      "email": email,
      "password": password,
      "token": loginController.accessToken
    };

    http.Response response = await http.post(Uri.parse(url), body: body);

    log("api services login response :- ${response.body}");
    return jsonDecode(response.body);
  }

  // verify otp api integration
  verifyOTP(String? email, String? otp) async {
    var verifyotpUrl = '$baseUrl/auth/verifyOTP';
    Map<String, dynamic> body = {'otp': otp, 'email': email};
    http.Response response =
        await http.post(Uri.parse(verifyotpUrl), body: body);
    log('verify otp response======${response.body}');
    return jsonDecode(response.body);
  }

  // resent otp api integration
  resendOTP(String? email) async {
    var verifyotpUrl = '$baseUrl/auth/resendOTP';
    Map<String, dynamic> body = {'email': email};
    http.Response response =
        await http.post(Uri.parse(verifyotpUrl), body: body);
    log('resend otp response======${response.body}');
    return jsonDecode(response.body);
  }

  // forgot password api integration
  forgotPassword(String? email) async {
    var verifyotpUrl = '$baseUrl/auth/resendOTP';
    Map<String, dynamic> body = {'email': email};
    http.Response response =
        await http.post(Uri.parse(verifyotpUrl), body: body);
    log(' forget password response response======${response.body}');
    return jsonDecode(response.body);
  }

  // create new password api integration
  createPassword(
      String email, String newPassword, String confirmNewPassword) async {
    var verifyotpUrl = '$baseUrl/auth/createNewPassword';
    Map<String, dynamic> body = {
      'email': email,
      'new_password': newPassword,
      'confirm_password': confirmNewPassword,
    };
    http.Response response =
        await http.post(Uri.parse(verifyotpUrl), body: body);
    log('verify otp response======${response.body}');
    return jsonDecode(response.body);
  }

  getProfileData() async {
    var getProfileData = '$baseUrl/user/get_profile';

    Map<String, dynamic> body = {
      "token": loginController.accessToken,
      "user_id": loginController.userId
    };
    http.Response response =
        await http.post(Uri.parse(getProfileData), body: body);
    log('get profile Data  response======${response.body}');
    return jsonDecode(response.body);
  }

  // change password api integration
  changePassword(
      String oldPassword, String newPassword, String confirmNewPassword) async {
    var changePassword = '$baseUrl/user/changePassword';

    Map<String, dynamic> body = {
      "token": loginController.accessToken,
      "user_id": loginController.userId,
      "old_password": oldPassword,
      "new_password": newPassword,
      "confirm_new_password": confirmNewPassword,
    };
    http.Response response =
        await http.post(Uri.parse(changePassword), body: body);
    log('change password response======${response.body}');
    return jsonDecode(response.body);
  }

  //  Slider images Dashboard api integration
  sliderImagesDashboard() async {
    var sliderList = '$baseUrl/app/sliderList';

    Map<String, dynamic> body = {
      "token": loginController.accessToken,
    };
    http.Response response = await http.post(
      Uri.parse(sliderList),
      body: body,
    );
    log('slider images dashboard response======${response.body}');
    return jsonDecode(response.body);
  }

  // popular communities api integration
  popularCommunities() async {
    var popularCommunities = '$baseUrl/app/communities_category';

    Map<String, dynamic> body = {
      "token": loginController.accessToken,
    };
    http.Response response = await http.post(
      Uri.parse(popularCommunities),
      body: body,
    );
    log(' popular communities dashboard response======${response.body}');
    return jsonDecode(response.body);
  }

  // testimonials dashboard api integration
  testimonialsDashboard() async {
    var testimonials = '$baseUrl/app/testimonials';

    Map<String, dynamic> body = {
      "token": loginController.accessToken,
    };
    http.Response response = await http.post(
      Uri.parse(testimonials),
      body: body,
    );
    log(' popular communities dashboard response======${response.body}');
    return jsonDecode(response.body);
  }

  // about us
  aboutUs() async {
    var aboutUs = '$baseUrl/app/about_us';

    Map<String, dynamic> body = {
      "token": loginController.accessToken,
    };

    http.Response response = await http.post(Uri.parse(aboutUs), body: body);
    log("about us response :- ${response.body}");
    return jsonDecode(response.body);
  }

  // category list api integration

  // services list api integration
  servicesList() async {
    var servicesList = '$baseUrl/app/services_list';

    Map<String, dynamic> body = {
      "token": loginController.accessToken,
    };

    http.Response response =
        await http.post(Uri.parse(servicesList), body: body);
    log(" services list response :- ${response.body}");
    return jsonDecode(response.body);
  }

  // services detail api integration
  // servicesDetail() async {
  //   var servicesDetailURL = '$baseUrl/app/services_details';
  //
  //   Map<String, dynamic> body = {
  //     "token": loginController.accessToken,
  //     "service_id ": "1",
  //   };
  //
  //   http.Response response = await http.post(Uri.parse(servicesDetailURL), body: body);
  //
  //   log("api service service detail response :- ${response.body}");
  //
  //   return jsonDecode(response.body);
  // }

  servicesDetail(String serviceId) async {
    // https://mean-experts.com/kaarobaar/api
    var url = '$baseUrl/app/services_details';

    Map<String, dynamic> body = {
      "token": loginController.accessToken,
      "service_id": serviceId
    };

    http.Response response = await http.post(Uri.parse(url), body: body);
    debugPrint("api serviceDetails response :- ${response.body}");
    return jsonDecode(response.body);
  }

  // blog list api integration
  blogList() async {
    var url = '$baseUrl/app/blogs_list';

    Map<String, dynamic> body = {
      "token": loginController.accessToken,
    };

    http.Response response = await http.post(Uri.parse(url), body: body);
    debugPrint("blog list api response :- ${response.body}");
    return jsonDecode(response.body);
  }

  // blog details api integration
  blogListDetail(String blogId) async {
    var url = '$baseUrl/app/blog_details';

    Map<String, dynamic> body = {
      "token": loginController.accessToken,
      "blog_id": blogId,
    };

    http.Response response = await http.post(Uri.parse(url), body: body);
    debugPrint("blog detail api response :- ${response.body}");
    return jsonDecode(response.body);
  }

  // FAQ
  faqList() async {
    var url = '$baseUrl/app/faq_list';

    Map<String, dynamic> body = {
      "token": loginController.accessToken,
    };

    http.Response response = await http.post(Uri.parse(url), body: body);
    debugPrint("faq list api response :- ${response.body}");
    return jsonDecode(response.body);
  }

  // offers list
  offersList() async {
    var url = '$baseUrl/app/offers_list';

    Map<String, dynamic> body = {
      "token": loginController.accessToken,
    };

    http.Response response = await http.post(Uri.parse(url), body: body);
    debugPrint("offers list api response :- ${response.body}");
    return jsonDecode(response.body);
  }

  // offers detail
  offersDetail(String offerId) async {
    var url = '$baseUrl/app/offer_details';

    Map<String, dynamic> body = {
      "token": loginController.accessToken,
      "offer_id": offerId,
    };

    http.Response response = await http.post(Uri.parse(url), body: body);
    debugPrint("offers detail api response :- ${response.body}");
    return jsonDecode(response.body);
  }
}
