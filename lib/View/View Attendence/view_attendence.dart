import 'package:flutter/material.dart';
import 'package:h_r_m/Utils/resources/res/app_theme.dart';
import 'package:h_r_m/Utils/widgets/others/app_text.dart';

class ViewAttendence extends StatefulWidget {
  const ViewAttendence({super.key});

  @override
  State<ViewAttendence> createState() => _ViewAttendenceState();
}

class _ViewAttendenceState extends State<ViewAttendence> {
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
                      "January - 2024",
                      textColor: AppTheme.appColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            CustomTable()
          ],
        ),
      ),
    );
  }
}

class CustomTable extends StatelessWidget {
  // Sample data for the table rows
  final List<Map<String, dynamic>> tableData = [
    {
      'date': '2024-02-26',
      'timeIn': '09:00 AM',
      'timeOut': '05:00 PM',
      'status': 'Present'
    },
    {
      'date': '2024-02-27',
      'timeIn': '09:15 AM',
      'timeOut': '05:30 PM',
      'status': 'Present'
    },
    // Add more data as needed
  ];

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
          for (int i = 0; i < tableData.length; i++)
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                    height: 54,
                    decoration: BoxDecoration(
                        color: Color(0xffF6F3F3),
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
                                padding: const EdgeInsets.all(1.0),
                                child: AppText.appText("01 Thurs",
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    textAlign: TextAlign.center),
                              ),
                            ),
                          ),
                        ),
                        headingContainer(
                            txt: "${tableData[i]["timeIn"]}",
                            weigth: FontWeight.w500,
                            align: Alignment.center),
                        headingContainer(
                            txt: "${tableData[i]["timeOut"]}",
                            weigth: FontWeight.w500,
                            align: Alignment.center),
                        Container(
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
                                  child: AppText.appText("P",
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
            ),
        ],
      ),
    );
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
