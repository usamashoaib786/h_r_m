import 'package:flutter/material.dart';
import 'package:hrm_project/Utils/resources/res/app_theme.dart';
import 'package:hrm_project/Utils/utils.dart';
import 'package:hrm_project/Utils/widgets/others/app_text.dart';
import 'package:hrm_project/View/MarkAttendence/mark_attendence.dart';

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
            SizedBox(
              height: 270,
              width: screenWidth,
              child: Stack(
                children: [
                  Container(
                    width: screenWidth,
                    height: 210,
                    decoration: BoxDecoration(
                        color: AppTheme.appColor,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50))),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 50.0, left: 20, right: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText.appText("Usama Shoaib",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  textColor: AppTheme.white),
                              Image.asset("assets/images/logout.png")
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 1,
                            width: screenWidth,
                            color: AppTheme.white,
                          )
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        height: 141,
                        width: screenWidth,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: const Color(0xff19A99D)),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      customText(txt: "Flutter Developer"),
                                      customText(
                                          txt: "Application Development"),
                                      customText(txt: "Employee Id: DTM-53"),
                                      customText(txt: "+923134598073"),
                                      customText(
                                          txt:
                                              "usama.shoaib@digitalmandee.com"),
                                    ],
                                  )
                                ],
                              ),
                              Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: AppTheme.white),
                                child: const Center(
                                  child: Icon(
                                    Icons.person,
                                    size: 60,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 40),
              child: Wrap(
                runSpacing: 20,
                spacing: 20,
                children: [
                  customContainer(
                      bgColor: AppTheme.appColor,
                      onTap: () {
                        push(context, MarkAttendenceScreen());
                      },
                      txt: "Mark \nAttendance",
                      img: "assets/images/markAttendense.png"),
                  customContainer(
                      bgColor: AppTheme.green,
                      txt: "View \nAttendance",
                      img: "assets/images/viewAttendence.png"),
                  customContainer(
                      bgColor: AppTheme.appColor,
                      txt: "Request \nLeave",
                      img: "assets/images/requestLeave.png"),
                  customContainer(
                      bgColor: AppTheme.green,
                      txt: "Leave \nQuota",
                      img: "assets/images/leaveQuota.png"),
                  customContainer(
                      bgColor: AppTheme.appColor,
                      txt: "Comming \nEvents",
                      img: "assets/images/notice.png"),
                  customContainer(
                      bgColor: AppTheme.green,
                      txt: "Notice \nBoard",
                      img: "assets/images/events.png"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget customText({txt}) {
    return AppText.appText("$txt",
        textColor: AppTheme.white, fontSize: 11, fontWeight: FontWeight.w800);
  }

  Widget customContainer({bgColor, txt, img, onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 165,
        height: 168,
        decoration: ShapeDecoration(
          color: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 5.0, left: 5),
          child: Container(
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
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
                Container(
                  width: 75,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), color: bgColor),
                  child: Center(
                    child: Image(image: AssetImage("$img")),
                  ),
                ),
                AppText.appText(
                  '$txt',
                  textAlign: TextAlign.center,
                  textColor: Color(0xFF555555),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
