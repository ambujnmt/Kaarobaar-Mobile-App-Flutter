import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaarobaar/constants/color_constants.dart';
import 'package:kaarobaar/controllers/side_drawerController.dart';
import 'package:kaarobaar/services/api_services.dart';
import 'package:kaarobaar/utils/helper.dart';
import 'package:kaarobaar/utils/text.dart';
import 'package:email_validator/email_validator.dart';
import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

class AddBusiness extends StatefulWidget {
  const AddBusiness({super.key});

  @override
  State<AddBusiness> createState() => _AddBusinessState();
}

class _AddBusinessState extends State<AddBusiness> {
  dynamic size;
  bool isApiCalling = false;
  final customText = CustomText(), helper = Helper();
  bool isApiLoading = false;
  List<dynamic> getBusinessDetailData = [];
  String imageURL = "";

  TextEditingController businessNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController websiteURL = TextEditingController();
  TextEditingController businessDescriptionController = TextEditingController();
  TextEditingController businessAddressController = TextEditingController();
  TextEditingController businessKeywordController = TextEditingController();
  SideDrawerController sideDrawerController = Get.put(SideDrawerController());

  addBusiness() async {
    for (int i = 0; i < getCategoryItems.length; i++) {
      if (getCategoryItems[i]['category_name'] ==
          categoryDropdownController.text) {
        selectedCategoryId = getCategoryItems[i]['id'].toString();
      }
    }

    for (int i = 0; i < getStateItems.length; i++) {
      if (getStateItems[i]['name'] == stateDropdownController.text) {
        setState(() {
          selectedStateId = getStateItems[i]['id'].toString();
        });
      }
    }

    for (int i = 0; i < getCityItems.length; i++) {
      if (getCityItems[i]['name'] == cityDropdownController.text) {
        setState(() {
          selectedCityId = getCityItems[i]['id'].toString();
        });
      }
    }

    print('selected state id---- $selectedStateId');
    print('selected city id---- $selectedCityId');
    print('selected category id---- $selectedCategoryId');

    if (businessNameController.text.isNotEmpty &&
        (!businessNameController.text.startsWith(" "))) {
      if (categoryDropdownController.text.isNotEmpty &&
          !categoryDropdownController.text.startsWith(" ")) {
        if (businessKeywordController.text.isNotEmpty &&
            !businessKeywordController.text.startsWith(" ")) {
          if (EmailValidator.validate(emailController.text)) {
            if (phoneController.text.length == 10) {
              if (postalCodeController.text.isNotEmpty &&
                  !postalCodeController.text.startsWith(" ")) {
                if (businessDescriptionController.text.isNotEmpty &&
                    (!businessDescriptionController.text.startsWith(" "))) {
                  if (stateDropdownController.text.isNotEmpty &&
                      !stateDropdownController.text.startsWith(" ")) {
                    if (cityDropdownController.text.isNotEmpty &&
                        !cityDropdownController.text.startsWith(" ")) {
                      if (businessAddressController.text.isNotEmpty &&
                          (!businessAddressController.text.startsWith(" "))) {
                        if (imageSelected) {
                          setState(() {
                            isApiCalling = true;
                          });
                          final response;

                          if (sideDrawerController.myBusinessId.isEmpty) {
                            print('inside the add function');
                            response = await api.addBusiness(
                              businessNameController.text,
                              selectedCategoryId,
                              businessKeywordController.text,
                              emailController.text,
                              phoneController.text,
                              postalCodeController.text,
                              websiteURL.text,
                              businessDescriptionController.text,
                              selectedStateId,
                              selectedCityId,
                              businessAddressController.text,
                              _image?.path.toString(),
                            );
                          } else {
                            print(
                                'inside the edit function --- ${sideDrawerController.myBusinessId}');
                            response = await api.updateBusinessDetails(
                              businessNameController.text,
                              selectedCategoryId,
                              businessKeywordController.text,
                              emailController.text,
                              phoneController.text,
                              postalCodeController.text,
                              websiteURL.text,
                              businessDescriptionController.text,
                              selectedStateId,
                              selectedCityId,
                              businessAddressController.text,
                              _image?.path.toString(),
                              sideDrawerController.myBusinessId,
                            );
                          }

                          setState(() {
                            isApiCalling = false;
                          });

                          if (response["status"] == 1) {
                            helper.successDialog(context, response["message"]);
                            print('Business Added successfully');
                            sideDrawerController.pageIndex.value = 0;
                            sideDrawerController.pageController.jumpToPage(0);
                          } else {
                            helper.errorDialog(context, response["message"]);
                          }
                          // else
                        } else {
                          helper.errorDialog(
                              context, "Please upload business image");
                        }
                      } else {
                        helper.errorDialog(
                            context, "Please enter business address");
                      }
                    } else {
                      helper.errorDialog(context, 'Please select city');
                    }
                  } else {
                    helper.errorDialog(context, 'Please select state');
                  }
                } else {
                  helper.errorDialog(
                      context, "Please enter business description");
                }
              } else {
                helper.errorDialog(context, "Please enter postal code");
              }
            } else {
              helper.errorDialog(
                  context, "Please enter valid 10 digit phone number");
            }
          } else {
            helper.errorDialog(context, "Please enter valid email address");
          }
        } else {
          helper.errorDialog(context, 'Please enter business keywords');
        }
      } else {
        helper.errorDialog(context, 'Please select category');
      }
    } else {
      helper.errorDialog(context, "Please enter valid business name");
    }
  }

