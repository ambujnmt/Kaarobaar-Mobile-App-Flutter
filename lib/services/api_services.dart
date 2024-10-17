import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kaarobaar/controllers/login_controller.dart';
import 'package:kaarobaar/controllers/side_drawerController.dart';

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
  register(String name, String email, String password, String userType) async {
    var url = "$baseUrl/auth/userRegistration";

    Map<String, dynamic> body = {
      "token": loginController.accessToken,
      "username": name,
      "email": email,
      "password": password,
      "confirm_password": password,
      "user_type": userType
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
    var popularCommunities = '$baseUrl/app/category_list';

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

  // get feautred listing api integration

  featuredListingDashboard() async {
    var testimonials = '$baseUrl/app/featured_business_list';

    Map<String, dynamic> body = {
      "token": loginController.accessToken,
    };
    http.Response response = await http.post(
      Uri.parse(testimonials),
      body: body,
    );
    log(' featured listing dashboard response======${response.body}');
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

  // privacy policy
  privacyPolicy() async {
    var url = '$baseUrl/app/privacy_policy';

    Map<String, dynamic> body = {
      "token": loginController.accessToken,
    };

    http.Response response = await http.post(Uri.parse(url), body: body);
    debugPrint(" privacy policy api response :- ${response.body}");
    return jsonDecode(response.body);
  }

  // terms and conditions
  termsCondition() async {
    var url = '$baseUrl/app/terms_conditions';

    Map<String, dynamic> body = {
      "token": loginController.accessToken,
    };

    http.Response response = await http.post(Uri.parse(url), body: body);
    debugPrint(" terms and conditons api response :- ${response.body}");
    return jsonDecode(response.body);
  }

  // category list api for add business
  categoryList() async {
    var url = '$baseUrl/app/category_list';

    Map<String, dynamic> body = {
      "token": loginController.accessToken,
    };

    http.Response response = await http.post(Uri.parse(url), body: body);
    debugPrint(" category api response :- ${response.body}");
    return jsonDecode(response.body);
  }

  // state list

  stateList() async {
    var url = '$baseUrl/app/state_list';

    Map<String, dynamic> body = {
      "token": loginController.accessToken,
    };

    http.Response response = await http.post(Uri.parse(url), body: body);
    debugPrint(" state api response :- ${response.body}");
    return jsonDecode(response.body);
  }

  // city list

  cityList(String stateId) async {
    var url = '$baseUrl/app/city_list';

    Map<String, dynamic> body = {
      "token": loginController.accessToken,
      "state_id": stateId,
    };

    http.Response response = await http.post(Uri.parse(url), body: body);
    debugPrint(" city api response :- ${response.body}");
    return jsonDecode(response.body);
  }

  // add business
  addBusiness(
      String? businessName,
      String? categoryId,
      String? businessKeyword,
      String? email,
      String? contactNumber,
      String? postalCode,
      String? websiteURL,
      String? businessDescription,
      String? stateId,
      String? cityId,
      String? businessAddress,
      String? image) async {
    var url = '$baseUrl/user/add_business';

    var request = http.MultipartRequest(
      "POST",
      Uri.parse(url),
    );
    request.files
        .add(await http.MultipartFile.fromPath("featured_image", image!));

    request.fields["user_id"] = loginController.userId;
    request.fields["category_id"] = categoryId!;
    request.fields["business_title"] = businessName!;
    request.fields["keywords"] = businessKeyword!;
    request.fields["mobile"] = contactNumber!;
    request.fields["email"] = email!;
    request.fields["website"] = websiteURL!;
    request.fields["state_id"] = stateId!;
    request.fields["city_id"] = cityId!;
    request.fields["zipcode"] = postalCode!;
    request.fields["address"] = businessAddress!;
    request.fields["business_description"] = businessDescription!;
    request.fields["token"] = loginController.accessToken;

    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    final responseData = json.decode(response.body);

    log("add business response in api :- $responseData");

    return responseData;
  }

  businessListByUser() async {
    var url = '$baseUrl/user/business_list_by_user';

    Map<String, dynamic> body = {
      "token": loginController.accessToken,
      "user_id": loginController.userId,
    };
    print('user id----- ${loginController.userId}');
    http.Response response = await http.post(Uri.parse(url), body: body);
    debugPrint(" business list by user api response :- ${response.body}");
    return jsonDecode(response.body);
  }

  // Delete business
  deleteBusiness(String businessId) async {
    var url = '$baseUrl/user/delete_business';

    Map<String, dynamic> body = {
      "token": loginController.accessToken,
      "user_id": loginController.userId,
      "business_id": businessId,
    };
    print('user id----- ${loginController.userId}');
    print('business id----- ${businessId}');
    http.Response response = await http.post(Uri.parse(url), body: body);
    debugPrint(" delete business api response :- ${response.body}");
    return jsonDecode(response.body);
  }

  // get business details for update
  myBusinessDetail(String businessId) async {
    var url = '$baseUrl/app/business_details';

    Map<String, dynamic> body = {
      "token": loginController.accessToken,
      "business_id": businessId,
    };

    http.Response response = await http.post(Uri.parse(url), body: body);
    debugPrint("Get Business Details :- ${response.body}");
    return jsonDecode(response.body);
  }

  // update business details

  updateBusinessDetails(
      String? businessName,
      String? categoryId,
      String? businessKeyword,
      String? email,
      String? contactNumber,
      String? postalCode,
      String? websiteURL,
      String? businessDescription,
      String? stateId,
      String? cityId,
      String? businessAddress,
      String? image,
      String? businessId) async {
    var url = '$baseUrl/user/update_business';

    var request = http.MultipartRequest(
      "POST",
      Uri.parse(url),
    );
    request.files
        .add(await http.MultipartFile.fromPath("featured_image", image!));
    request.fields["token"] = loginController.accessToken;
    request.fields["user_id"] = loginController.userId;

    request.fields["category_id"] = categoryId!;
    request.fields["keywords"] = businessKeyword!;
    request.fields["business_title"] = businessName!;
    request.fields["mobile"] = contactNumber!;
    request.fields["email"] = email!;
    request.fields["website"] = websiteURL!;
    request.fields["state_id"] = stateId!;
    request.fields["city_id"] = cityId!;
    request.fields["zipcode"] = postalCode!;
    request.fields["address"] = businessAddress!;
    request.fields["business_description"] = businessDescription!;
    request.fields["business_id"] = businessId.toString();

    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    final responseData = json.decode(response.body);

    log("edit business response in api :- $responseData");
    print("business id in update--- $businessId"); // 29

    return responseData;
  }

  // contact admin api integration
  // get business details for update
  contactToAdmin(
    String name,
    String email,
    String contactNumber,
    String message,
    String address,
  ) async {
    var url = '$baseUrl/user/contact_to_admin';

    Map<String, dynamic> body = {
      "token": loginController.accessToken,
      "name": name,
      "mobile": contactNumber,
      "email": email,
      "message": message,
      "address": address,
    };

    http.Response response = await http.post(Uri.parse(url), body: body);
    debugPrint("contact admin api response :- ${response.body}");
    return jsonDecode(response.body);
  }

  // Do advertise with us
  advertiseWithUs(
    String name,
    String email,
    String contactNumber,
    String message,
    String address,
  ) async {
    var url = '$baseUrl/user/advertise_with_us';

    Map<String, dynamic> body = {
      "token": loginController.accessToken,
      "name": name,
      "mobile": contactNumber,
      "email": email,
      "message": message,
      "address": address,
    };

    http.Response response = await http.post(Uri.parse(url), body: body);
    debugPrint("advertise with us api response :- ${response.body}");
    return jsonDecode(response.body);
  }

  // public jobs listing api integration

  publicJobsListing() async {
    var url = '$baseUrl/job/all_job_list';

    Map<String, dynamic> body = {
      "token": loginController.accessToken,
    };

    http.Response response = await http.post(Uri.parse(url), body: body);
    debugPrint(" public job list api response:- ${response.body}");
    return jsonDecode(response.body);
  }

  // public job details
  publicJobDetail(String jobId) async {
    var url = '$baseUrl/job/job_details';

    Map<String, dynamic> body = {
      "token": loginController.accessToken,
      "job_id": jobId,
    };

    http.Response response = await http.post(Uri.parse(url), body: body);
    debugPrint("job detail api response:- ${response.body}");
    return jsonDecode(response.body);
  }

  // my jobs

  myJobsListing() async {
    var url = '$baseUrl/job/job_list_by_user';

    Map<String, dynamic> body = {
      "token": loginController.accessToken,
      "user_id": loginController.userId,
    };

    http.Response response = await http.post(Uri.parse(url), body: body);
    debugPrint("my job list api response:- ${response.body}");
    return jsonDecode(response.body);
  }

  // delete my jobs

  deleteMyJobs(String jobId) async {
    var url = '$baseUrl/job/delete_job';

    Map<String, dynamic> body = {
      "token": loginController.accessToken,
      "user_id": loginController.userId,
      "job_id": jobId,
    };
    print('user id----- ${loginController.userId}');
    print('job id----- ${jobId}');
    http.Response response = await http.post(Uri.parse(url), body: body);

    debugPrint(" delete job api response :- ${response.body}");
    return jsonDecode(response.body);
  }

  addJobs(
    String businessListId,
    String jobTitle,
    String jobType,
    String jobDescription,
    String jobLocation,
    String qualication,
    String email,
    String mobileNumber,
    String salary,
    String vacancy,
  ) async {
    var url = '$baseUrl/job/add_job';

    Map<String, dynamic> body = {
      "token": loginController.accessToken,
      "user_id": loginController.userId,
      "business_id": businessListId,
      "job_title": jobTitle,
      "job_description": jobDescription,
      "job_location": jobLocation,
      "job_type": jobType,
      "job_qualification": qualication,
      "job_email": email,
      "job_mobile": mobileNumber,
      "job_salary": salary,
      "vacancy": vacancy,
    };
    print('user id----- ${loginController.userId}');
    print('job id----- ${businessListId}');
    http.Response response = await http.post(Uri.parse(url), body: body);

    debugPrint(" add business api response :- ${response.body}");
    return jsonDecode(response.body);
  }

  updateJobs(
    String businessIdForUpdate,
    String jobIdForUpdate,
    String jobTitle,
    String jobType,
    String jobDescription,
    String jobLocation,
    String qualication,
    String email,
    String mobileNumber,
    String salary,
    String vacancy,
  ) async {
    var url = '$baseUrl/job/update_job';

    Map<String, dynamic> body = {
      "token": loginController.accessToken,
      "user_id": loginController.userId,
      "business_id": businessIdForUpdate,
      "job_id": jobIdForUpdate,
      "job_title": jobTitle,
      "job_description": jobDescription,
      "job_location": jobLocation,
      "job_type": jobType,
      "job_qualification": qualication,
      "job_email": email,
      "job_mobile": mobileNumber,
      "job_salary": salary,
      "vacancy": vacancy,
    };
    print('user id----- ${loginController.userId}');
    print('job id----- ${businessIdForUpdate}');
    http.Response response = await http.post(Uri.parse(url), body: body);

    debugPrint("update job api response :- ${response.body}");
    return jsonDecode(response.body);
  }

  homeTopServices() async {
    var url = '$baseUrl/app/top_services';

    Map<String, dynamic> body = {
      "token": loginController.accessToken,
    };
    http.Response response = await http.post(Uri.parse(url), body: body);
    debugPrint("home top services response :- ${response.body}");
    return jsonDecode(response.body);
  }

  // api integration of all business by category

  allCommunityByCategory(String id) async {
    var url = '$baseUrl/app/all_business_by_category';

    Map<String, dynamic> body = {
      "token": loginController.accessToken,
      "category_id": id,
    };
    http.Response response = await http.post(Uri.parse(url), body: body);
    debugPrint(" all community by category response :- ${response.body}");
    return jsonDecode(response.body);
  }

  // add events
  addEvent(
    String? businessId,
    String? eventName,
    String? eventDate,
    String? eventTime,
    String? eventLocation,
    String? image,
    String? eventDescription,
  ) async {
    var url = '$baseUrl/event/add_event';

    var request = http.MultipartRequest(
      "POST",
      Uri.parse(url),
    );
    request.files.add(await http.MultipartFile.fromPath("event_image", image!));

    request.fields["user_id"] = loginController.userId;
    request.fields["business_id"] = businessId!;
    request.fields["event_title"] = eventName!;
    request.fields["event_date"] = eventDate!;
    request.fields["event_time"] = eventTime!;
    request.fields["event_location"] = eventLocation!;
    request.fields["event_description"] = eventDescription!;
    request.fields["token"] = loginController.accessToken;

    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    final responseData = json.decode(response.body);

    log("add event api response :- $responseData");

    return responseData;
  }

  // event list api integration
  eventList() async {
    var eventUrl = '$baseUrl/event/all_event_list';

    Map<String, dynamic> body = {
      "token": loginController.accessToken,
      // "user_id": loginController.userId,
    };
    http.Response response = await http.post(
      Uri.parse(eventUrl),
      body: body,
    );
    log(' get event list api response======${response.body}');
    return jsonDecode(response.body);
  }

  // event list api integration
  myEventList() async {
    var eventUrl = '$baseUrl/event/event_list_by_user';

    Map<String, dynamic> body = {
      "token": loginController.accessToken,
      "user_id": loginController.userId,
    };
    http.Response response = await http.post(
      Uri.parse(eventUrl),
      body: body,
    );
    log('my event list api response======${response.body}');
    return jsonDecode(response.body);
  }

  // delete my events

  deleteMyEvent(String eventId) async {
    var url = '$baseUrl/event/delete_event';

    Map<String, dynamic> body = {
      "token": loginController.accessToken,
      "user_id": loginController.userId,
      "event_id": eventId,
    };
    print('user id----- ${loginController.userId}');
    print('job id----- ${eventId}');
    http.Response response = await http.post(Uri.parse(url), body: body);

    debugPrint(" delete event api response :- ${response.body}");
    return jsonDecode(response.body);
  }

  // get event details for update
  myEventDetail(String eventId) async {
    var url = '$baseUrl/event/event_details';

    Map<String, dynamic> body = {
      "token": loginController.accessToken,
      "event_id": eventId,
    };

    http.Response response = await http.post(Uri.parse(url), body: body);
    debugPrint("Get Event Details :- ${response.body}");
    return jsonDecode(response.body);
  }

  // update event details

  updateEventDetails(
    String? eventName,
    String? eventDate,
    String? eventTime,
    String? eventLocation,
    String? image,
    String? eventDescription,
    String? eventId,
    String? businessId,
  ) async {
    var url = '$baseUrl/event/update_event';

    var request = http.MultipartRequest(
      "POST",
      Uri.parse(url),
    );
    request.files.add(await http.MultipartFile.fromPath("event_image", image!));
    request.fields["token"] = loginController.accessToken;
    request.fields["user_id"] = loginController.userId;
    request.fields["event_title"] = eventName!;
    request.fields["event_date"] = eventDate!;
    request.fields["event_time"] = eventTime!;
    request.fields["event_locaton"] = eventLocation!;
    request.fields["event_descitpion"] = eventDescription!;
    request.fields["event_id"] = eventId.toString();
    request.fields["business_id"] = businessId.toString();

    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    final responseData = json.decode(response.body);

    log("edit business response in api :- $responseData");
    print("business id in update--- $businessId"); // 29

    return responseData;
  }

  //search for business
  searchForBusiness(String searchText) async {
    var url = '$baseUrl/app/search_business';

    Map<String, dynamic> body = {
      "token": loginController.accessToken,
      "search_text": searchText,
    };

    http.Response response = await http.post(Uri.parse(url), body: body);
    debugPrint("search result :- ${response.body}");
    return jsonDecode(response.body);
  }
}
