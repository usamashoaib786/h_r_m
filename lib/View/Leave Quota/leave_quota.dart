import 'package:flutter/material.dart';
import 'package:h_r_m/Utils/resources/res/app_theme.dart';
import 'package:h_r_m/Utils/widgets/others/app_button.dart';
import 'package:h_r_m/Utils/widgets/others/app_text.dart';

class leaveQuotaScreen extends StatefulWidget {
  const leaveQuotaScreen({super.key});

  @override
  State<leaveQuotaScreen> createState() => _leaveQuotaScreenState();
}

class _leaveQuotaScreenState extends State<leaveQuotaScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppTheme.white),
        backgroundColor: AppTheme.appColor,
        title: AppText.appText(
          "Leave Quota",
          textColor: AppTheme.white,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 125,
                width: screenWidth,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xffF6F3F3)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText.appText("Annual Leave Quota",
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          textColor: AppTheme.appColor),
                      Container(
                        height: 33,
                        width: screenWidth,
                        color: AppTheme.whiteColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              containerLeave(txt: "Paid Allowed", width: 79.0),
                              containerLeave(txt: "Annual", width: 44.0),
                              containerLeave(txt: "Casual", width: 44.0),
                              containerLeave(txt: "Sick", width: 25.0),
                              containerLeave(txt: "Remaining", width: 67.0),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 33,
                        width: screenWidth,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              containerLeave(txt: "32", width: 79.0),
                              containerLeave(txt: "15", width: 44.0),
                              containerLeave(txt: "10", width: 44.0),
                              containerLeave(txt: "08", width: 25.0),
                              containerLeave(txt: "27", width: 67.0),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Container(
                      width: screenWidth,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color(0xffF6F3F3)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 42,
                                  width: 42,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppTheme.appColor,
                                  ),
                                  child: Center(
                                    child: AppText.appText("U",
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        textColor: AppTheme.whiteColor),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText.appText("Usama Shoaib",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        textColor: const Color(0xff0451E5)),
                                    AppText.appText(
                                        "From: 01-01-2024 to 03-01-2024",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        textColor: const Color(0xff1F1F1F)),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            AppText.appText("Casual Leave",
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                textColor: AppTheme.appColor),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: screenWidth,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppTheme.whiteColor),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start   ,
                                  children: [
                                    AppText.appText("Reason:    ",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        textColor: Color(0xff979696)),
                                    SizedBox(
                                      width: screenWidth - 155,
                                      child: AppText.appText(
                                          "Suffering from fever",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          textColor: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            AppButton.appButton("Accepted By HOD",
                                radius: 16.0,
                                backgroundColor: AppTheme.appColor,
                                textColor: AppTheme.whiteColor,
                                height: 35)
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget containerLeave({txt, width}) {
    return Container(
      alignment: Alignment.center,
      width: width,
      child: AppText.appText("$txt",
          fontSize: 12, fontWeight: FontWeight.w500, textColor: Colors.black),
    );
  }
}
