import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:h_r_m/Constants/app_logger.dart';
import 'package:h_r_m/Utils/resources/res/app_theme.dart';
import 'package:h_r_m/Utils/widgets/others/app_button.dart';
import 'package:h_r_m/Utils/widgets/others/app_field.dart';
import 'package:h_r_m/Utils/widgets/others/app_text.dart';
import 'package:h_r_m/View/Bottom%20Navigation%20bar/bottom_nav_view.dart';
import 'package:h_r_m/config/app_urls.dart';
import 'package:h_r_m/config/dio/app_dio.dart';
import 'package:h_r_m/config/keys/pref_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _deviceID;
  bool _isLoading = false;
  late AppDio dio;
  AppLogger logger = AppLogger();
  @override
  void initState() {
    dio = AppDio(context);
    logger.init();
    getId();
    super.initState();
  }

  getId() async {
    _deviceID = await _getDeviceID();
  }

  Future<String?> _getDeviceID() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return AndroidId().getId(); // unique ID on Android
    }
  }

  @override
  Widget build(BuildContext context) {
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
                        CustomAppPasswordfield(
                          prefixIcon: Icon(
                            Icons.lock,
                            size: 25,
                            color: AppTheme.appColor,
                          ),
                          texthint: "Password",
                          controller: _passwordController,
                        ),
                        _isLoading == true
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: AppTheme.appColor,
                                ),
                              )
                            : AppButton.appButton("LOGIN", onTap: () async {
                                var pref =
                                    await SharedPreferences.getInstance();

                                pref.clear();
                                print(PrefKey.authorization);
                                if (_emailController.text.isNotEmpty) {
                                  final emailPattern = RegExp(
                                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                  if (!emailPattern
                                      .hasMatch(_emailController.text)) {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Please enter a valid email address");
                                  } else {
                                    if (_passwordController.text.isNotEmpty) {
                                      signIn(context);
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Enter Password");
                                    }
                                  }
                                } else {
                                  Fluttertoast.showToast(msg: "Enter Email");
                                }
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

  void signIn(context) async {
    if (kDebugMode) {
      print("mlmlmf$_deviceID");
    }
    setState(() {
      _isLoading = true;
    });
    Response response;
    int responseCode200 = 200; // For successful request.
    int responseCode400 = 400; // For Bad Request.
    int responseCode401 = 401; // For Unauthorized access.
    int responseCode404 = 404; // For For data not found
    int responseCode422 = 422; // For For data not found

    int responseCode500 = 500; // Internal server error.
    Map<String, dynamic> params = {
      "email": _emailController.text,
      "password": _passwordController.text,
      "device_id": _deviceID,
    };
    try {
      response = await dio.post(path: AppUrls.logIn, data: params);
      var responseData = response.data;
      if (response.statusCode == responseCode400) {
        Fluttertoast.showToast(msg: "${responseData["message"]}");
        setState(() {
          _isLoading = false;
        });
      } else if (response.statusCode == responseCode401) {
        Fluttertoast.showToast(msg: "${responseData["message"]}");
        setState(() {
          _isLoading = false;
        });
      } else if (response.statusCode == responseCode404) {
        Fluttertoast.showToast(msg: "${responseData["message"]}");
        setState(() {
          _isLoading = false;
        });
      } else if (response.statusCode == responseCode500) {
        Fluttertoast.showToast(msg: "${responseData["message"]}");
        setState(() {
          _isLoading = false;
        });
      } else if (response.statusCode == responseCode422) {
        setState(() {
          _isLoading = false;
        });
      } else if (response.statusCode == responseCode200) {
        if (responseData["status"] == false) {
          Fluttertoast.showToast(msg: "${responseData["message"]}");
          setState(() {
            _isLoading = false;
          });

          return;
        } else {
          if (responseData["message"] != null) {
            Fluttertoast.showToast(msg: "${responseData["message"]}");
            setState(() {
              _isLoading = false;
            });
          }

          if (responseData["message"] != "Invalid email or password!") {
            setState(() {
              _isLoading = false;
            });
            var token = responseData["user"]["api_token"];
            var user = responseData["user"]["id"];
            var userName = responseData["user"]["name"];
            var userEmail = responseData["user"]["email"];
            var designation = responseData["designation_title"];
            var department = responseData["departments"];
            var userPhone = responseData["user"]["contact_no_one"];
            var userType = responseData["user"]["role"];
            var id = user.toString();
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString(PrefKey.authorization, token ?? '');
            prefs.setString(PrefKey.id, id);
            prefs.setString(PrefKey.userName, userName ?? '');
            prefs.setString(PrefKey.email, userEmail ?? '');
            prefs.setString(PrefKey.phone, userPhone ?? '');
            prefs.setString(PrefKey.designation, designation ?? '');
            prefs.setString(PrefKey.department, department ?? '');
            prefs.setString(PrefKey.userType, userType ?? '');

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const BottomNavView(),
                ),
                (route) => false);
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Something went Wrong $e");
      }
      Fluttertoast.showToast(msg: "Something went Wrong.");
      setState(() {
        _isLoading = false;
      });
    }
  }

}
