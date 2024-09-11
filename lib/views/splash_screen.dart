import 'package:flutter/material.dart';
import 'package:kaarobaar/views/authorization/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    super.initState();
    moveForward();
  }
  
  moveForward() {
    
    Future.delayed(
      const Duration(seconds: 3),
        () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen() ))
    );
    
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
            Image.asset("assets/images/upperCurve.png"),
            const Spacer(),
            Container(
              margin: EdgeInsets.all(size.width * 0.12),
              child: Image.asset("assets/images/logo.png")
            ),
            const Spacer(),
            Image.asset("assets/images/lowerCurve.png"),
          ],
        ),
      ),
    );
  }

}
