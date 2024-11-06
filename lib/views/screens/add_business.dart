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
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';

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
  bool isApiLoading = false, subCategoryCalling = false;
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
  TextEditingController areaController = TextEditingController();
  TextEditingController addressTwoController = TextEditingController();
  TextEditingController addressThreeController = TextEditingController();
  TextEditingController subCategoryController = TextEditingController();

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
              if (businessDescriptionController.text.isNotEmpty &&
                  (!businessDescriptionController.text.startsWith(" "))) {
                if (stateDropdownController.text.isNotEmpty &&
                    !stateDropdownController.text.startsWith(" ")) {
                  if (cityDropdownController.text.isNotEmpty &&
                      !cityDropdownController.text.startsWith(" ")) {
                    if (postalCodeController.text.isNotEmpty &&
                        !postalCodeController.text.startsWith("pattern")) {
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
                              areaController.text,
                              businessAddressController.text,
                              addressTwoController.text,
                              addressThreeController.text,
                              // _image?.path.toString(),
                              _imageFiles[0].path.toString(),
                              _imageFiles[1].path.toString(),
                              _imageFiles[2].path.toString(),
                              _imageFiles[3].path.toString(),
                              _imageFiles[4].path.toString(),
                              selectedSubCategoryId,
                            );
                            print("image 1 ${_imageFiles[0].toString()}");
                            print("image 2 ${_imageFiles[1].toString()}");
                            print("image 3 ${_imageFiles[2].toString()}");
                            print("image 4 ${_imageFiles[3].toString()}");
                            print("image 5 ${_imageFiles[4].toString()}");
                            print('add sub cat: ${selectedSubCategoryId}');
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
                                areaController.text,
                                businessAddressController.text,
                                addressTwoController.text,
                                addressThreeController.text,
                                // _image?.path.toString(),
                                _imageFiles[0].path.toString(),
                                _imageFiles[1].path.toString(),
                                _imageFiles[2].path.toString(),
                                _imageFiles[3].path.toString(),
                                _imageFiles[4].path.toString(),
                                sideDrawerController.myBusinessId,
                                selectedSubCategoryId);
                            if (response['status'] == 1) {
                              sideDrawerController.myBusinessId = "";
                            }
                          }

                          setState(() {
                            isApiCalling = false;
                          });

                          if (response["status"] == 1) {
                            helper.successDialog(context, response["message"]);
                            print('Business Added successfully');
                            if (sideDrawerController
                                .fromEditBusinessForm.isEmpty) {
                              sideDrawerController.pageIndex.value = 0;
                              sideDrawerController.pageController.jumpToPage(0);
                            } else {
                              sideDrawerController.pageIndex.value = 22;
                              sideDrawerController.pageController
                                  .jumpToPage(22);
                            }
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
                            context, "Please enter address line 1");
                      }
                    } else {
                      helper.errorDialog(context, "Please enter postal code");
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
      areaController.text = getBusinessDetailData[0]['area'] ?? "";
      addressTwoController.text = getBusinessDetailData[0]['address_2'] ?? "";
      addressThreeController.text = getBusinessDetailData[0]['address_3'] ?? "";
      // subCategoryDropDownController.text =
      //     getBusinessDetailData[0]['subcategory_name'];
      final dio = Dio();
      final directory = await getApplicationDocumentsDirectory();

      if (getBusinessDetailData[0]['featured_image'] != "") {
        print('get img 1 above');
        _imageFiles[0] = File(getBusinessDetailData[0]['featured_image']);

        print("get img 1 ${_imageFiles[0]!.path.toString()}");
      }
      if (getBusinessDetailData[0]['featured_image_2'] != "") {
        _imageFiles[1] = File(getBusinessDetailData[0]['featured_image_2']);

        print("get img 2 ${_imageFiles[1]!.path.toString()}");
      }
      if (getBusinessDetailData[0]['featured_image_3'] != "") {
        _imageFiles[2] = File(getBusinessDetailData[0]['featured_image_3']);

        print("get img 3 ${_imageFiles[2]!.path.toString()}");
      }
      if (getBusinessDetailData[0]['featured_image_4'] != "") {
        _imageFiles[3] = File(getBusinessDetailData[0]['featured_image_4']);

        print("get img 4 ${_imageFiles[3]!.path.toString()}");
      }
      if (getBusinessDetailData[0]['featured_image_5'] != "") {
        _imageFiles[4] = File(getBusinessDetailData[0]['featured_image_5']);

        print("get img 5 ${_imageFiles[4]!.path.toString()}");
      }

      print("total list length: ${_imageFiles.length}");

      // Download image locally for getting the path

      Future<void> downloadImages(_imageFiles) async {
        final dio = Dio();
        final directory = await getApplicationDocumentsDirectory();

        for (int i = 0; i < _imageFiles.length; i++) {
          try {
            final fileName = "image_$i.jpg";
            final filePath =
                "${directory.path}/$fileName"; // Get the path as a String

            // Download the image to the specified file path
            await dio.download(_imageFiles[i].toString(), filePath);
            print("Downloaded $fileName at $filePath");
          } catch (e) {
            print("Failed to download image at ${_imageFiles[i]}: $e");
          }
        }
      }

      downloadImages(_imageFiles);

      print("sub cat text: ${subCategoryDropDownController}");

      print('image url---- $imageURL');
      imageSelected = true;
    }
  }

  String? selectedCategory, selectedSubCategory;
  String? selectedCategoryId, selectedSubCategoryId;
  String? selectedState;
  String? selectedStateId;
  String? selectedCity;
  String? selectedCityId;

  final ImagePicker _picker = ImagePicker();
  // List<File> _imageFiles = []; // To store selected images
  List<File> _imageFiles = List<File>.filled(5, File(''), growable: false);
  XFile? _image;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController categoryDropdownController =
      TextEditingController();
  final TextEditingController stateDropdownController = TextEditingController();
  final TextEditingController cityDropdownController = TextEditingController();
  final TextEditingController subCategoryDropDownController =
      TextEditingController();

  SuggestionsBoxController categorySuggestionBoxController =
      SuggestionsBoxController();
  SuggestionsBoxController stateSuggestionBoxController =
      SuggestionsBoxController();
  SuggestionsBoxController citySuggestionBoxController =
      SuggestionsBoxController();
  SuggestionsBoxController subCategorySuggestionBoxController =
      SuggestionsBoxController();

  bool imageSelected = false;

  Future getImageFromGallery() async {
    if (_imageFiles.length < 5) {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
        imageSelected = true;
        _imageFiles.add(File(_image!.path)); // Add picked image to list
      });
      // print('image path from gallery 1--- ${_image?.path}');
      print('image path from gallery 1--- ${_imageFiles[0].path.toString()}');
      print('image path from gallery 2--- ${_imageFiles[1].path.toString()}');
      print('image path from gallery 3--- ${_imageFiles[2].path.toString()}');
      print('image path from gallery 4--- ${_imageFiles[3].path.toString()}');
      print('image path from gallery 5--- ${_imageFiles[4].path.toString()}');
    } else {
      helper.errorDialog(context, "Maximum 5 Images are allowed");
    }
  }

  Future getImageFromCamera() async {
    if (_imageFiles.length < 5) {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);

      setState(() {
        _image = image;
        imageSelected = true;
        _imageFiles.add(File(_image!.path)); // Add picked image to list
      });
    } else {
      helper.errorDialog(context, "Maximum 5 images are allowed");
    }
  }

  List<String> getCategorySuggestions(String query) {
    List<String> categoryMatches = <String>[];
    final List<String> categoryList = getCategoryItems
        .map((element) => element['category_name'].toString())
        .toList();
    categoryMatches.addAll(categoryList);

    // for (int i = 0; i < getCategoryItems.length; i++) {
    //   if (getCategoryItems[i]['category_name'] == selectedCategory) {
    //     selectedCategoryId = getCategoryItems[i]['id'].toString();
    //     setState(() {});
    //   }
    // }

    log("selected category Id :- $selectedCategoryId");

    categoryMatches
        .retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return categoryMatches;
  }

  List<String> getSubCategorySuggestions(String query) {
    log("sub category query :- $getSubCategoryItem");

    List<String> categoryMatches = <String>[];
    final List<String> categoryList = getSubCategoryItem
        .map((element) => element['subcategory_name'].toString())
        .toList();
    log("sub category list :- $categoryList");
    categoryMatches.addAll(categoryList);

    // for (int i = 0; i < getCategoryItems.length; i++) {
    //   if (getCategoryItems[i]['category_name'] == selectedCategory) {
    //     selectedCategoryId = getCategoryItems[i]['id'].toString();
    //     setState(() {});
    //   }
    // }

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
  List<dynamic> getSubCategoryItem = [];

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

  // sub category api itegration
  getSubCategoryList() async {
    log("selected Category Id :- $selectedCategoryId");

    setState(() {
      subCategoryCalling = true;
    });
    final response = await api.subCategoryList(selectedCategoryId.toString());
    setState(() {
      getSubCategoryItem = response['result'];
    });
    setState(() {
      subCategoryCalling = false;
    });

    print('get sub category response list ----$getSubCategoryItem');
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
      sideDrawerController.fromEditBusinessForm = "fromEditBusinessForm";
      getBusinessDetail();
    } else {
      sideDrawerController.fromEditBusinessForm = "";
      _imageFiles = [];
    }
    print('my business id is---- ${sideDrawerController.myBusinessId}');
    print("from edit ${sideDrawerController.fromEditBusiness}");
    print('page value: ${sideDrawerController.pageIndex.value}');

    // if (sideDrawerController.myBusinessId.isNotEmpty) {
    //   businessDescriptionController.text =
    //       getBusinessDetailData[0]['business_description'];
    // }

    print(
        " from edit business form: ${sideDrawerController.fromEditBusinessForm}");
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
                    onSuggestionSelected: (String suggestion) async {
                      categoryDropdownController.text = suggestion;

                      for (int i = 0; i < getCategoryItems.length; i++) {
                        if (getCategoryItems[i]['category_name'] ==
                            suggestion) {
                          selectedCategoryId =
                              getCategoryItems[i]['id'].toString();
                        }
                      }

                      selectedSubCategoryId = null;
                      selectedSubCategory = null;
                      subCategoryDropDownController.clear();
                      await getSubCategoryList();
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

                  subCategoryCalling
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
                              hintText: 'Select Sub Category',
                              hintStyle: customText.kTextStyle(16,
                                  FontWeight.w400, ColorConstants.kIconsGrey),
                            ),
                            controller: subCategoryDropDownController,
                          ),
                          suggestionsCallback: (pattern) {
                            return getSubCategorySuggestions(pattern);
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
                            return suggestionsBox;
                          },
                          onSuggestionSelected: (String suggestion) {
                            subCategoryDropDownController.text = suggestion;

                            for (int i = 0;
                                i < getSubCategoryItem.length;
                                i++) {
                              if (getSubCategoryItem[i]['category_name'] ==
                                  suggestion) {
                                selectedSubCategoryId =
                                    getSubCategoryItem[i]['id'].toString();
                              }
                            }

                            log("selected subCategoryId :- $selectedSubCategoryId");
                          },
                          suggestionsBoxController:
                              subCategorySuggestionBoxController,
                          validator: (value) => value!.isEmpty
                              ? 'Please select a sub category'
                              : null,
                          onSaved: (value) {
                            selectedSubCategory = value;
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
                        {int? currentLength, int? maxLength, bool? isFocused}) {
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.sentences,
                    controller: businessAddressController,
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
                        {int? currentLength, int? maxLength, bool? isFocused}) {
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
                        {int? currentLength, int? maxLength, bool? isFocused}) {
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

                      showImageSelection();
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
                    // child: Container(
                    //   height: h * .200,
                    //   width: w * .400,
                    //   decoration: BoxDecoration(
                    //       color: Colors.grey,
                    //       borderRadius: BorderRadius.circular(8),
                    //       image: DecorationImage(
                    //           fit: BoxFit.fill,
                    //           image: imageURL != ""
                    //               ? NetworkImage(imageURL)
                    //               : Image.file(File(_image?.path ?? ""))
                    //                   .image)),
                    // child: imageURL != ""
                    //     ? const Center(
                    //         child: Icon(
                    //         size: 34,
                    //         Icons.add,
                    //         color: Colors.black,
                    //       ))
                    //     : const SizedBox(),
                    // ),
                    child: Column(
                      children: [
                        Container(
                          // color: Colors.red,
                          height: 200,
                          width: double.infinity,
                          child: _imageFiles.isEmpty
                              ? Container(
                                  height: h * .200,
                                  width: w * .400,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          width: 1, color: Colors.grey)),
                                  child: const Center(
                                    child: Icon(
                                      Icons.add,
                                      size: 32,
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _imageFiles.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      height: h * .200,
                                      width: w * .400,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          8,
                                        ),
                                      ),
                                      child: _imageFiles.isEmpty
                                          ? Image.file(
                                              _imageFiles[index],
                                              fit: BoxFit.cover,
                                            )
                                          : Image.network(
                                              fit: BoxFit.fill,
                                              _imageFiles[index]
                                                  .path
                                                  .toString(),
                                            ),
                                    );
                                  },
                                ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            showImageSelection();
                          }, // Trigger image picker on click

                          child: Text("Add More images"),
                        ),
                      ],
                    ),
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