  getBusinessDetail() async {
    setState(() {
      isApiLoading = true;
    });

    final response =
        await api.myBusinessDetail(sideDrawerController.myBusinessId);

    setState(() {
      getBusinessDetailData = response['result'];
    });

    setState(() {
      isApiLoading = false;
    });
    if (response['status'] == 1) {
      print('status 1');
      businessNameController.text =
          getBusinessDetailData[0]['business_title'] ?? " ";
      categoryDropdownController.text =
          getBusinessDetailData[0]['category_name'] ?? " ";
      businessKeywordController.text =
          getBusinessDetailData[0]['keywords'] ?? " ";
      emailController.text = getBusinessDetailData[0]['email'] ?? " ";
      phoneController.text = getBusinessDetailData[0]['mobile'] ?? " ";
      postalCodeController.text = getBusinessDetailData[0]['zipcode'] ?? " ";
      websiteURL.text = getBusinessDetailData[0]['website'] ?? " ";
      businessDescriptionController.text =
          getBusinessDetailData[0]['business_description'] ?? " ";
      stateDropdownController.text =
          getBusinessDetailData[0]['state_name'] ?? " ";
      cityDropdownController.text =
          getBusinessDetailData[0]['city_name'] ?? " ";
      businessAddressController.text =
          getBusinessDetailData[0]['address'] ?? " ";
      imageURL = getBusinessDetailData[0]['featured_image'] ?? "";
      selectedStateId = getBusinessDetailData[0]['state_id'] ?? "";
      selectedCityId = getBusinessDetailData[0]['city_id'] ?? "";

      print('image url---- $imageURL');
      imageSelected = true;
    }
  }

  String? selectedCategory;
  String? selectedCategoryId;
  String? selectedState;
  String? selectedStateId;
  String? selectedCity;
  String? selectedCityId;

  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController categoryDropdownController =
      TextEditingController();
  final TextEditingController stateDropdownController = TextEditingController();
  final TextEditingController cityDropdownController = TextEditingController();

  SuggestionsBoxController categorySuggestionBoxController =
      SuggestionsBoxController();
  SuggestionsBoxController stateSuggestionBoxController =
      SuggestionsBoxController();
  SuggestionsBoxController citySuggestionBoxController =
      SuggestionsBoxController();

  bool imageSelected = false;

