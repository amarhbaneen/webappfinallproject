import 'package:webappfinallproject/utils/demensions.dart';

import 'package:flutter/material.dart';

class RespsiveLayout extends StatelessWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  const RespsiveLayout({Key? key, required this.webScreenLayout, required this.mobileScreenLayout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints){
      if(constraints.maxWidth > webScreenSize )
        {
          return webScreenLayout;
        }
      return mobileScreenLayout;
    },
    );
  }
}
