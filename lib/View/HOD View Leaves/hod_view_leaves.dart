import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:h_r_m/Constants/app_logger.dart';
import 'package:h_r_m/Utils/resources/res/app_theme.dart';
import 'package:h_r_m/Utils/widgets/others/app_button.dart';
import 'package:h_r_m/Utils/widgets/others/app_text.dart';
import 'package:h_r_m/config/app_urls.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:h_r_m/config/dio/app_dio.dart';
import 'package:h_r_m/config/keys/pref_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HodViewLeaves extends StatefulWidget {
  const HodViewLeaves({super.key});

  @override
  State<HodViewLeaves> createState() => _HodViewLeavesState();
}

class _HodViewLeavesState extends State<HodViewLeaves> {
  bool isLoading = false;
  late AppDio dio;
  AppLogger logger = AppLogger();
  var leaveRequest;
  var userType;
  @override
  void initState() {
    dio = AppDio(context);
    logger.init();
    getUserDetail();
    super.initState();
  }

  getUserDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userType = prefs.getString(PrefKey.userType);
    if (userType == "3") {
      getLeavesRequest(hr: false, ceo: false);
    } else if (userType == "1") {
      getLeavesRequest(hr: true, ceo: false);
    } else if (userType == "5") {
      getLeavesRequest(ceo: true, hr: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppTheme.white),
        backgroundColor: AppTheme.appColor,
        title: AppText.appText(
          "Leaves Request",
          textColor: AppTheme.white,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: leaveRequest == null
            ? Center(
                child: CircularProgressIndicator(
                  color: AppTheme.appColor,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: leaveRequest.length,
                        itemBuilder: (context, index) {
                          var data = leaveRequest[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: const Color(0xffF6F3F3)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 42,
                                          width: 42,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppTheme.appColor,
                                          ),
                                          child: Center(
                                            child: AppText.appText(
                                                "${data["created_by"]["name"]}"
                                                    .substring(0, 1),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                textColor: AppTheme.whiteColor),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AppText.appText(
                                                "${data["created_by"]["name"]}",
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                textColor:
                                                    const Color(0xff0451E5)),
                                            AppText.appText(
                                                "From: ${data["start_date"]} to ${data["end_date"]}",
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                textColor:
                                                    const Color(0xff1F1F1F)),
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    AppText.appText(
                                        "${data["leave_category"]["leave_category"]}",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        textColor: AppTheme.appColor),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: AppTheme.whiteColor),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AppText.appText("Reason:   ",
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                textColor:
                                                    const Color(0xff979696)),
                                            SizedBox(
                                              width: screenWidth - 155,
                                              child: AppText.appText(
                                                  "${data["reason"]} ",
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  textColor: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        AppButton.appButton("Approved",
                                            onTap: () {
                                          if (userType == "1") {
                                            aprovedByHod(
                                                id: "${data["id"]}",
                                                hr: true,
                                                ceo: false);
                                          } else if (userType == "5") {
                                            aprovedByHod(
                                                id: "${data["id"]}",
                                                hr: false,
                                                ceo: true);
                                          } else if (userType == "3") {
                                            aprovedByHod(
                                                id: "${data["id"]}",
                                                hr: false,
                                                ceo: false);
                                          }
                                        },
                                            width: screenWidth * 0.3,
                                            radius: 16.0,
                                            border: true,
                                            borderColor: AppTheme.green,
                                            backgroundColor: AppTheme.white,
                                            textColor: Colors.black,
                                            height: 35),
                                        AppButton.appButton("Reject",
                                            onTap: () {
                                          if (userType == "1") {
                                            rejectByHod(
                                                id: "${data["id"]}",
                                                hr: true,
                                                ceo: false);
                                          } else if (userType == "5") {
                                            rejectByHod(
                                                id: "${data["id"]}",
                                                hr: false,
                                                ceo: true);
                                          } else if (userType == "3") {
                                            rejectByHod(
                                                id: "${data["id"]}",
                                                hr: false,
                                                ceo: false);
                                          }
                                        },
                                            width: screenWidth * 0.3,
                                            radius: 16.0,
                                            border: true,
                                            backgroundColor: AppTheme.white,
                                            textColor: Colors.black,
                                            height: 35),
                                      ],
                                    )
                                  ],
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

  void getLeavesRequest({hr, ceo}) async {
    print("jbfkfkb$ceo");
    setState(() {
      isLoading = true;
    });
    Response response;
    int responseCode200 = 200; // For successful request.
    int responseCode400 = 400; // For Bad Request.
    int responseCode401 = 401; // For Unauthorized access.
    int responseCode404 = 404; // For For data not found
    int responseCode422 = 422; // For For data not found

    int responseCode500 = 500; // Internal server error.

    try {
      hr == true
          ? response = await dio.get(path: AppUrls.getHREmployeeLeaveRequests)
          : ceo == true
              ? response = await dio.get(path: AppUrls.getCeoLeaveRequests)
              : response =
                  await dio.get(path: AppUrls.getEmployeeLeaveRequests);
      var responseData = response.data;
      if (response.statusCode == responseCode400) {
        Fluttertoast.showToast(msg: "${responseData["message"]}");
        setState(() {
          isLoading = false;
        });
      } else if (response.statusCode == responseCode401) {
        Fluttertoast.showToast(msg: "${responseData["message"]}");
        setState(() {
          isLoading = false;
        });
      } else if (response.statusCode == responseCode404) {
        Fluttertoast.showToast(msg: "${responseData["message"]}");
        setState(() {
          isLoading = false;
        });
      } else if (response.statusCode == responseCode500) {
        Fluttertoast.showToast(msg: "${responseData["message"]}");
        setState(() {
          isLoading = false;
        });
      } else if (response.statusCode == responseCode422) {
        setState(() {
          isLoading = false;
        });
      } else if (response.statusCode == responseCode200) {
        if (responseData["status"] == false) {
          Fluttertoast.showToast(msg: "${responseData["message"]}");
          setState(() {
            isLoading = false;
          });

          return;
        } else {
          setState(() {
            isLoading = false;
            leaveRequest = hr == true
                ? responseData["leavesApprovedByHod"]
                : ceo == true
                    ? responseData["leaveApplication"]
                    : responseData["leave_applications"];
                    print("mlvrmvlrvlm${leaveRequest.length}");
          });
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Something went Wrong.");
      setState(() {
        isLoading = false;
      });
    }
  }

  void aprovedByHod({id, hr, ceo}) async {
    setState(() {
      isLoading = true;
    });
    Response response;
    int responseCode200 = 200; // For successful request.
    int responseCode400 = 400; // For Bad Request.
    int responseCode401 = 401; // For Unauthorized access.
    int responseCode404 = 404; // For For data not found
    int responseCode422 = 422; // For For data not found

    int responseCode500 = 500; // Internal server error.
    Map<String, dynamic> params = {
      "id": id,
    };
    try {
      hr == true
          ? response = await dio.post(path: AppUrls.approvedByHr, data: params)
          : ceo == true
              ? response =
                  await dio.post(path: AppUrls.approvedByCeo, data: params)
              : response =
                  await dio.post(path: AppUrls.approvedByHod, data: params);
      var responseData = response.data;
      if (response.statusCode == responseCode400) {
        Fluttertoast.showToast(msg: "${responseData["message"]}");
        setState(() {
          isLoading = false;
        });
      } else if (response.statusCode == responseCode401) {
        Fluttertoast.showToast(msg: "${responseData["message"]}");
        setState(() {
          isLoading = false;
        });
      } else if (response.statusCode == responseCode404) {
        Fluttertoast.showToast(msg: "${responseData["message"]}");
        setState(() {
          isLoading = false;
        });
      } else if (response.statusCode == responseCode500) {
        Fluttertoast.showToast(msg: "${responseData["message"]}");
        setState(() {
          isLoading = false;
        });
      } else if (response.statusCode == responseCode422) {
        setState(() {
          isLoading = false;
        });
      } else if (response.statusCode == responseCode200) {
        if (responseData["status"] == false) {
          Fluttertoast.showToast(msg: "${responseData["message"]}");
          setState(() {
            isLoading = false;
          });

          return;
        } else {
          setState(() {
            isLoading = false;
            hr == false
                ? getLeavesRequest(hr: false)
                : getLeavesRequest(hr: true);
          });
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Something went Wrong.");
      setState(() {
        isLoading = false;
      });
    }
  }

  void rejectByHod({id, hr, ceo}) async {
    setState(() {
      isLoading = true;
    });
    Response response;
    int responseCode200 = 200; // For successful request.
    int responseCode400 = 400; // For Bad Request.
    int responseCode401 = 401; // For Unauthorized access.
    int responseCode404 = 404; // For For data not found
    int responseCode422 = 422; // For For data not found

    int responseCode500 = 500; // Internal server error.
    Map<String, dynamic> params = {
      "id": id,
    };
    try {
      hr == true
          ? response = await dio.post(path: AppUrls.rejectByHr, data: params)
          : ceo == true
              ? response =
                  await dio.post(path: AppUrls.rejectByCeo, data: params)
              : response =
                  await dio.post(path: AppUrls.rejectByHod, data: params);
      var responseData = response.data;
      if (response.statusCode == responseCode400) {
        Fluttertoast.showToast(msg: "${responseData["message"]}");
        setState(() {
          isLoading = false;
        });
      } else if (response.statusCode == responseCode401) {
        Fluttertoast.showToast(msg: "${responseData["message"]}");
        setState(() {
          isLoading = false;
        });
      } else if (response.statusCode == responseCode404) {
        Fluttertoast.showToast(msg: "${responseData["message"]}");
        setState(() {
          isLoading = false;
        });
      } else if (response.statusCode == responseCode500) {
        Fluttertoast.showToast(msg: "${responseData["message"]}");
        setState(() {
          isLoading = false;
        });
      } else if (response.statusCode == responseCode422) {
        setState(() {
          isLoading = false;
        });
      } else if (response.statusCode == responseCode200) {
        if (responseData["status"] == false) {
          Fluttertoast.showToast(msg: "${responseData["message"]}");
          setState(() {
            isLoading = false;
          });

          return;
        } else {
          setState(() {
            isLoading = false;
            hr == false
                ? getLeavesRequest(hr: false)
                : getLeavesRequest(hr: true);
          });
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Something went Wrong.");
      setState(() {
        isLoading = false;
      });
    }
  }
}
