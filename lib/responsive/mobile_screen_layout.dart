
import 'package:flutter/material.dart';

import 'package:webappfinallproject/Home.dart';

class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Home(),
      ),
    );
  }
}
