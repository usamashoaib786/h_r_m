import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:h_r_m/Constants/app_logger.dart';
import 'package:h_r_m/Utils/resources/res/app_theme.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:h_r_m/Utils/widgets/others/app_button.dart';
import 'package:h_r_m/Utils/widgets/others/app_text.dart';
import 'package:h_r_m/config/app_urls.dart';
import 'package:h_r_m/config/dio/app_dio.dart';

// ignore: camel_case_types
class leaveQuotaScreen extends StatefulWidget {
  final userId;
  const leaveQuotaScreen({super.key, this.userId});

  @override
  State<leaveQuotaScreen> createState() => _leaveQuotaScreenState();
}

// ignore: camel_case_types
class _leaveQuotaScreenState extends State<leaveQuotaScreen> {
  bool _isLoading = false;
  late AppDio dio;
  AppLogger logger = AppLogger();
  var leaveApplication;
  var allowedLeave;
  var remainLeave;
  @override
  void initState() {
    dio = AppDio(context);
    logger.init();
    getLeaves();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppTheme.white),
        backgroundColor: AppTheme.appColor,
        title: AppText.appText(
          "Leave Quota",
          textColor: AppTheme.white,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 125,
                width: screenWidth,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xffF6F3F3)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText.appText("Annual Leave Quota",
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          textColor: AppTheme.appColor),
                      Container(
                        height: 33,
                        width: screenWidth,
                        color: AppTheme.whiteColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              containerLeave(txt: "Paid Allowed", width: 79.0),
                              containerLeave(txt: "Annual", width: 44.0),
                              containerLeave(txt: "Casual", width: 44.0),
                              containerLeave(txt: "Sick", width: 25.0),
                              containerLeave(txt: "Remaining", width: 67.0),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 33,
                        width: screenWidth,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              containerLeave(txt: "$allowedLeave", width: 79.0),
                              containerLeave(txt: "15", width: 44.0),
                              containerLeave(txt: "10", width: 44.0),
                              containerLeave(txt: "08", width: 25.0),
                              containerLeave(txt: "$remainLeave", width: 67.0),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              _isLoading == true
                  ? Center(
                      child: CircularProgressIndicator(
                      color: AppTheme.appColor,
                    ))
                  : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: leaveApplication.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Container(
                            width: screenWidth,
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
                                              "${leaveApplication[index]["created_by"]["name"]}"
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
                                              "${leaveApplication[index]["created_by"]["name"]}",
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              textColor:
                                                  const Color(0xff0451E5)),
                                          AppText.appText(
                                              "From: ${leaveApplication[index]["start_date"]} to ${leaveApplication[index]["end_date"]}",
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
                                      "${leaveApplication[index]["leave_category"]["leave_category"]}",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      textColor: AppTheme.appColor),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: screenWidth,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppTheme.whiteColor),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AppText.appText("Reason:    ",
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              textColor:
                                                  const Color(0xff979696)),
                                          SizedBox(
                                            width: screenWidth * 0.6,
                                            child: AppText.appText(
                                                "${leaveApplication[index]["reason"]}",
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
                                  AppButton.appButton(
                                      leaveApplication[index]
                                                      ["publication_status"] ==
                                                  "0" ||
                                              leaveApplication[index]
                                                      ["publication_status"] ==
                                                  "5"
                                          ? "Pending"
                                          : leaveApplication[index]
                                                      ["publication_status"] ==
                                                  "1"
                                              ? "Accepted By HOD"
                                              : leaveApplication[index][
                                                          "publication_status"] ==
                                                      "2"
                                                  ? "Accepted By HR"
                                                  : leaveApplication[index][
                                                              "publication_status"] ==
                                                          "3"
                                                      ? "Rejected By HR"
                                                      : leaveApplication[index][
                                                                  "publication_status"] ==
                                                              "4"
                                                          ? "Rejected By HOD"
                                                          : leaveApplication[
                                                                          index]
                                                                      [
                                                                      "publication_status"] ==
                                                                  "6"
                                                              ? "Accepted By CEO"
                                                              : "Rejected By CEO",
                                      radius: 16.0,
                                      backgroundColor: AppTheme.appColor,
                                      textColor: AppTheme.whiteColor,
                                      height: 35)
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
            ],
          ),
        ),
      ),
    );
  }

  Widget containerLeave({txt, width}) {
    return Container(
      alignment: Alignment.center,
      width: width,
      child: AppText.appText("$txt",
          fontSize: 12, fontWeight: FontWeight.w500, textColor: Colors.black),
    );
  }

  void getLeaves() async {
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

    try {
      response = await dio.get(path: AppUrls.getLeavesQuota);
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
          setState(() {
            _isLoading = false;
            leaveApplication = responseData["leave_applications"];
            allowedLeave = responseData["allowedLeaves"];
            remainLeave = responseData["remainingLeaves"];
          });
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Something went Wrong.");
      setState(() {
        _isLoading = false;
      });
    }
  }
}
