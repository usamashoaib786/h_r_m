import 'package:flutter/material.dart';
import 'package:h_r_m/Utils/resources/res/app_theme.dart';
import 'package:h_r_m/Utils/utils.dart';
import 'package:h_r_m/Utils/widgets/others/app_button.dart';
import 'package:h_r_m/Utils/widgets/others/app_field.dart';
import 'package:h_r_m/Utils/widgets/others/app_text.dart';
import 'package:h_r_m/View/Bottom%20Navigation%20bar/bottom_nav_view.dart';
import 'package:h_r_m/View/HomePAge/home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 50.0, left: 20, right: 20, bottom: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText.appText(
                    'Attendance',
                    textColor: AppTheme.appColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                  Image.asset(
                    "assets/images/loginImg.png",
                    height: 300,
                  ),
                  AppText.appText(
                    'Sign In Now',
                    textAlign: TextAlign.center,
                    textColor: AppTheme.appColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.24,
                  ),
                  SizedBox(
                    height: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomAppFormField(
                          prefixIcon: Icon(
                            Icons.email,
                            size: 25,
                            color: AppTheme.appColor,
                          ),
                          texthint: "Employee Email",
                          controller: _emailController,
                        ),
                        CustomAppFormField(
                          prefixIcon: Icon(
                            Icons.lock,
                            size: 25,
                            color: AppTheme.appColor,
                          ),
                          texthint: "Password",
                          controller: _passwordController,
                        ),
                        AppButton.appButton("LOGIN", onTap: () {
                          push(context, BottomNavView());
                        },
                            textColor: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            height: 50,
                            radius: 20.0,
                            width: 250,
                            backgroundColor: AppTheme.appColor)
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
