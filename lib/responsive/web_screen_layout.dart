
import 'package:flutter/material.dart';



import '../Accounter/accounterDashBoard.dart';

class WebScreenLayout extends StatelessWidget {
  const WebScreenLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AccountDashboard(),
      ),
    );
  }
}
