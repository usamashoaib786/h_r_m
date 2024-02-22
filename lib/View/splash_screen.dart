import 'package:flutter/material.dart';
import 'package:hrm_project/Utils/resources/res/app_theme.dart';
import 'package:hrm_project/Utils/utils.dart';
import 'package:hrm_project/Utils/widgets/others/app_text.dart';
import 'package:hrm_project/View/Auth/sign_in_screen.dart';
import 'package:hrm_project/config/keys/pref_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4), () {
      // getUserCredentials(context);
      // pushReplacement(context, const SignInScreen());
    });
    super.initState();
  }

  void getUserCredentials(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString(PrefKey.authorization);

    if (token != null && token.isNotEmpty) {
      // pushReplacement(context, BottomNavView());
    } else {
      // pushReplacement(context, const SignInScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.appColor,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color.fromARGB(255, 234, 188, 183),   
              Color.fromARGB(255, 243, 217, 214),   // Top color
              // Top color
              Color(0xCCD4E9EA), // Bottom color
            ],
          ),
        ),
        child: Center(
          child: TweenAnimationBuilder(
            tween: Tween<double>(
              begin: 50.0,
              end: 500.0,
            ),
            duration: const Duration(seconds: 3),
            curve: Curves.easeInToLinear,
            builder: (context, val, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    height: 100,
                    child: Image.asset("assets/images/hrm_logo.png",),
                  ),
                  AppText.appText("End-to-end Digital Solutions")
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
