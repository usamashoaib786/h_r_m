import 'package:flutter/material.dart';
import 'package:h_r_m/Constants/app_logger.dart';
import 'package:h_r_m/Utils/resources/res/app_theme.dart';
import 'package:h_r_m/Utils/utils.dart';
import 'package:h_r_m/Utils/widgets/others/app_button.dart';
import 'package:h_r_m/Utils/widgets/others/app_text.dart';
import 'package:h_r_m/View/Auth/sign_in_screen.dart';
import 'package:h_r_m/config/app_urls.dart';
import 'package:h_r_m/config/dio/app_dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomPopUp extends StatefulWidget {
  const CustomPopUp({
    super.key,
  });

  @override
  State<CustomPopUp> createState() => _CustomPopUpState();
}

class _CustomPopUpState extends State<CustomPopUp> {
  bool _isLoading = false;
  late AppDio dio;
  AppLogger logger = AppLogger();
  @override
  void initState() {
    dio = AppDio(context);
    logger.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        titlePadding: const EdgeInsets.all(0),
        shadowColor: Colors.blue,
        title: Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.appText('Logout',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    textColor: Colors.black),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: AppText.appText('Are you sure you want to logout?',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      textColor: Colors.black),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AppButton.appButton("Cancel", onTap: () {
                      Navigator.pop(context);
                    },
                        height: 30,
                        border: false,
                        width: 89,
                        backgroundColor: Color(0xffBCACAC),
                        textColor: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                    AppButton.appButton("Logout", onTap: () {
                      logOut();
                    },
                        height: 30,
                        width: 89,
                        border: false,
                        backgroundColor: AppTheme.appColor,
                        textColor: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ],
                )
              ],
            ),
          ),
        ));
  }

  void logOut() async {
    setState(() {
      _isLoading = true;
    });
    var response;
    int responseCode200 = 200; // For successful request.
    int responseCode400 = 400; // For Bad Request.
    int responseCode401 = 401; // For Unauthorized access.
    int responseCode404 = 404; // For For data not found
    int responseCode422 = 422; // For For data not found

    int responseCode500 = 500; // Internal server error.

    try {
      response = await dio.get(path: AppUrls.logOut);
      var responseData = response.data;
      if (response.statusCode == responseCode400) {
        showSnackBar(context, "${responseData["message"]}");
        setState(() {
          _isLoading = false;
        });
      } else if (response.statusCode == responseCode401) {
        showSnackBar(context, "${responseData["message"]}");
        setState(() {
          _isLoading = false;
        });
      } else if (response.statusCode == responseCode404) {
        showSnackBar(context, "${responseData["message"]}");
        setState(() {
          _isLoading = false;
        });
      } else if (response.statusCode == responseCode500) {
        showSnackBar(context, "${responseData["message"]}");
        setState(() {
          _isLoading = false;
        });
      } else if (response.statusCode == responseCode422) {
        setState(() {
          _isLoading = false;
        });
      } else if (response.statusCode == responseCode200) {
        if (responseData["status"] == false) {
          showSnackBar(context, "${responseData["message"]}");
          setState(() {
            _isLoading = false;
          });

          return;
        } else {
          showSnackBar(context, "${responseData["message"]}");
          setState(() {
            _isLoading = false;
          });
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.clear();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const SignInScreen(),
              ),
              (route) => false);
        }
      }
    } catch (e) {
      print("Something went Wrong ${e}");
      showSnackBar(context, "Something went Wrong.");
      setState(() {
        _isLoading = false;
      });
    }
  }
}
