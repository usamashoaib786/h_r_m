import 'package:flutter/material.dart';
import 'package:h_r_m/Utils/resources/res/app_theme.dart';
import 'package:h_r_m/Utils/utils.dart';
import 'package:h_r_m/Utils/widgets/others/app_text.dart';
import 'package:h_r_m/View/Comming%20Events/coming_events.dart';
import 'package:h_r_m/View/Company%20Profile/company_profile.dart';
import 'package:h_r_m/View/Leave%20Quota/leave_quota.dart';
import 'package:h_r_m/View/MarkAttendence/mark_attendence.dart';
import 'package:h_r_m/View/Notice%20Board/notice_board.dart';
import 'package:h_r_m/View/Request%20Leave/request_leave.dart';
import 'package:h_r_m/View/Rules%20and%20Regulation/rule_regulation.dart';
import 'package:h_r_m/View/View%20Attendence/view_attendence.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: screenWidth,
              height: 280,
              decoration: BoxDecoration(
                  color: AppTheme.appColor,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(150),
                      bottomRight: Radius.circular(150))
                      ),
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0, left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: AppTheme.white),
                              child: const Center(
                                child: Icon(
                                  Icons.person,
                                  size: 20,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: screenWidth * 0.55,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText.appText("Usama Shoaib",
                                        fontWeight: FontWeight.w800,
                                        fontSize: 18,
                                        textColor: AppTheme.white),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Icons.email_outlined,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        AppText.appText(
                                            "usama.shoaib@digitalmandee.com",
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10,
                                            textColor: AppTheme.white),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Image.asset("assets/images/logout.png"),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 70,
                      width: screenWidth - 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customRow(
                                  img: "assets/images/designation.png",
                                  txt1: "Dsignation",
                                  txt2: " Flutter Developer"),
                              customRow(
                                  img: "assets/images/employee.png",
                                  txt1: "Employee ID",
                                  txt2: "DTM-53")
                            ],
                          ),
                          Container(
                            height: 80,
                            width: 1,
                            color: AppTheme.whiteColor,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customRow(
                                  img: "assets/images/department.png",
                                  txt1: "Department",
                                  txt2: "App Development"),
                              customRow(
                                  img: "assets/images/phone.png",
                                  txt1: "Phone",
                                  txt2: "03134598073")
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 40, bottom: 40, left: 20, right: 20),
              child: Wrap(
                alignment: WrapAlignment.center,
                runSpacing: 50,
                spacing: 20,
                children: [
                  customContainer(
                      onTap: () {
                        push(context, const MarkAttendenceScreen());
                      },
                      bgColor: AppTheme.appColor,
                      txt: "Mark \nAttendance",
                      img: "assets/images/fingerPrint.png"),
                  customContainer(
                      onTap: () {
                        push(context, const ViewAttendence());
                      },
                      bgColor: AppTheme.appColor,
                      txt: "View \nAttendance",
                      img: "assets/images/attendenceReq.png"),
                  customContainer(
                      onTap: () {
                        push(context, const RequestLeave());
                      },
                      bgColor: AppTheme.appColor,
                      txt: "Request \nLeave",
                      img: "assets/images/leavereq.png"),
                  customContainer(
                      onTap: () {
                        push(context, const leaveQuotaScreen());
                      },
                      bgColor: AppTheme.green,
                      txt: "Leave \nQuota",
                      img: "assets/images/leaveQuota.png"),
                  customContainer(
                      onTap: () {
                        push(context, const CommingEventsScreen());
                      },
                      bgColor: AppTheme.green,
                      txt: "Comming \nEvents",
                      img: "assets/images/events.png"),
                  customContainer(
                      onTap: () {
                        push(context, const CompanyProfileScreen());
                      },
                      bgColor: AppTheme.green,
                      txt: "Company \nProfile",
                      img: "assets/images/compProfile.png"),
                  customContainer(
                      onTap: () {
                        push(context, const RulesRegulationScreen());
                      },
                      bgColor: AppTheme.appColor,
                      txt: "Rules & \nRegulations",
                      img: "assets/images/rules.png"),
                  customContainer(
                      onTap: () {
                        push(context, const NoticeBoardScreen());
                      },
                      bgColor: AppTheme.green,
                      txt: "Notice \nBoard",
                      img: "assets/images/notice.png"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget customContainer({bgColor, txt, img, onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 90,
        height: 100,
        decoration: ShapeDecoration(
          color: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 2.0, left: 2),
          child: Container(
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 7,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Container(
                      width: 40,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xffF2F2F2)),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Image.asset(
                          "$img",
                        ),
                      )),
                ),
                AppText.appText(
                  '$txt',
                  textAlign: TextAlign.center,
                  textColor: const Color(0xFF555555),
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget customRow({img, txt1, txt2}) {
    return Row(
      children: [
        Image.asset(
          "$img",
          height: 18,
        ),
        const SizedBox(
          width: 7,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.appText("$txt1",
                fontSize: 13,
                textColor: AppTheme.whiteColor,
                fontWeight: FontWeight.w700),
            AppText.appText("$txt2",
                fontSize: 9,
                textColor: AppTheme.whiteColor,
                fontWeight: FontWeight.w300),
          ],
        )
      ],
    );
  }
}
