import 'dart:math';

import 'package:flutter/material.dart';
import 'package:h_r_m/Constants/app_logger.dart';
import 'package:h_r_m/Utils/resources/res/app_theme.dart';
import 'package:h_r_m/Utils/utils.dart';
import 'package:h_r_m/Utils/widgets/others/app_text.dart';
import 'package:h_r_m/config/app_urls.dart';
import 'package:h_r_m/config/dio/app_dio.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  bool _isLoading = false;
  late AppDio dio;
  AppLogger logger = AppLogger();
  var employeeDetail;

  @override
  void initState() {
    dio = AppDio(context);
    logger.init();
    getEmployees();
    super.initState();
  }

  Color getRandomLightColor() {
    Random random = Random();
    // Generate random values for R, G, and B channels
    int r = 200 + random.nextInt(56); // Red channel (200-255)
    int g = 200 + random.nextInt(56); // Green channel (200-255)
    int b = 200 + random.nextInt(56); // Blue channel (200-255)
    return Color.fromRGBO(r, g, b, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppTheme.white),
        backgroundColor: AppTheme.appColor,
        title: AppText.appText(
          "Employees List",
          textColor: AppTheme.white,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: _isLoading == true
            ? Center(
                child: CircularProgressIndicator(
                  color: AppTheme.appColor,
                ),
              )
            : SingleChildScrollView(
              child: Column(
                  children: [
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                        itemCount: employeeDetail.length,
                        itemBuilder: (context, index) {
                          var data = employeeDetail[index];
                          return Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Card(
                              color: AppTheme.whiteColor,
                              elevation: 10,
                              child: Container(
                                height: 80,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: getRandomLightColor()),
                                        child: Center(
                                          child: AppText.appText(
                                              "${data["name"]}".substring(0, 1),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              textColor: Colors.black),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AppText.appText("${data["name"]}",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              textColor: Colors.black),
                                          AppText.appText(
                                              "${data["designation"]["designation"]}",
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              textColor: Colors.black),
                                          AppText.appText(
                                              "Employee id: ${data["employee_id"]}",
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              textColor: Colors.black),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
            ),
      ),
    );
  }

  void getEmployees() async {
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
      response = await dio.get(path: AppUrls.getHodEmployees);
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
          setState(() {
            _isLoading = false;
            employeeDetail = responseData["departEmployees"];
          });
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
