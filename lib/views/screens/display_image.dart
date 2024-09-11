import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:kaarobaar/constants/color_constants.dart';

class DisplayImage extends StatefulWidget {
  final image;
  const DisplayImage({super.key, this.image});

  @override
  State<DisplayImage> createState() => _DisplayImageState();
}

class _DisplayImageState extends State<DisplayImage> {

  dynamic size;
  String image = "";

  @override
  void initState() {
    super.initState();
    image = widget.image;
    log("display image init :- ${widget.image}");
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [

              Container(
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.only(top: size.height * 0.01),
                  height: size.width * 0.08,
                  child: Row(
                    children: [
                      SizedBox(width: size.width * 0.02),
                      GestureDetector(
                        child: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 35,),
                        onTap: () {
                          Navigator.pop(context);
                        }
                      ),
                      SizedBox(width: size.width * 0.08),
                      Image.asset("assets/images/logoText.png"),
                    ],
                  )
              ),

              Container(
                height: size.height * 0.8,
                width: size.width * 0.95,
                // margin: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.height * 0.08),
                margin: EdgeInsets.symmetric(vertical: size.height * 0.015),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(size.width * 0.05)
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.03, horizontal: size.width * 0.02),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size.width * 0.05),
                        gradient: const RadialGradient(
                          center: Alignment(0.8, -0.35),
                          colors: [
                            ColorConstants.kGradientRed,
                            ColorConstants.kGradientBlack,
                          ],
                          radius: 1.3,
                        )
                    ),
                    child: Image.file(
                      File(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

