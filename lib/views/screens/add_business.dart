import 'package:flutter/material.dart';
import 'package:kaarobaar/constants/color_constants.dart';
import 'package:kaarobaar/utils/helper.dart';
import 'package:kaarobaar/utils/text.dart';
import 'package:email_validator/email_validator.dart';
import 'package:drop_down_search_field/drop_down_search_field.dart';

class AddBusiness extends StatefulWidget {
  const AddBusiness({super.key});

  @override
  State<AddBusiness> createState() => _AddBusinessState();
}

class _AddBusinessState extends State<AddBusiness> {
  dynamic size;
  bool isApiCalling = false;
  final customText = CustomText(), helper = Helper();

  TextEditingController businessNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController websiteURL = TextEditingController();
  TextEditingController businessDescriptionController = TextEditingController();
  TextEditingController businessTypeController = TextEditingController();
  TextEditingController businessAddressController = TextEditingController();
  TextEditingController vatNoController = TextEditingController();
  TextEditingController businessKeywordController = TextEditingController();

  addBusiness() async {
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
                if (websiteURL.text.isNotEmpty &&
                    !websiteURL.text.startsWith(" ")) {
                  if (businessDescriptionController.text.isNotEmpty &&
                      (!businessDescriptionController.text.startsWith(" "))) {
                    if (businessTypeController.text.isNotEmpty &&
                        (!businessTypeController.text.startsWith(" "))) {
                      if (stateDropdownController.text.isNotEmpty &&
                          !stateDropdownController.text.startsWith(" ")) {
                        if (cityDropdownController.text.isNotEmpty &&
                            !cityDropdownController.text.startsWith(" ")) {
                          if (businessAddressController.text.isNotEmpty &&
                              (!businessAddressController.text
                                  .startsWith(" "))) {
                            if (vatNoController.text.isNotEmpty &&
                                (!vatNoController.text.startsWith(" "))) {
                            } else {
                              helper.errorDialog(
                                  context, "Please enter vat number");
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
                      helper.errorDialog(context, "Please enter business type");
                    }
                  } else {
                    helper.errorDialog(
                        context, "Please enter business description");
                  }
                } else {
                  helper.errorDialog(context, "Please enter website URL");
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

    // setState(() {
    //   isApiCalling = true;
    // });
    //
    // final response = await api.addBusiness();
    //
    // setState(() {
    //   isApiCalling = false;
    // });

    // if(response["statusCode"] == 200){
    //   helper.successDialog(context, response["message"]);
    // } else {
    //   helper.errorDialog(context, response["message"]);
    // }
  }

  String? selectedCategory;
  String? selectedState;
  String? selectedCity;
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

  static List<String> getCategorySuggestions(String query) {
    List<String> categoryMatches = <String>[];
    final List<String> categoryList = [
      'IT',
      'Banking',
      'Medical',
      'Education',
      'Institute',
    ];
    categoryMatches.addAll(categoryList);

    categoryMatches
        .retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return categoryMatches;
  }

  static List<String> getStateSuggestions(String query) {
    List<String> stateMatches = <String>[];
    final List<String> stateList = [
      'Uttar Pradesh',
      'Noida',
      'Andra Pradesh',
      'Delhi',
      'Lucknow',
    ];
    stateMatches.addAll(stateList);

    stateMatches
        .retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return stateMatches;
  }

  static List<String> getCitySuggestions(String query) {
    List<String> cityMatches = <String>[];
    final List<String> cityList = [
      'City1',
      'City2',
      'City3',
      'City4',
      'City5',
    ];
    cityMatches.addAll(cityList);

    cityMatches
        .retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return cityMatches;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
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
                    child: customText.kText("Add Business", 30, FontWeight.w700,
                        Colors.black, TextAlign.start),
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
                    },
                    suggestionsBoxController: categorySuggestionBoxController,
                    validator: (value) =>
                        value!.isEmpty ? 'Please select a category' : null,
                    onSaved: (value) => selectedCategory = value,
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
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
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
                  TextField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    controller: businessTypeController,
                    decoration: InputDecoration(
                      hintText: "Business Type",
                      hintStyle: customText.kTextStyle(
                          16, FontWeight.w400, ColorConstants.kIconsGrey),
                      // prefixIcon: const Icon(Icons.category, color: ColorConstants.kIconsGrey, size: 35,),
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
                      return suggestionsBox;
                    },
                    onSuggestionSelected: (String suggestion) {
                      stateDropdownController.text = suggestion;
                    },
                    suggestionsBoxController: stateSuggestionBoxController,
                    validator: (value) =>
                        value!.isEmpty ? 'Please select a state' : null,
                    onSaved: (value) => selectedState = value,
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
                  TextField(
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    controller: vatNoController,
                    decoration: InputDecoration(
                      hintText: "VAT Number",
                      hintStyle: customText.kTextStyle(
                          16, FontWeight.w400, ColorConstants.kIconsGrey),
                      // prefixIcon: const Icon(Icons.onetwothree, color: ColorConstants.kIconsGrey, size: 35,),
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
                            : customText.kText("Register", 30, FontWeight.w700,
                                Colors.white, TextAlign.center),
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
