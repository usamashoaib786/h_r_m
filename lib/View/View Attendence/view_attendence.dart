import 'package:flutter/material.dart';
import 'package:h_r_m/Constants/app_logger.dart';
import 'package:h_r_m/Utils/resources/res/app_theme.dart';
import 'package:h_r_m/Utils/utils.dart';
import 'package:h_r_m/Utils/widgets/others/app_text.dart';
import 'package:h_r_m/config/app_urls.dart';
import 'package:h_r_m/config/dio/app_dio.dart';
import 'package:intl/intl.dart';

class ViewAttendence extends StatefulWidget {
  final userId;
  const ViewAttendence({super.key, this.userId});

  @override
  State<ViewAttendence> createState() => _ViewAttendenceState();
}

class _ViewAttendenceState extends State<ViewAttendence> {
  bool _isLoading = false;
  late AppDio dio;
  AppLogger logger = AppLogger();
  String? formattedDate;
  String? _date;
  var attendenceData;
  @override
  void initState() {
    dio = AppDio(context);
    logger.init();
    getDate();
    getAttendenceReport();
    super.initState();
  }

  void getDate() {
    setState(() {
      var now = DateTime.now();
      formattedDate = DateFormat('yyyy-MM-dd').format(now);
      _date = DateFormat('MMMM yyyy').format(now);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppTheme.white),
        backgroundColor: AppTheme.appColor,
        title: AppText.appText(
          "View Attendence",
          textColor: AppTheme.white,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Card(
                elevation: 10,
                child: Container(
                  height: 43,
                  width: 230,
                  decoration: const BoxDecoration(color: Color(0xffF6F3F3)),
                  child: Center(
                    child: AppText.appText(
                      "$_date",
                      textColor: AppTheme.appColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            CustomTable(
              data: attendenceData,
              loading: _isLoading,
            )
          ],
        ),
      ),
    );
  }

  void getAttendenceReport() async {
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
    Map<String, dynamic> params = {
      "user_id": widget.userId,
      "attendance_month": formattedDate,
    };
    try {
      response = await dio.post(path: AppUrls.getAttendences, data: params);
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
            attendenceData = responseData["attendances"];
            _isLoading = false;
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

class CustomTable extends StatelessWidget {
  final data;
  final loading;
  const CustomTable({super.key, this.data, this.loading});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              headingContainer(txt: "Date", align: Alignment.center),
              headingContainer(txt: "Time in", align: Alignment.center),
              headingContainer(txt: "Time out", align: Alignment.center),
              headingContainer(txt: "Status", align: Alignment.center),
            ],
          ),
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: const Color(0xff888888),
          ),
          if (loading == true)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 70.0),
              child: CircularProgressIndicator(
                color: AppTheme.appColor,
              ),
            ),
          if (loading == false)
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Container(
                          height: 54,
                          decoration: BoxDecoration(
                              color: const Color(0xffF6F3F3),
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 41,
                                width: 65,
                                alignment: Alignment.center,
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Container(
                                    height: 42,
                                    width: 42,
                                    decoration: BoxDecoration(
                                        color: const Color(0xffFFFFFF),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 1, horizontal: 10),
                                      child: AppText.appText(
                                          convertDateFormat(
                                              "${data[index]["attendance_date"]}"),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                          textAlign: TextAlign.center),
                                    ),
                                  ),
                                ),
                              ),
                              headingContainer(
                                  txt: "${data[index]["check_in"]}",
                                  weigth: FontWeight.w500,
                                  align: Alignment.center),
                              headingContainer(
                                  txt: "${data[index]["check_out"]}",
                                  weigth: FontWeight.w500,
                                  align: Alignment.center),
                              SizedBox(
                                height: 40,
                                width: 60,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: Container(
                                    height: 37,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(11),
                                        color: AppTheme.green),
                                    child: Center(
                                        child: AppText.appText(
                                            data[index]["attendance_status"] ==
                                                    "1"
                                                ? "P"
                                                : "A",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            textColor: AppTheme.whiteColor)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            )
        ],
      ),
    );
  }

  String convertDateFormat(String dateString) {
    DateTime date = DateTime.parse(dateString);
    String formattedDate = DateFormat("dd EE").format(date);
    return formattedDate;
  }

  Widget headingContainer({
    txt,
    align,
    weigth,
    double? fontSize,
  }) {
    return Container(
      // color: Colors.amber,
      alignment: align == null ? Alignment.centerLeft : align,
      height: 40,
      width: 65,
      child: AppText.appText("$txt",
          fontSize: fontSize == null ? 12 : fontSize,
          fontWeight: weigth == null ? FontWeight.w600 : weigth,
          textColor: Colors.black),
    );
  }
}
