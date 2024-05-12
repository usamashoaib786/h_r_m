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
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(150),
                      bottomRight: Radius.circular(150))),
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
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
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
                            child: Image.asset("assets/images/logout.png"),
                          ),
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
                                  txt1: "Designation",
                                  txt2: "${homeApi.userDes}"),
                              customRow(
                                  img: "assets/images/employee.png",
                                  txt1: "Employee ID",
                                  txt2: "DTM-${homeApi.empId}")
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
                                  txt2: "${homeApi.empDep}"),
                              customRow(
                                  img: "assets/images/phone.png",
                                  txt1: "Phone",
                                  txt2: "${homeApi.userPhone}")
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
                        push(
                            context,
                            MarkAttendenceScreen(
                              userId: homeApi.empId,
                            ));
                      },
                      bgColor: AppTheme.appColor,
                      txt: "Mark \nAttendance",
                      img: "assets/images/fingerPrint.png"),
                  customContainer(
                      onTap: () {
                        push(
                            context,
                            ViewAttendence(
                              userId: homeApi.empId,
                            ));
                      },
                      bgColor: AppTheme.appColor,
                      txt: "View \nAttendance",
                      img: "assets/images/attendenceReq.png"),
                  customContainer(
                      onTap: () {
                        push(
                            context,
                            RequestLeave(
                              userId: homeApi.empId,
                            ));
                      },
                      bgColor: AppTheme.appColor,
                      txt: "Request \nLeave",
                      img: "assets/images/leavereq.png"),
                  customContainer(
                      onTap: () {
                        push(
                            context,
                            leaveQuotaScreen(
                              userId: homeApi.empId,
                            ));
                      },
                      bgColor: AppTheme.green,
                      txt: "Leave \nQuota",
                      img: "assets/images/leaveQuota.png"),
                  if (homeApi.userType == "3")
                    customContainer(
                        onTap: () {
                          push(context, const EmployeeListScreen());
                        },
                        bgColor: AppTheme.appColor,
                        txt: "Employee \nList",
                        img: "assets/images/leavereq.png"),
                  if (homeApi.userType == "3" || homeApi.userType == "1")
                    customContainer(
                        onTap: () {
                          push(context, const HodViewLeaves());
                        },
                        bgColor: AppTheme.appColor,
                        txt: "View \nLeave Requests",
                        img: "assets/images/leavereq.png"),
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
                      txt: "Notice \n",
                      img: "assets/images/notice.png"),
                  customContainer(
                      onTap: () {
                        push(context, const CommingEventsScreen());
                      },
                      bgColor: AppTheme.green,
                      txt: "Events \n",
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
                          color: const Color(0xffF2F2F2)),
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
                  fontSize: 10,
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
