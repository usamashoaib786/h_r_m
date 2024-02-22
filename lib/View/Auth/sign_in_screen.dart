import 'package:flutter/material.dart';
import 'package:hrm_project/Utils/resources/res/app_theme.dart';
import 'package:hrm_project/Utils/widgets/others/app_button.dart';
import 'package:hrm_project/Utils/widgets/others/app_field.dart';
import 'package:hrm_project/Utils/widgets/others/app_text.dart';

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
              padding: const EdgeInsets.only(top: 35.0),
              child: SizedBox(
                height: screenHeight - 29,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        height: 51,
                        width: screenWidth,
                        decoration: BoxDecoration(
                            color: AppTheme.appColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50),
                            )),
                        child: Center(
                          child: AppText.appText(
                            'Attendance',
                            textColor: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                    Image.asset("assets/images/loginImg.png"),
                    SizedBox(
                      width: screenHeight,
                      height: 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText.appText(
                            'Sign In Now',
                            textAlign: TextAlign.center,
                            textColor: AppTheme.appColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.24,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 7,
                                width: 7,
                                color: AppTheme.appColor,
                              ),
                              Container(
                                height: 1,
                                width: 77,
                                color: AppTheme.appColor,
                              ),
                              Container(
                                height: 7,
                                width: 7,
                                color: AppTheme.appColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 380,
                      width: screenWidth,
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 40.0),
                            child: Container(
                              width: screenWidth,
                              decoration: BoxDecoration(
                                  color: AppTheme.appColor,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      topRight: Radius.circular(50))),
                            ),
                          ),
                          const Align(
                              alignment: Alignment.topCenter,
                              child: Image(
                                  image: AssetImage(
                                      "assets/images/loginPerson.png"))),
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 40.0),
                                child: SizedBox(
                                  height: 250,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CustomAppFormField(
                                        prefixIcon: const Icon(
                                          Icons.email,
                                          size: 25,
                                          color: Color(0xff382E2B),
                                        ),
                                        texthint: "Employee Email",
                                        controller: _emailController,
                                      ),
                                      CustomAppFormField(
                                        prefixIcon: const Icon(
                                          Icons.lock,
                                          size: 25,
                                          color: Color(0xff382E2B),
                                        ),
                                        texthint: "Password",
                                        controller: _passwordController,
                                      ),
                                      AppButton.appButton("LOGIN",
                                          textColor: Colors.black,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w700,
                                          height: 50,
                                          width: 250,
                                          backgroundColor: AppTheme.white)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
