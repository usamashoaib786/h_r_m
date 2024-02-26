import 'package:flutter/material.dart';
import 'package:h_r_m/Utils/resources/res/app_theme.dart';
import 'package:h_r_m/Utils/widgets/others/app_text.dart';
import 'package:intl/intl.dart';

class MarkAttendenceScreen extends StatefulWidget {
  const MarkAttendenceScreen({super.key});

  @override
  State<MarkAttendenceScreen> createState() => _MarkAttendenceScreenState();
}

class _MarkAttendenceScreenState extends State<MarkAttendenceScreen> {
  bool home = false;
  bool office = true;
  String _currentTime = '';
  String _amPm = '';
  String _day = '';
  String _date = '';

  @override
  void initState() {
    _updateTime();
    super.initState();
  }

  void _updateTime() {
    setState(() {
      var now = DateTime.now();
      _currentTime = DateFormat('h:mm').format(now);
      _date = DateFormat('EEEE, MMM dd, yyyy').format(now);
      _amPm = DateFormat('a').format(now);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppTheme.white),
        backgroundColor: AppTheme.appColor,
        title: AppText.appText(
          "Mark Attendence",
          textColor: AppTheme.white,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(vertical:  40.0,horizontal: 20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 53,
                width: 230,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    color: AppTheme.appColor),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            home = !home;
                            office = !home;
                          });
                        },
                        child: Container(
                          height: 40,
                          width: 107,
                          decoration: BoxDecoration(
                              color: office == true
                                  ? const Color(0xffFFFFFFE5)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(35)),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset("assets/images/office.png"),
                                AppText.appText("Office",
                                    textColor: office == true
                                        ? Colors.black
                                        : AppTheme.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700)
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
                          });
                        },
                        child: Container(
                          height: 40,
                          width: 107,
                          decoration: BoxDecoration(
                              color: home == true
                                  ? const Color(0xffFFFFFFE5)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(35)),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.home,
                                  color: home == true
                                      ? Colors.black
                                      : AppTheme.white,
                                ),
                                AppText.appText("Home",
                                    textColor: home == true
                                        ? Colors.black
                                        : AppTheme.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          AppText.appText(_currentTime,
                              fontSize: 48, fontWeight: FontWeight.w400),
                          const SizedBox(
                            width: 10,
                          ),
                          AppText.appText(_amPm,
                              fontSize: 20, fontWeight: FontWeight.w400)
                        ],
                      ),
                      AppText.appText(_date,
                          fontSize: 20, fontWeight: FontWeight.w400),
                           const SizedBox(
                            height: 30,
                          ),
                      Image.asset(
                        "assets/images/finger.png",
                        height: 180,
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customButton(
                      txt: "Check In", color: AppTheme.appColor, ontap: () {}),
                  const SizedBox(
                    width: 20,
                  ),
                  customButton(
                      txt: "Check Out", color: AppTheme.green, ontap: () {}),
                ],
              )
            ],
          ),
        ),
      ),
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
              const SizedBox(
                width: 10,
              ),
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
}
  // isSelected: isSelected,
  //           onPressed: (index) {
  //             setState(() {
  //               // Update the selection state
  //               for (int buttonIndex = 0;
  //                   buttonIndex < isSelected.length;
  //                   buttonIndex++) {
  //                 isSelected[buttonIndex] = buttonIndex == index;
  //               }
  //             });
  //           },
