import 'package:flutter/material.dart';
import 'package:h_r_m/Utils/utils.dart';
import 'package:h_r_m/View/Auth/sign_in_screen.dart';
import 'package:h_r_m/View/Bottom%20Navigation%20bar/bottom_nav_view.dart';
import 'package:h_r_m/config/keys/pref_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      getUserCredentials(context);
    });
    // Use this method to get user credentials if needed
  }

  void getUserCredentials(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString(PrefKey.authorization);

    if (token != null && token.isNotEmpty) {
      pushReplacement(context, BottomNavView());
    } else {
      pushReplacement(context, SignInScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Align(
          alignment: Alignment.center,
          child: SizedBox(
            height: 500,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Image.asset(
                "assets/images/logo.png",
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
