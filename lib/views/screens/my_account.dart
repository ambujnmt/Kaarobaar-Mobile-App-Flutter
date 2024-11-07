import 'dart:io';

import 'package:dio/dio.dart';
import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kaarobaar/constants/color_constants.dart';
import 'package:kaarobaar/controllers/login_controller.dart';
import 'package:kaarobaar/controllers/side_drawerController.dart';
import 'package:kaarobaar/services/api_services.dart';
import 'package:kaarobaar/utils/helper.dart';
import 'package:kaarobaar/utils/text.dart';
import 'package:path_provider/path_provider.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  dynamic size;
  final customText = CustomText(), api = API();

  SideDrawerController sideDrawerController = Get.put(SideDrawerController());
  LoginController loginController = Get.put(LoginController());
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userMobileController = TextEditingController();
  TextEditingController stateDropdownController = TextEditingController();
  TextEditingController cityDropdownController = TextEditingController();
  TextEditingController addressThreeController = TextEditingController();
  TextEditingController addressTwoController = TextEditingController();
  TextEditingController userAddressController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  SuggestionsBoxController stateSuggestionBoxController =
      SuggestionsBoxController();
  SuggestionsBoxController citySuggestionBoxController =
      SuggestionsBoxController();

  String? password = "";
  String profileURL = "";
  String? userName = "";
  String? image1;
  final ImagePicker _picker = ImagePicker();

  String? selectedStateId, selectedCityId, selectedCity, selectedState;

  bool isApiCalling = false;
  bool cityCalling = false;
  bool imageSelected = false;
  bool isImageDownloading = false;
  bool isProfileCalling = false;
  final helper = Helper();

  List<dynamic> getStateItems = [];
  List<dynamic> getCityItems = [];

  // state list api integration
  getStateList() async {
    setState(() {
      isApiCalling = true;
    });
    final response = await api.stateList();
    setState(() {
      getStateItems = response['result'];
    });
    setState(() {
      isApiCalling = false;
    });

    print('get state response list ----$getStateItems');
  }

  // city list api integration
  getCityList(String stateId) async {
    print("selected state Id :- $selectedStateId, $stateId}");

    setState(() {
      // isApiCalling = true;
      cityCalling = true;
    });
    final response = await api.cityList(selectedStateId.toString()); //3805
    setState(() {
      getCityItems = response['result'];
    });
    setState(() {
      // isApiCalling = false;
      cityCalling = false;
    });

    print('get city response list ----$getCityItems');
  }

  List<String> getStateSuggestions(String query) {
    print("get state suggestions");

    List<String> stateMatches = <String>[];
    final List<String> stateList =
        getStateItems.map((element) => element['name'].toString()).toList();
    stateMatches.addAll(stateList);

    for (int i = 0; i < getStateItems.length; i++) {
      if (getStateItems[i]['name'] == selectedState) {
        setState(() {
          selectedStateId = getStateItems[i]['id'].toString();
        });
      }
    }

    print("selectedState Id :-$selectedStateId");
    stateMatches
        .retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return stateMatches;
  }

  List<String> getCitySuggestions(String query) {
    List<String> cityMatches = <String>[];
    final List<String> cityList =
        getCityItems.map((element) => element['name'].toString()).toList();
    cityMatches.addAll(cityList);

    for (int i = 0; i < getCityItems.length; i++) {
      if (getCityItems[i]['name'] == selectedCity) {
        setState(() {
          selectedCityId = getCityItems[i]['id'].toString();
        });
      }
    }

    cityMatches
        .retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return cityMatches;
  }

  Future getImageFromGallery() async {
    XFile? image;

    image = await _picker.pickImage(source: ImageSource.gallery);
    if (image?.path != null) {
      image1 = image!.path;
      imageSelected = true;
    }

    print("images list :- $image1");

    setState(() {});
  }

  Future getImageFromCamera() async {
    XFile? image;

    image = await _picker.pickImage(source: ImageSource.camera);
    if (image?.path != null) {
      image1 = image!.path;
      imageSelected = true;
    }

    print("images list :- $image1");

    setState(() {});
  }

  getProfileData() async {
    setState(() {
      isApiCalling = true;
    });
    final response = await api.getProfileData();
    setState(() {
      firstNameController.text = response['result']['first_name'] ?? "";
      lastNameController.text = response['result']['last_name'] ?? "";
      userEmailController.text = response['result']['email'] ?? "";
      userMobileController.text = response['result']['mobile'] ?? "";
      profileURL = response['result']['profile_img'] ?? "";
      stateDropdownController.text = response['result']['state_name'] ?? "";
      cityDropdownController.text = response['result']['city_name'] ?? "";
      postalCodeController.text = response['result']['zipcode'] ?? "";
      areaController.text = response['result']['area'] ?? "";
      userAddressController.text = response['result']['address'] ?? "";
      addressTwoController.text = response['result']['address_2'] ?? "";
      addressThreeController.text = response['result']['address_3'] ?? "";
      userName = response['result']['username'] ?? "";

      image1 = profileURL;
    });
    setState(() {
      isApiCalling = false;
    });

    print('response my account------- ${response}');
    downloadAllImage();
  }

  downloadAllImage() async {
    late var appDocDir;

    if (Platform.isAndroid) {
      appDocDir = await getExternalStorageDirectory();
    } else if (Platform.isIOS) {
      appDocDir = await getApplicationDocumentsDirectory();
    }

    setState(() {
      isImageDownloading = true;
    });

    List temp = profileURL.toString().split(".");
    String fileExtension = temp.last;

    String fileUrl = profileURL;
    String savePath = "${appDocDir!.path}/image.$fileExtension";

    print("save path :- $savePath");

    await Dio().download(fileUrl, savePath, onReceiveProgress: (count, total) {
      print("${(count / total * 100).toStringAsFixed(0)}%");
    });

    // downloadedImages.add("${appDocDir!.path}/$fileName");

    image1 = "${appDocDir!.path}/image.$fileExtension";
    print("image path 1 :- $image1");

    setState(() {
      isImageDownloading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("loginController.userId test :- ${loginController.userId}");
    getStateList();
    getProfileData();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: isApiCalling
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                margin: const EdgeInsets.only(bottom: 25),
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.width * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: size.width * 0.62,
                            child: customText.kText("My Account", 30,
                                FontWeight.bold, Colors.black, TextAlign.start),
                          ),
                          image1 == null
                              ? GestureDetector(
                                  onTap: () {
                                    showImageSelection();
                                  },
                                  child: Container(
                                    // height: size.width * 0.25,
                                    // padding: EdgeInsets.all(size.width * 0.01),
                                    padding: const EdgeInsets.all(40),
                                    decoration: BoxDecoration(
                                      color: ColorConstants.kCircleRed,
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.contain,
                                        image: image1 == null
                                            ? const AssetImage(
                                                'assets/images/person.jpg')
                                            : FileImage(File(image1!))
                                                as ImageProvider,
                                      ),
                                    ),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    print("Hello Profile");
                                    showImageSelection();
                                  },
                                  child: Stack(
                                    children: [
                                      CircleAvatar(
                                        radius: 50,
                                        backgroundColor: Colors.grey.shade200,
                                        child: CircleAvatar(
                                          radius: 70,
                                          backgroundImage:
                                              image1!.contains("uploads/users")
                                                  ? NetworkImage(profileURL)
                                                      as ImageProvider
                                                  : FileImage(File(image1!)),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 1,
                                        right: 10,
                                        child: Container(
                                          child: Padding(
                                            padding: EdgeInsets.all(2.0),
                                            child: Icon(Icons.edit,
                                                color: Colors.black),
                                          ),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 3,
                                                color: Colors.white,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(
                                                  50,
                                                ),
                                              ),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  offset: Offset(2, 4),
                                                  color:
                                                      Colors.black.withOpacity(
                                                    0.3,
                                                  ),
                                                  blurRadius: 3,
                                                ),
                                              ]),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                        ],
                      ),
                      SizedBox(
                        height: size.width * 0.05,
                      ),
                      TextField(
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.words,
                        controller: firstNameController,
                        decoration: InputDecoration(
                          hintText: "First Name",
                          hintStyle: customText.kTextStyle(
                              16, FontWeight.w400, ColorConstants.kIconsGrey),
                          // prefixIcon: const Icon(Icons.person, color: ColorConstants.kIconsGrey, size: 35,),
                        ),
                      ),
                      SizedBox(
                        height: size.width * 0.05,
                      ),
                      TextField(
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.words,
                        controller: lastNameController,
                        decoration: InputDecoration(
                          hintText: "Last Name",
                          hintStyle: customText.kTextStyle(
                              16, FontWeight.w400, ColorConstants.kIconsGrey),
                          // prefixIcon: const Icon(Icons.person, color: ColorConstants.kIconsGrey, size: 35,),
                        ),
                      ),
                      SizedBox(
                        height: size.width * 0.05,
                      ),
                      TextField(
                        readOnly: true,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.words,
                        controller: userEmailController,
                        decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: customText.kTextStyle(
                              16, FontWeight.w400, ColorConstants.kIconsGrey),
                          // prefixIcon: const Icon(Icons.person, color: ColorConstants.kIconsGrey, size: 35,),
                        ),
                      ),
                      SizedBox(
                        height: size.width * 0.05,
                      ),
                      TextField(
                        buildCounter: (BuildContext context,
                            {int? currentLength,
                            int? maxLength,
                            bool? isFocused}) {
                          return null;
                        },
                        maxLength: 10,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.words,
                        controller: userMobileController,
                        decoration: InputDecoration(
                          hintText: "Mobile",
                          hintStyle: customText.kTextStyle(
                              16, FontWeight.w400, ColorConstants.kIconsGrey),
                          // prefixIcon: const Icon(Icons.person, color: ColorConstants.kIconsGrey, size: 35,),
                        ),
                      ),
                      SizedBox(
                        height: size.width * 0.05,
                      ),
                      DropDownSearchFormField(
                        textFieldConfiguration: TextFieldConfiguration(
                          decoration: InputDecoration(
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(112, 112, 112, 1),
                              ),
                            ),
                            border: const UnderlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                            hintText: 'Select State',
                            hintStyle: customText.kTextStyle(
                                16, FontWeight.w400, ColorConstants.kIconsGrey),
                          ),
                          controller: stateDropdownController,
                        ),
                        suggestionsCallback: (pattern) {
                          return getStateSuggestions(pattern);
                        },
                        itemBuilder: (context, String suggestion) {
                          return ListTile(
                            title: Text(suggestion),
                          );
                        },
                        itemSeparatorBuilder: (context, index) {
                          return const Divider();
                        },
                        transitionBuilder:
                            (context, suggestionsBox, controller) {
                          print("transition builder of state");
                          return suggestionsBox;
                        },
                        onSuggestionSelected: (String suggestion) {
                          stateDropdownController.text = suggestion;
                          print(
                              "stateController :- ${stateDropdownController.text}");

                          for (int i = 0; i < getStateItems.length; i++) {
                            if (getStateItems[i]['name'] ==
                                stateDropdownController.text) {
                              setState(() {
                                selectedStateId =
                                    getStateItems[i]['id'].toString();
                              });
                            }
                          }

                          print("selected State Id :- $selectedStateId");

                          getCityList(selectedStateId!);
                        },
                        suggestionsBoxController: stateSuggestionBoxController,
                        validator: (value) =>
                            value!.isEmpty ? 'Please select a state' : null,
                        onSaved: (value) {
                          selectedState = value;
                        },
                        displayAllSuggestionWhenTap: true,
                      ),
                      SizedBox(
                        height: size.width * 0.05,
                      ),
                      // city dropdown
                      cityCalling
                          ? SizedBox(
                              height: size.width * 0.12,
                              width: size.width,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ))
                          : DropDownSearchFormField(
                              textFieldConfiguration: TextFieldConfiguration(
                                decoration: InputDecoration(
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(112, 112, 112, 1),
                                    ),
                                  ),
                                  border: const UnderlineInputBorder(
                                    borderSide: BorderSide(),
                                  ),
                                  hintText: 'Select City',
                                  hintStyle: customText.kTextStyle(
                                      16,
                                      FontWeight.w400,
                                      ColorConstants.kIconsGrey),
                                ),
                                controller: cityDropdownController,
                              ),
                              suggestionsCallback: (pattern) {
                                return getCitySuggestions(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                print('item builder');
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },
                              itemSeparatorBuilder: (context, index) {
                                return const Divider();
                              },
                              transitionBuilder:
                                  (context, suggestionsBox, controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                cityDropdownController.text = suggestion;

                                for (int i = 0; i < getCityItems.length; i++) {
                                  if (getCityItems[i]['name'] ==
                                      cityDropdownController.text) {
                                    setState(() {
                                      selectedCityId =
                                          getCityItems[i]['id'].toString();
                                    });
                                  }
                                }
                              },
                              suggestionsBoxController:
                                  citySuggestionBoxController,
                              validator: (value) => value!.isEmpty
                                  ? 'Please select a city'
                                  : null,
                              onSaved: (value) => selectedCity = value,
                              displayAllSuggestionWhenTap: true,
                            ),
                      SizedBox(
                        height: size.width * 0.05,
                      ),
                      TextField(
                        buildCounter: (BuildContext context,
                            {int? currentLength,
                            int? maxLength,
                            bool? isFocused}) {
                          return null;
                        },
                        maxLength: 7,
                        textInputAction: TextInputAction.next,
                        controller: postalCodeController,
                        decoration: InputDecoration(
                          hintText: "Postal Code",
                          hintStyle: customText.kTextStyle(
                              16, FontWeight.w400, ColorConstants.kIconsGrey),
                          // prefixIcon: const Icon(Icons.phone_android, color: ColorConstants.kIconsGrey, size: 35,),
                        ),
                      ),
                      SizedBox(
                        height: size.width * 0.05,
                      ),
                      TextField(
                        buildCounter: (BuildContext context,
                            {int? currentLength,
                            int? maxLength,
                            bool? isFocused}) {
                          return null;
                        },
                        maxLength: 50,
                        textInputAction: TextInputAction.next,
                        controller: areaController,
                        decoration: InputDecoration(
                          hintText: "Area",
                          hintStyle: customText.kTextStyle(
                              16, FontWeight.w400, ColorConstants.kIconsGrey),
                          // prefixIcon: const Icon(Icons.phone_android, color: ColorConstants.kIconsGrey, size: 35,),
                        ),
                      ),
                      SizedBox(
                        height: size.width * 0.05,
                      ),
                      TextField(
                        maxLength: 100,
                        buildCounter: (BuildContext context,
                            {int? currentLength,
                            int? maxLength,
                            bool? isFocused}) {
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.sentences,
                        controller: userAddressController,
                        decoration: InputDecoration(
                          hintText: "Address Line 1",
                          hintStyle: customText.kTextStyle(
                              16, FontWeight.w400, ColorConstants.kIconsGrey),
                          // prefixIcon: const Icon(Icons.location_on, color: ColorConstants.kIconsGrey, size: 35,),
                        ),
                      ),
                      SizedBox(
                        height: size.width * 0.05,
                      ),
                      TextField(
                        maxLength: 100,
                        buildCounter: (BuildContext context,
                            {int? currentLength,
                            int? maxLength,
                            bool? isFocused}) {
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.sentences,
                        controller: addressTwoController,
                        decoration: InputDecoration(
                          hintText: "Address Line 2",
                          hintStyle: customText.kTextStyle(
                              16, FontWeight.w400, ColorConstants.kIconsGrey),
                          // prefixIcon: const Icon(Icons.location_on, color: ColorConstants.kIconsGrey, size: 35,),
                        ),
                      ),
                      SizedBox(
                        height: size.width * 0.05,
                      ),
                      TextField(
                        maxLength: 100,
                        buildCounter: (BuildContext context,
                            {int? currentLength,
                            int? maxLength,
                            bool? isFocused}) {
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.sentences,
                        controller: addressThreeController,
                        decoration: InputDecoration(
                          hintText: "Address Line 3",
                          hintStyle: customText.kTextStyle(
                              16, FontWeight.w400, ColorConstants.kIconsGrey),
                          // prefixIcon: const Icon(Icons.location_on, color: ColorConstants.kIconsGrey, size: 35,),
                        ),
                      ),
                      SizedBox(
                        height: size.width * 0.05,
                      ),
                      Container(
                          height: size.height * 0.06,
                          width: size.width,
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.02),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  width: 1.0, color: ColorConstants.kIconsGrey),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customText.kText(
                                  "**********",
                                  20,
                                  FontWeight.w500,
                                  ColorConstants.kIconsGrey,
                                  TextAlign.start),
                              GestureDetector(
                                child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: customText.kText(
                                        "Change",
                                        14,
                                        FontWeight.w500,
                                        ColorConstants.kIconsGrey,
                                        TextAlign.right)),
                                onTap: () {
                                  sideDrawerController.pageIndex.value = 14;
                                  sideDrawerController.pageController
                                      .jumpToPage(14);
                                },
                              )
                            ],
                          )),
                      // const Spacer(),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      GestureDetector(
                        child: Container(
                          height: size.width * 0.13,
                          width: size.width,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                                  BorderRadius.circular(size.width * 0.02),
                              gradient: const RadialGradient(
                                center: Alignment(0.19, -0.9),
                                colors: [
                                  ColorConstants.kGradientDarkGreen,
                                  ColorConstants.kGradientBlack,
                                ],
                                radius: 4.0,
                              )),
                          child: Center(
                            child: isProfileCalling
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : customText.kText(
                                    "Update Profile",
                                    24,
                                    FontWeight.w700,
                                    Colors.white,
                                    TextAlign.center),
                          ),
                        ),
                        onTap: () async {
                          print("selected state id: ${selectedStateId}");
                          print("selected city id: ${selectedCityId}");
                          setState(() {
                            isProfileCalling = true;
                          });
                          final response;
                          response = await api.updateProfileDetails(
                              firstName: firstNameController.text,
                              lastName: lastNameController.text,
                              address: userAddressController.text,
                              addressTwo: addressTwoController.text,
                              addressThree: addressThreeController.text,
                              area: areaController.text,
                              postalCode: postalCodeController.text,
                              cityId: selectedCityId,
                              stateId: selectedStateId,
                              contactNumber: userMobileController.text,
                              image: image1,
                              updateUserName: userName);

                          setState(() {
                            isProfileCalling = false;
                          });
                          if (response['status'] == 1) {
                            helper.successDialog(
                                context, "Profile Updated Successfully");
                            sideDrawerController.pageIndex.value = 0;
                            sideDrawerController.pageController.jumpToPage(0);
                          }
                        },
                      )
                    ],
                  ),
                ),
              ));
  }

  showImageSelection() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
              padding: EdgeInsets.only(top: 20),
              height: 120,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      getImageFromGallery();
                      Navigator.pop(context);
                    },
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: const Icon(
                              Icons.photo,
                            ),
                          ),
                          const SizedBox(height: 10),
                          customText.kText("Gallery", 16, FontWeight.w400,
                              Colors.black, TextAlign.start),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      getImageFromCamera();
                      Navigator.pop(context);
                    },
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: const Icon(
                              Icons.camera,
                            ),
                          ),
                          const SizedBox(height: 10),
                          customText.kText("Camera", 16, FontWeight.w400,
                              Colors.black, TextAlign.start),
                        ],
                      ),
                    ),
                  )
                ],
              ));
        });
  }
}
