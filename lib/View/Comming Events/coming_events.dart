import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:h_r_m/Utils/resources/res/app_theme.dart';
import 'package:h_r_m/Utils/widgets/others/app_text.dart';
import 'package:table_calendar/table_calendar.dart';

class CommingEventsScreen extends StatefulWidget {
  const CommingEventsScreen({super.key});

  @override
  State<CommingEventsScreen> createState() => _CommingEventsScreenState();
}

class _CommingEventsScreenState extends State<CommingEventsScreen> {
  final String longText =
      "Define the problem or question that the brainstorming session will aim to address. The question should be clear and concise.";
  bool isExpanded = false;
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
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                  "10:00-13:00",
                                  textColor: const Color(0xff8F9BB3),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: AppText.appText(
                                "Meeting With Sir Farhan",
                                textColor: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            ExpandableText(
                              longText,
                              expandText: 'View More',
                              collapseText: 'View Less',
                              maxLines: 2, // Number of lines to show initially
                              expanded: isExpanded,
                              linkColor: Colors.blue, // Customize link color
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
}
