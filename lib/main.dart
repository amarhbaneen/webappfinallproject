import 'package:webappfinallproject/responsive/mobile_screen_layout.dart';
import 'package:webappfinallproject/responsive/responsive_layout_screen.dart';
import 'package:webappfinallproject/responsive/web_screen_layout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'Home.dart';


Future<void> main()
async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb) // if the platform is web or not
      {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCs7ETGBjnmsEdH2Ca920O6dRDrm930MSk",
          appId: "1:824998579925:web:e0bb474c09a4ba8a499c5c",
          messagingSenderId:"824998579925",
          projectId: "finallprojectcollege",
          storageBucket: "finallprojectcollege.appspot.com"
      ),

    );
  }
  else
  {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Graphic_APP',
      theme: ThemeData(),
      home: RespsiveLayout(mobileScreenLayout: MobileScreenLayout() , webScreenLayout: WebScreenLayout()),
      debugShowCheckedModeBanner: false,
    );
  }
}