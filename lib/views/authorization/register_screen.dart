import 'dart:io';
import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kaarobaar/constants/color_constants.dart';
import 'package:kaarobaar/controllers/login_controller.dart';
import 'package:kaarobaar/services/api_services.dart';
import 'package:kaarobaar/utils/helper.dart';
import 'package:kaarobaar/utils/text.dart';
import 'package:email_validator/email_validator.dart';
import 'package:kaarobaar/views/authorization/login_screen.dart';
import 'package:kaarobaar/views/authorization/otp_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  dynamic size;
  final customText = CustomText(),
      helper = Helper(),
      api = API(),
      box = GetStorage();
  double systemBarSpace = 0;
  bool hidePass = true, hideConfirmPass = true, isApiCalling = false;
  bool cityCalling = false;

  List<dynamic> getStateItems = [];
  List<dynamic> getCityItems = [];

  String? selectedState, selectedStateId, selectedCity, selectedCityId;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController stateDropdownController = TextEditingController();
  TextEditingController cityDropdownController = TextEditingController();
  TextEditingController areaController = TextEditingController();

  LoginController loginController = Get.put(LoginController());
  SuggestionsBoxController stateSuggestionBoxController =
      SuggestionsBoxController();
  SuggestionsBoxController citySuggestionBoxController =
      SuggestionsBoxController();

  // Create a variable to store the selected value
  int _selectedValue = 1;
  String selected = "";

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

  @override
  void initState() {
    super.initState();
    getStateList();
    if (Platform.isAndroid) {
      systemBarSpace = 1.5;
    } else if (Platform.isIOS) {
      systemBarSpace = -30;
    }
  }

  register() async {
    for (int i = 0; i < getCityItems.length; i++) {
      if (getCityItems[i]['name'] == cityDropdownController.text) {
        setState(() {
          selectedCityId = getCityItems[i]['id'].toString();
        });
      }
    }
    if (nameController.text.isNotEmpty) {
      if (EmailValidator.validate(emailController.text)) {
        if (passwordController.text.length >= 8 &&
            (!passwordController.text.contains(" "))) {
          if (passwordController.text == confirmPasswordController.text) {
            if (phoneController.text.length >= 10 &&
                phoneController.text.length <= 12) {
              if (stateDropdownController.text.isNotEmpty &&
                  !stateDropdownController.text.startsWith(" ")) {
                if (cityDropdownController.text.isNotEmpty &&
                    !cityDropdownController.text.startsWith(" ")) {
                  if (areaController.text.isNotEmpty &&
                      !areaController.text.startsWith(" ")) {
                    setState(() {
                      isApiCalling = true;
                    });

                    final response = await api.register(
                        nameController.text,
                        emailController.text,
                        passwordController.text,
                        "1",
                        phoneController.text,
                        selectedStateId.toString(),
                        selectedCityId.toString(),
                        areaController.text
                        // _selectedValue.toString(),
                        );

                    setState(() {
                      isApiCalling = false;
                    });

                    if (response["status"] == 1) {
                      helper.successDialog(context, response["message"]);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OTPScreen(
                                  email: emailController.text,
                                  from: "register")));
                    } else {
                      helper.errorDialog(context, response["message"]);
                    }
                  } else {
                    helper.errorDialog(context, "Please enter area");
                  }
                } else {
                  helper.errorDialog(context, "Please select city");
                }
              } else {
                helper.errorDialog(context, "Please select county");
              }
            } else {
              helper.errorDialog(context, "Please enter valid phone number");
            }
          } else {
            helper.errorDialog(
                context, "Password and confirm password doesn't match");
          }
        } else {
          helper.errorDialog(
              context, "Password should be atleast 8 characters");
        }
      } else {
        helper.errorDialog(context, "Please enter a valid email address");
      }
    } else {
      helper.errorDialog(context, "Please enter your name");
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              top: systemBarSpace,
              child: Container(
                height: size.height * 0.38,
                width: size.width,
                alignment: Alignment.topCenter,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/bgImage.png"))),
                child: Padding(
                  padding: Platform.isIOS
                      ? EdgeInsets.fromLTRB(size.width * 0.1, size.width * 0.3,
                          size.width * 0.1, 0)
                      : EdgeInsets.fromLTRB(size.width * 0.1, size.width * 0.22,
                          size.width * 0.1, 0),
                  child: Image.asset("assets/images/logoText.png"),
                ),
              ),
            ),
            Container(
              height: size.height * 0.78,
              width: size.width,
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05, vertical: size.height * 0.07),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(size.width * 0.1))),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customText.kText("Register", 30, FontWeight.w800,
                        Colors.black, TextAlign.left),
                    customText.kText("Please register to create your account",
                        18, FontWeight.w400, Colors.black, TextAlign.left),
                    SizedBox(
                      height: size.width * 0.1,
                    ),
                    TextField(
                      buildCounter: (BuildContext context,
                          {int? currentLength,
                          int? maxLength,
                          bool? isFocused}) {
                        return null;
                      },
                      maxLength: 30,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      controller: nameController,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                          hintText: "Name",
                          hintStyle: customText.kTextStyle(
                              16, FontWeight.w400, ColorConstants.kIconsGrey),
                          prefixIcon: const Icon(
                            Icons.person,
                            color: ColorConstants.kIconsGrey,
                            size: 35,
                          )),
                    ),
                    SizedBox(
                      height: size.width * 0.03,
                    ),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      controller: emailController,
                      decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: customText.kTextStyle(
                              16, FontWeight.w400, ColorConstants.kIconsGrey),
                          prefixIcon: const Icon(
                            Icons.email,
                            color: ColorConstants.kIconsGrey,
                            size: 35,
                          )),
                    ),
                    SizedBox(
                      height: size.width * 0.03,
                    ),
                    TextField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      controller: passwordController,
                      obscureText: hidePass,
                      decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: customText.kTextStyle(
                              16, FontWeight.w400, ColorConstants.kIconsGrey),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: ColorConstants.kIconsGrey,
                            size: 35,
                          ),
                          suffixIcon: GestureDetector(
                            child: hidePass
                                ? const Icon(
                                    Icons.visibility_off_outlined,
                                    size: 28,
                                    color: ColorConstants.kIconsGrey,
                                  )
                                : const Icon(
                                    Icons.visibility_outlined,
                                    size: 28,
                                    color: ColorConstants.kIconsGrey,
                                  ),
                            onTap: () {
                              setState(() {
                                hidePass = !hidePass;
                              });
                            },
                          )),
                    ),
                    SizedBox(
                      height: size.width * 0.03,
                    ),
                    TextField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      controller: confirmPasswordController,
                      obscureText: hideConfirmPass,
                      decoration: InputDecoration(
                          hintText: "Confirm password",
                          hintStyle: customText.kTextStyle(
                              16, FontWeight.w400, ColorConstants.kIconsGrey),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: ColorConstants.kIconsGrey,
                            size: 35,
                          ),
                          suffixIcon: GestureDetector(
                            child: hideConfirmPass
                                ? const Icon(
                                    Icons.visibility_off_outlined,
                                    size: 28,
                                    color: ColorConstants.kIconsGrey,
                                  )
                                : const Icon(
                                    Icons.visibility_outlined,
                                    size: 28,
                                    color: ColorConstants.kIconsGrey,
                                  ),
                            onTap: () {
                              setState(() {
                                hideConfirmPass = !hideConfirmPass;
                              });
                            },
                          )),
                    ),
                    SizedBox(
                      height: size.width * 0.03,
                    ),
                    TextField(
                      buildCounter: (BuildContext context,
                          {int? currentLength,
                          int? maxLength,
                          bool? isFocused}) {
                        return null;
                      },
                      maxLength: 12,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      controller: phoneController,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        hintText: "Contact Number",
                        hintStyle: customText.kTextStyle(
                            16, FontWeight.w400, ColorConstants.kIconsGrey),
                        prefixIcon: const Icon(
                          Icons.phone,
                          color: ColorConstants.kIconsGrey,
                          size: 35,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.width * 0.03,
                    ),
                    DropDownSearchFormField(
                      textFieldConfiguration: TextFieldConfiguration(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.home,
                            color: ColorConstants.kIconsGrey,
                            size: 35,
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(112, 112, 112, 1),
                            ),
                          ),
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                          hintText: 'Select County',
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
                      height: size.width * 0.03,
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
                                prefixIcon: const Icon(
                                  Icons.location_city,
                                  color: ColorConstants.kIconsGrey,
                                  size: 35,
                                ),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(112, 112, 112, 1),
                                  ),
                                ),
                                border: const UnderlineInputBorder(
                                  borderSide: BorderSide(),
                                ),
                                hintText: 'Select City',
                                hintStyle: customText.kTextStyle(16,
                                    FontWeight.w400, ColorConstants.kIconsGrey),
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
                            },
                            suggestionsBoxController:
                                citySuggestionBoxController,
                            validator: (value) =>
                                value!.isEmpty ? 'Please select a city' : null,
                            onSaved: (value) => selectedCity = value,
                            displayAllSuggestionWhenTap: true,
                          ),
                    SizedBox(
                      height: size.width * 0.03,
                    ),
                    TextField(
                      buildCounter: (BuildContext context,
                          {int? currentLength,
                          int? maxLength,
                          bool? isFocused}) {
                        return null;
                      },
                      maxLength: 40,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      controller: areaController,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                          hintText: "Area",
                          hintStyle: customText.kTextStyle(
                              16, FontWeight.w400, ColorConstants.kIconsGrey),
                          prefixIcon: const Icon(
                            Icons.location_on,
                            color: ColorConstants.kIconsGrey,
                            size: 35,
                          )),
                    ),
                    SizedBox(
                      height: size.width * 0.03,
                    ),
                    // Container(
                    //   margin: const EdgeInsets.only(left: 10),
                    //   child: customText.kText(
                    //       maxLines: 2,
                    //       "Are you registering as a business or the individuals ?",
                    //       18,
                    //       FontWeight.w400,
                    //       Colors.black,
                    //       TextAlign.left),
                    // ),

                    // Radio
                    // Container(
                    //   height: 50,
                    //   width: double.infinity,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Expanded(
                    //         flex: 1,
                    //         child: Container(
                    //           child: RadioListTile(
                    //             activeColor: ColorConstants.kGradientDarkGreen,
                    //             contentPadding: EdgeInsets.all(0),
                    //             title: customText.kText(
                    //                 "Individual",
                    //                 16,
                    //                 FontWeight.w400,
                    //                 Colors.black,
                    //                 TextAlign.left),
                    //             value: 1,
                    //             groupValue: _selectedValue,
                    //             onChanged: (value) {
                    //               setState(() {
                    //                 _selectedValue = value!;
                    //               });
                    //               print('selected value-----${_selectedValue}');
                    //             },
                    //           ),
                    //         ),
                    //       ),
                    //       Expanded(
                    //         flex: 1,
                    //         child: Container(
                    //           child: RadioListTile(
                    //             contentPadding: EdgeInsets.only(left: 0),
                    //             activeColor: ColorConstants.kGradientDarkGreen,
                    //             title: customText.kText(
                    //                 "Business",
                    //                 16,
                    //                 FontWeight.w400,
                    //                 Colors.black,
                    //                 TextAlign.left),
                    //             value: 2,
                    //             groupValue: _selectedValue,
                    //             onChanged: (value) {
                    //               setState(() {
                    //                 _selectedValue = value!;
                    //               });
                    //               print('selected value-----${_selectedValue}');
                    //             },
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    SizedBox(
                      // height: size.width * 0.25,
                      height: size.width * .100,
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
                              : customText.kText(
                                  "Register",
                                  30,
                                  FontWeight.w700,
                                  Colors.white,
                                  TextAlign.center),
                        ),
                      ),
                      onTap: () {
                        FocusScope.of(context).unfocus();

                        register();
                        print("selected state id: ${selectedStateId}");
                        print("selected city id: ${selectedCityId}");
                        setState(() {
                          // if (_selectedValue == 1) {
                          //   selected = "business";
                          //   print('ontap selected=== ${selected}');
                          // } else {
                          //   selected = "individual";
                          //   print('ontap selected=== ${selected}');
                          // }
                          print('set value---- ${_selectedValue}');
                        });
                        print('ontap selection:----${_selectedValue}');
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
