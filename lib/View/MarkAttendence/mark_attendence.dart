import 'package:flutter/material.dart';
import 'package:hrm_project/Utils/resources/res/app_theme.dart';
import 'package:hrm_project/Utils/widgets/others/app_text.dart';

class MarkAttendenceScreen extends StatefulWidget {
  const MarkAttendenceScreen({super.key});

  @override
  State<MarkAttendenceScreen> createState() => _MarkAttendenceScreenState();
}

class _MarkAttendenceScreenState extends State<MarkAttendenceScreen> {
  bool home = false;
  bool office = true;
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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
            )
          ],
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