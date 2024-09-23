import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class MyBusiness extends StatefulWidget {
  const MyBusiness({super.key});

  @override
  State<MyBusiness> createState() => _MyBusinessState();
}

class _MyBusinessState extends State<MyBusiness> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text('This is my business page'),
        ),
      ),
    );
  }
}
