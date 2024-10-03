import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class PopularCommunitiesDetails extends StatefulWidget {
  const PopularCommunitiesDetails({super.key});

  @override
  State<PopularCommunitiesDetails> createState() =>
      _PopularCommunitiesDetailsState();
}

class _PopularCommunitiesDetailsState extends State<PopularCommunitiesDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: const Text('Communities Details Screen')),
      ),
    );
  }
}
