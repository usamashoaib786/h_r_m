import 'dart:ui'; // For BackdropFilter
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:h_r_m/Constants/app_logger.dart';
import 'package:h_r_m/Utils/resources/res/app_theme.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:h_r_m/Utils/widgets/others/app_text.dart';
import 'package:h_r_m/config/app_urls.dart';
import 'package:h_r_m/config/dio/app_dio.dart';
import 'package:intl/intl.dart';

class MarkAttendenceScreen extends StatefulWidget {
  final userId;
  const MarkAttendenceScreen({super.key, this.userId});

  @override
  State<MarkAttendenceScreen> createState() => _MarkAttendenceScreenState();
}

class _MarkAttendenceScreenState extends State<MarkAttendenceScreen> {
  bool home = false;
  bool office = true;
  bool checkIn = true;

  String _currentTime = '';
  String _amPm = '';
  String _date = '';
  bool isLoading = false;
  var checkOffice = 0;
  String? formattedTime;
  String? formattedDate;
  var lat;
  var long;
  late AppDio dio;
  AppLogger logger = AppLogger();

  @override
  void initState() {
    dio = AppDio(context);
    logger.init();
    _updateTime();
    getUserLocation();
    super.initState();
  }

  void _updateTime() {
    setState(() {
      var now = DateTime.now();
      _currentTime = DateFormat('h:mm').format(now);
      formattedTime = DateFormat('HH:mm:ss').format(now);
      formattedDate = DateFormat('yyyy-MM-dd').format(now);
      _date = DateFormat('EEEE, MMM dd, yyyy').format(now);
      _amPm = DateFormat('a').format(now);
    });
  }

  Future<void> getUserLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return;
    }
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      lat = position.latitude;
      long = position.longitude;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppTheme.white),
        backgroundColor: AppTheme.appColor,
        title: AppText.appText(
          "Mark Attendance",
          textColor: AppTheme.white,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: Stack(
        children: [
          // Main content
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildAttendanceSwitch(),
                buildTimeDisplay(),
                buildCheckInCheckOutButtons(),
              ],
            ),
          ),
          // Blur background and loader
          if (isLoading)
            Stack(
              children: [
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    color: Colors.black.withOpacity(0.2),
                  ),
                ),
                Center(
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20)
                      ,color: AppTheme.white
                    ),
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(AppTheme.green),
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget buildAttendanceSwitch() {
    return Container(
      height: 53,
      width: 230,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        color: AppTheme.appColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  home = !home;
                  office = !home;
                  checkOffice = 0;
                });
              },
              child: Container(
                height: 40,
                width: 107,
                decoration: BoxDecoration(
                  color: office == true
                      ? const Color(0xffffffffe5)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset("assets/images/office.png"),
                      AppText.appText("Office",
                          textColor:
                              office == true ? Colors.black : AppTheme.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  home = !home;
                  office = !home;
                  checkOffice = 1;
                });
              },
              child: Container(
                height: 40,
                width: 107,
                decoration: BoxDecoration(
                  color: home == true
                      ? const Color(0xffffffffe5)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.home,
                          color: home == true ? Colors.black : AppTheme.white),
                      AppText.appText("Home",
                          textColor:
                              home == true ? Colors.black : AppTheme.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTimeDisplay() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AppText.appText(_currentTime,
                    fontSize: 48, fontWeight: FontWeight.w400),
                const SizedBox(width: 10),
                AppText.appText(_amPm,
                    fontSize: 20, fontWeight: FontWeight.w400),
              ],
            ),
            AppText.appText(_date, fontSize: 20, fontWeight: FontWeight.w400),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                var now = DateTime.now();
                String dayOfWeek = DateFormat('EEEE').format(now);
                if (dayOfWeek == 'Saturday' || dayOfWeek == 'Sunday') {
                  Fluttertoast.showToast(
                      msg:
                          "Attendance is not marked because the office is off today");
                } else {
                  markAttendence();
                }
              },
              child: Image.asset(
                "assets/images/finger.png",
                height: 180,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildCheckInCheckOutButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        customButton(
            txt: "Check In",
            color: checkIn == true ? AppTheme.appColor : AppTheme.green,
            ontap: () {
              setState(() {
                checkIn = true;
              });
            }),
        const SizedBox(width: 20),
        customButton(
            txt: "Check Out",
            color: checkIn == false ? AppTheme.appColor : AppTheme.green,
            ontap: () {
              setState(() {
                checkIn = false;
              });
            }),
      ],
    );
  }

  Widget customButton({color, txt, ontap}) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 35,
        width: 135,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18), color: color),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/clock.png",
                height: 14,
              ),
              const SizedBox(width: 10),
              AppText.appText("$txt",
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  textColor: AppTheme.whiteColor)
            ],
          ),
        ),
      ),
    );
  }

  void markAttendence() async {
    setState(() {
      isLoading = true;
    });
    Response response;
    int responseCode200 = 200; // For successful request.

    Map<String, dynamic> params = {
      "user_id": widget.userId,
      "attendance_date": formattedDate,
      "attendance_status": 1,
      "leave_category_id": 0,
      "work_from_home": checkOffice,
      "check_in": formattedTime,
      "check_out": formattedTime,
      "latitude": lat,
      "longitude": long,
    };

    // Modify params based on check-in or check-out status
    if (checkIn == true) {
      if (home == true) {
        params.remove("latitude");
        params.remove("check_out");
        params.remove("longitude");
      } else {
        params.remove("check_out");
      }
    } else {
      if (home == true) {
        params.remove("latitude");
        params.remove("check_in");
        params.remove("longitude");
      } else {
        params.remove("check_in");
      }
    }

    try {
      response = await dio.post(path: AppUrls.markAttendence, data: params);
      var responseData = response.data;
      if (response.statusCode == responseCode200) {
        if (responseData["status"] == false) {
          Fluttertoast.showToast(msg: "${responseData["message"]}");
          setState(() {
            isLoading = false;
          });
        } else {
          Fluttertoast.showToast(msg: "${responseData["message"]}");
          setState(() {
            isLoading = false;
          });
        }
      } else {
        Fluttertoast.showToast(msg: "${responseData["message"]}");
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Something went wrong.");
      setState(() {
        isLoading = false;
      });
    }
  }
}
