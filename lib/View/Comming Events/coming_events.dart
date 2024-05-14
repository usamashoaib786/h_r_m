import 'package:dio/dio.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:h_r_m/Constants/app_logger.dart';
import 'package:h_r_m/Utils/resources/res/app_theme.dart';
import 'package:h_r_m/Utils/widgets/others/app_text.dart';
import 'package:h_r_m/config/app_urls.dart';
import 'package:h_r_m/config/dio/app_dio.dart';
import 'package:table_calendar/table_calendar.dart';

class CommingEventsScreen extends StatefulWidget {
  const CommingEventsScreen({super.key});

  @override
  State<CommingEventsScreen> createState() => _CommingEventsScreenState();
}

class _CommingEventsScreenState extends State<CommingEventsScreen> {
  bool isExpanded = false;
  bool _isLoading = false;
  late AppDio dio;
  var eventsDetail;
  AppLogger logger = AppLogger();
  @override
  void initState() {
    dio = AppDio(context);
    logger.init();
    getEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppTheme.white),
        backgroundColor: AppTheme.appColor,
        title: AppText.appText(
          "Comming Events",
          textColor: AppTheme.white,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: Column(
          children: [
            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TableCalendar(
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: DateTime.now(),
                  weekNumbersVisible: false,
                  rowHeight: 40,
                  daysOfWeekHeight: 40,
                  calendarStyle: CalendarStyle(
                    outsideDaysVisible: false,
                    todayTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.whiteColor),
                    todayDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppTheme.appColor,
                        shape: BoxShape.rectangle),
                  ),
                  daysOfWeekStyle: const DaysOfWeekStyle(
                      weekdayStyle: TextStyle(
                          color: Color(0xff8F9BB3),
                          fontSize: 13,
                          fontWeight: FontWeight.w900),
                      weekendStyle: TextStyle(
                          color: Color(0xff8F9BB3),
                          fontSize: 13,
                          fontWeight: FontWeight.w900)),
                  headerStyle: const HeaderStyle(
                      titleTextStyle:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      formatButtonShowsNext: false,
                      formatButtonVisible: false,
                      titleCentered: true,
                      leftChevronPadding: EdgeInsets.all(0.0),
                      rightChevronPadding: EdgeInsets.all(0.0),
                      leftChevronMargin: EdgeInsets.all(0.0),
                      rightChevronMargin: EdgeInsets.all(0.0),
                      headerPadding: EdgeInsets.symmetric(vertical: 15)),
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
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: eventsDetail.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 8,
                                        width: 8,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppTheme.appColor),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Container(
                                              height: 8,
                                              width: 8,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: AppTheme.white)),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      AppText.appText(
                                        "${eventsDetail[index]["start_date"]} to ${eventsDetail[index]["start_date"]}",
                                        textColor: const Color(0xff8F9BB3),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: AppText.appText(
                                      "${eventsDetail[index]["personal_event"]}",
                                      textColor: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  ExpandableText(
                                    "${eventsDetail[index]["personal_event_description"]}",
                                    expandText: 'View More',
                                    collapseText: 'View Less',
                                    maxLines:
                                        2, // Number of lines to show initially
                                    expanded: isExpanded,
                                    linkColor:
                                        Colors.blue, // Customize link color
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff8F9BB3)),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  if (index <= 1)
                                    Container(
                                      height: 1,
                                      width: MediaQuery.of(context).size.width,
                                      color: const Color(0xff9C9C9C),
                                    ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  )
          ],
        ),
      ),
    );
  }

  void getEvents() async {
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
      response = await dio.get(path: AppUrls.getEvents);
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
            eventsDetail = responseData["events"];
          });
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
