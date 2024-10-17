import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kaarobaar/views/authorization/login_screen.dart';
import 'package:kaarobaar/views/side_menuDrawer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    moveForward();
  }

  moveForward() {
    var accessToken = box.read('accessToken');

    print('access token==== $accessToken');

    Future.delayed(
        const Duration(seconds: 3),
        () => accessToken == null
            ? Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const LoginScreen()))
            : Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const SideMenuDrawer())));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            Image.asset(
              "assets/images/upperCurve.png",
              // color: Color(0xffEE0200),
            ),
            const Spacer(),
            Container(
                margin: EdgeInsets.all(size.width * 0.12),
                child: Image.asset("assets/images/logo.png")),
            const Spacer(),
            Image.asset("assets/images/lowerCurve.png"),
          ],
        ),
      ),
    );
  }
}