  Future getImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      imageSelected = true;
    });
    print('image path from gallery--- ${_image?.path}');
  }

  Future getImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
      imageSelected = true;
    });
  }

  List<String> getCategorySuggestions(String query) {
    List<String> categoryMatches = <String>[];
    final List<String> categoryList = getCategoryItems
        .map((element) => element['category_name'].toString())
        .toList();
    categoryMatches.addAll(categoryList);

    for (int i = 0; i < getCategoryItems.length; i++) {
      if (getCategoryItems[i]['category_name'] == selectedCategory) {
        selectedCategoryId = getCategoryItems[i]['id'].toString();
      }
    }

    categoryMatches
        .retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return categoryMatches;
  }

  List<String> getStateSuggestions(String query) {
    log("get state suggestions");

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

    log("selectedState Id :-$selectedStateId");
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

  final api = API();
  List<dynamic> getCategoryItems = [];
  List<dynamic> getStateItems = [];
  List<dynamic> getCityItems = [];

  // category list api integration

  getCategoryList() async {
    setState(() {
      isApiCalling = true;
    });
    final response = await api.categoryList();
    setState(() {
      getCategoryItems = response['result'];
    });
    setState(() {
      isApiCalling = false;
    });

    print('get category response list ----$getCategoryItems');
  }

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
    log("selected state Id :- $selectedStateId, $stateId}");

    setState(() {
      isApiCalling = true;
    });
    final response = await api.cityList(selectedStateId.toString()); //3805
    setState(() {
      getCityItems = response['result'];
    });
    setState(() {
      isApiCalling = false;
    });

    print('get city response list ----$getCityItems');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryList();
    getStateList();
    // getCityList();
    if (sideDrawerController.myBusinessId.isNotEmpty) {
      getBusinessDetail();
    }
    print('my business id is---- ${sideDrawerController.myBusinessId}');

    // if (sideDrawerController.myBusinessId.isNotEmpty) {
    //   businessDescriptionController.text =
    //       getBusinessDetailData[0]['business_description'];
    // }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
            height: size.height * 0.77,
            width: size.width,
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                    child: customText.kText(
                        sideDrawerController.myBusinessId == ""
                            ? "Add Business"
                            : "Update Business",
                        30,
                        FontWeight.w700,
                        Colors.black,
                        TextAlign.start),
                  ),
                  TextField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    controller: businessNameController,
                    decoration: InputDecoration(
                      hintText: "Business Name",
                      hintStyle: customText.kTextStyle(
                          16, FontWeight.w400, ColorConstants.kIconsGrey),
                      // prefixIcon: const Icon(Icons.person, color: ColorConstants.kIconsGrey, size: 35,),
                    ),
                  ),
                  SizedBox(
                    height: size.width * 0.05,
                  ),
                  // category dropdown
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
                        hintText: 'Select Category',
                        hintStyle: customText.kTextStyle(
                            16, FontWeight.w400, ColorConstants.kIconsGrey),
                      ),
                      controller: categoryDropdownController,
                    ),
                    suggestionsCallback: (pattern) {
                      return getCategorySuggestions(pattern);
                    },
                    itemBuilder: (context, String suggestion) {
                      return ListTile(
                        title: Text(suggestion),
                      );
                    },
                    itemSeparatorBuilder: (context, index) {
                      return const Divider();
                    },
                    transitionBuilder: (context, suggestionsBox, controller) {
                      return suggestionsBox;
                    },
                    onSuggestionSelected: (String suggestion) {
                      categoryDropdownController.text = suggestion;
                      print(
                          'category controller------${categoryDropdownController.text}---id ${selectedCategoryId}');
                    },
                    suggestionsBoxController: categorySuggestionBoxController,
                    validator: (value) =>
                        value!.isEmpty ? 'Please select a category' : null,
                    onSaved: (value) {
                      selectedCategory = value;
                    },
                    displayAllSuggestionWhenTap: true,
                  ),
                  SizedBox(
                    height: size.width * 0.05,
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    controller: businessKeywordController,
                    decoration: InputDecoration(
                      hintText: "Business Keywords",
                      hintStyle: customText.kTextStyle(
                          16, FontWeight.w400, ColorConstants.kIconsGrey),
                      // prefixIcon: const Icon(Icons.email, color: ColorConstants.kIconsGrey, size: 35,),
                    ),
                  ),
                  SizedBox(
                    height: size.width * 0.05,
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: customText.kTextStyle(
                          16, FontWeight.w400, ColorConstants.kIconsGrey),
                      // prefixIcon: const Icon(Icons.email, color: ColorConstants.kIconsGrey, size: 35,),
                    ),
                  ),
                  SizedBox(
                    height: size.width * 0.05,
                  ),
                  TextField(
                    buildCounter: (BuildContext context,
                        {int? currentLength, int? maxLength, bool? isFocused}) {
                      return null;
                    },
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    controller: phoneController,
                    decoration: InputDecoration(
                      hintText: "Contact Number",
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
                        {int? currentLength, int? maxLength, bool? isFocused}) {
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
                        {int? currentLength, int? maxLength, bool? isFocused}) {
                      return null;
                    },
                    maxLength: 30,
                    textInputAction: TextInputAction.next,
                    controller: websiteURL,
                    decoration: InputDecoration(
                      hintText: "Website URL",
                      hintStyle: customText.kTextStyle(
                          16, FontWeight.w400, ColorConstants.kIconsGrey),
                      // prefixIcon: const Icon(Icons.phone_android, color: ColorConstants.kIconsGrey, size: 35,),
                    ),
                  ),

                  SizedBox(
                    height: size.width * 0.05,
                  ),

                  TextField(
                    maxLength: 120,
                    buildCounter: (BuildContext context,
                        {int? currentLength, int? maxLength, bool? isFocused}) {
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.none,
                    controller: businessDescriptionController,
                    decoration: InputDecoration(
                      hintText: "Business desciption",
                      hintStyle: customText.kTextStyle(
                          16, FontWeight.w400, ColorConstants.kIconsGrey),
                      // prefixIcon: const Icon(Icons.store, color: ColorConstants.kIconsGrey, size: 35,),
                    ),
                  ),

                  SizedBox(
                    height: size.width * 0.05,
                  ),
                  // state dropdown
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
                    transitionBuilder: (context, suggestionsBox, controller) {
                      log("transition builder of state");
                      return suggestionsBox;
                    },
                    onSuggestionSelected: (String suggestion) {
                      stateDropdownController.text = suggestion;
                      log("stateController :- ${stateDropdownController.text}");

                      for (int i = 0; i < getStateItems.length; i++) {
                        if (getStateItems[i]['name'] ==
                            stateDropdownController.text) {
                          setState(() {
                            selectedStateId = getStateItems[i]['id'].toString();
                          });
                        }
                      }

                      log("selected State Id :- $selectedStateId");

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
                        hintText: 'Select City',
                        hintStyle: customText.kTextStyle(
                            16, FontWeight.w400, ColorConstants.kIconsGrey),
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
                    transitionBuilder: (context, suggestionsBox, controller) {
                      return suggestionsBox;
                    },
                    onSuggestionSelected: (String suggestion) {
                      cityDropdownController.text = suggestion;
                    },
                    suggestionsBoxController: citySuggestionBoxController,
                    validator: (value) =>
                        value!.isEmpty ? 'Please select a city' : null,
                    onSaved: (value) => selectedCity = value,
                    displayAllSuggestionWhenTap: true,
                  ),
                  SizedBox(
                    height: size.width * 0.05,
                  ),
                  TextField(
                    maxLength: 100,
                    buildCounter: (BuildContext context,
                        {int? currentLength, int? maxLength, bool? isFocused}) {
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.sentences,
                    controller: businessAddressController,
                    decoration: InputDecoration(
                      hintText: "Business Address",
                      hintStyle: customText.kTextStyle(
                          16, FontWeight.w400, ColorConstants.kIconsGrey),
                      // prefixIcon: const Icon(Icons.location_on, color: ColorConstants.kIconsGrey, size: 35,),
                    ),
                  ),
                  SizedBox(
                    height: size.width * 0.05,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                    child: customText.kText("Upload Featured Image", 16,
                        FontWeight.w400, Colors.black, TextAlign.start),
                  ),

                  GestureDetector(
                    onTap: () {
                      if (imageURL != "") {
                        setState(() {
                          imageURL = "";
                        });
                      }
                      // show modal bottom sheet
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                                padding: EdgeInsets.only(top: 20),
                                height: 120,
                                color: Colors.white,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        getImageFromGallery();
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 20),
                                              child: const Icon(
                                                Icons.photo,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            customText.kText(
                                                "Gallery",
                                                16,
                                                FontWeight.w400,
                                                Colors.black,
                                                TextAlign.start),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 20),
                                              child: const Icon(
                                                Icons.camera,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            customText.kText(
                                                "Camera",
                                                16,
                                                FontWeight.w400,
                                                Colors.black,
                                                TextAlign.start),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ));
                          });
                    },
                    // child: imageURL == " "
                    //     ? Container(
                    //         height: h * .200,
                    //         width: w * .400,
                    //         decoration: BoxDecoration(
                    //           color: Colors.grey,
                    //           borderRadius: BorderRadius.circular(8),
                    //           image: DecorationImage(
                    //             fit: BoxFit.fill,
                    //             image: FileImage(
                    //               File(_image?.path ?? ''),
                    //             ),
                    //           ),
                    //         ),
                    //         child: Center(
                    //           child: _image == null
                    //               ? const Icon(
                    //                   size: 34,
                    //                   Icons.add,
                    //                   color: Colors.black,
                    //                 )
                    //               : Container(),
                    //         ),
                    //       )
                    //     : Container(
                    //         height: h * .200,
                    //         width: w * .400,
                    //         decoration: BoxDecoration(
                    //           color: Colors.grey,
                    //           borderRadius: BorderRadius.circular(8),
                    //           image: DecorationImage(
                    //             fit: BoxFit.fill,
                    //             image: NetworkImage(
                    //               imageURL,
                    //             ),
                    //           ),
                    //         ),
                    //         child: Center(
                    //           child: imageURL == " "
                    //               ? const Icon(
                    //                   size: 34,
                    //                   Icons.add,
                    //                   color: Colors.black,
                    //                 )
                    //               : Container(),
                    //         ),
                    //       ),
                    child: Container(
                        height: h * .200,
                        width: w * .400,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: imageURL != ""
                                    ? NetworkImage(imageURL)
                                    : Image.file(File(_image?.path ?? ""))
                                        .image)),
                        child: imageURL != ""
                            ? const Center(
                                child: Icon(
                                size: 34,
                                Icons.add,
                                color: Colors.black,
                              ))
                            : const SizedBox()),
                  ),

                  SizedBox(
                    height: size.width * 0.15,
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
                        child: isApiCalling
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : sideDrawerController.myBusinessId.isEmpty
                                ? customText.kText(
                                    "Register",
                                    30,
                                    FontWeight.w700,
                                    Colors.white,
                                    TextAlign.center)
                                : customText.kText(
                                    "Update",
                                    30,
                                    FontWeight.w700,
                                    Colors.white,
                                    TextAlign.center),
                      ),
                    ),
                    onTap: () {
                      addBusiness();
                    },
                  )
                ],
              ),
            )));
  }
}
