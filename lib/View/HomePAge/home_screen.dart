import 'package:flutter/material.dart';
import 'package:h_r_m/Constants/app_logger.dart';
import 'package:h_r_m/Utils/resources/res/app_theme.dart';
import 'package:h_r_m/Utils/utils.dart';
import 'package:h_r_m/Utils/widgets/others/app_text.dart';
import 'package:h_r_m/View/Comming%20Events/coming_events.dart';
import 'package:h_r_m/View/Company%20Profile/company_profile.dart';
import 'package:h_r_m/View/Employee%20List/employee_list.dart';
import 'package:h_r_m/View/HOD%20View%20Leaves/hod_view_leaves.dart';
import 'package:h_r_m/View/HomePAge/api.dart';
import 'package:h_r_m/View/HomePAge/chart.dart';
import 'package:h_r_m/View/Leave%20Quota/leave_quota.dart';
import 'package:h_r_m/View/MarkAttendence/mark_attendence.dart';
import 'package:h_r_m/View/Notice%20Board/notice_board.dart';
import 'package:h_r_m/View/Request%20Leave/request_leave.dart';
import 'package:h_r_m/View/Rules%20and%20Regulation/rule_regulation.dart';
import 'package:h_r_m/View/View%20Attendence/view_attendence.dart';
import 'package:h_r_m/View/popup.dart';
import 'package:h_r_m/config/dio/app_dio.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  bool isLoading = false;
  late AppDio dio;
  AppLogger logger = AppLogger();

  @override
  void initState() {
    dio = AppDio(context);
    logger.init();
    final homeApi = Provider.of<HomeApiProvider>(context, listen: false);
    homeApi.getUserProfile(dio: dio, context: context);
    homeApi.getAtendence(dio: dio, context: context);

    homeApi.getUserDetail();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeApi = Provider.of<HomeApiProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: screenWidth,
              height: 280,
              decoration: BoxDecoration(
                color: AppTheme.appColor,
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
                              child: homeApi.profileDetail == null
                                  ? const Center(
                                      child: Icon(
                                      Icons.person,
                                      size: 20,
                                    ))
                                  : homeApi.profileDetail["avatar"] == null
                                      ? const Center(
                                          child: Icon(
                                          Icons.person,
                                          size: 20,
                                        ))
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.network(
                                            "https://hr.digitalmandee.com/profile_picture/${homeApi.profileDetail["avatar"]}",
                                            fit: BoxFit.fill,
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
                                    AppText.appText("${homeApi.userName}",
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
                                        AppText.appText("${homeApi.userEmail}",
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
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const CustomPopUp();
                              },
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Image.asset(
                              "assets/images/logout.png",
                              height: 20,
                              fit: BoxFit.fill,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                          color: AppTheme.white,
                          borderRadius: BorderRadius.circular(10)),
                      width: screenWidth,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                customRow(
                                    img: "assets/images/designation.png",
                                    txt1: "Designation",
                                    txt2: "${homeApi.userDes}"),
                                customRow(
                                    img: "assets/images/employee.png",
                                    txt1: "Employee ID",
                                    txt2: "DTM-${homeApi.empId}")
                              ],
                            ),
                            Container(
                              height: 60,
                              width: 1,
                              color: Colors.black,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                customRow(
                                    img: "assets/images/department.png",
                                    txt1: "Department",
                                    txt2: "${homeApi.empDep}"),
                                customRow(
                                    img: "assets/images/phone.png",
                                    txt1: "Phone",
                                    txt2: "${homeApi.userPhone}")
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 40, left: 20, right: 20),
                child: Card(
                  elevation: 10,
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: homeApi.empAtendence == null
                        ? Center(
                            child: CircularProgressIndicator(
                              color: AppTheme.appColor,
                            ),
                          )
                        : PieChartSample2(
                            attData: homeApi.empAtendence,
                          ),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(bottom: 40, left: 20, right: 20),
              child: Wrap(
                alignment: WrapAlignment.center,
                runSpacing: 50,
                spacing: 10,
                children: [
                  if (homeApi.userType != "5")
                    customContainer(
                        onTap: () {
                          push(
                              context,
                              MarkAttendenceScreen(
                                userId: homeApi.empId,
                              ));
                        },
                        txt: "Mark Attendance",
                        img: "assets/images/fingerPrint.png"),
                  if (homeApi.userType != "5")
                    customContainer(
                        onTap: () {
                          push(
                              context,
                              ViewAttendence(
                                userId: homeApi.empId,
                              ));
                        },
                        txt: "View Attendance",
                        img: "assets/images/attendenceReq.png"),
                  if (homeApi.userType != "5")
                    customContainer(
                        onTap: () {
                          push(
                              context,
                              RequestLeave(
                                userId: homeApi.empId,
                              ));
                        },
                        txt: "Request Leave",
                        img: "assets/images/leavereq.png"),
                  if (homeApi.userType != "5")
                    customContainer(
                        onTap: () {
                          push(
                              context,
                              leaveQuotaScreen(
                                userId: homeApi.empId,
                              ));
                        },
                        txt: "Leave Quota",
                        img: "assets/images/leaveQuota.png"),
                  if (homeApi.userType == "3" ||
                      homeApi.userType == "1" ||
                      homeApi.userType == "5")
                    customContainer(
                        onTap: () {
                          push(context, const EmployeeListScreen());
                        },
                        txt: "Employee List",
                        img: "assets/images/leavereq.png"),
                  if (homeApi.userType == "3" ||
                      homeApi.userType == "1" ||
                      homeApi.userType == "5")
                    customContainer(
                        onTap: () {
                          push(context, const HodViewLeaves());
                        },
                        txt: "View Leave Requests",
                        img: "assets/images/viewLeaves.png"),
                  customContainer(
                      onTap: () {
                        push(context, const CompanyProfileScreen());
                      },
                      txt: "Company Profile",
                      img: "assets/images/compProfile.png"),
                  customContainer(
                      onTap: () {
                        push(context, const RulesRegulationScreen());
                      },
                      txt: "Rules & Regulations",
                      img: "assets/images/rules.png"),
                  customContainer(
                      onTap: () {
                        push(context, const NoticeBoardScreen());
                      },
                      txt: "Notice ",
                      img: "assets/images/notice.png"),
                  customContainer(
                      onTap: () {
                        push(context, const CommingEventsScreen());
                      },
                      txt: "Events ",
                      img: "assets/images/events.png"),
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
      child: SizedBox(
        height: 80,
        width: 110,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: 57,
                height: 57,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: const Color.fromARGB(255, 233, 241, 240)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(
                    "$img",
                  ),
                )),
            AppText.appText(
              '$txt',
              textAlign: TextAlign.center,
              textColor: const Color(0xFF555555),
              fontSize: 10,
              fontWeight: FontWeight.w700,
            )
          ],
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
          color: AppTheme.appColor,
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.appText("$txt1",
                fontSize: 13,
                textColor: Colors.black,
                fontWeight: FontWeight.w700),
            AppText.appText("$txt2",
                fontSize: 9,
                textColor: Colors.black,
                fontWeight: FontWeight.w300),
          ],
        )
      ],
    );
  }
}
