
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hrm_project/View/Auth/sign_in_screen.dart';
import 'package:hrm_project/View/HomePAge/home_screen.dart';
import 'package:hrm_project/View/splash_screen.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Calender',
        theme: ThemeData(),
        home: const LandingScreen(),
      );
    });
  }
}
