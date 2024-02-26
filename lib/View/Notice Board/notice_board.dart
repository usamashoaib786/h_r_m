import 'package:flutter/material.dart';
import 'package:h_r_m/Utils/resources/res/app_theme.dart';
import 'package:h_r_m/Utils/widgets/others/app_text.dart';

class NoticeBoardScreen extends StatefulWidget {
  const NoticeBoardScreen({super.key});

  @override
  State<NoticeBoardScreen> createState() => _NoticeBoardScreenState();
}

class _NoticeBoardScreenState extends State<NoticeBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppTheme.white),
        backgroundColor: AppTheme.appColor,
        title: AppText.appText(
          "Notice Board",
          textColor: AppTheme.white,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/board.png",
                      height: 100,
                    )),
              ),
              ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical:8.0),
                    child: Card(
                      color: Colors.white,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppTheme.whiteColor),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 14,
                                    width: 14,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppTheme.appColor),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Container(
                                          height: 7,
                                          width: 7,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppTheme.white)),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  AppText.appText(
                                    "Mam Rabia HR",
                                    textColor: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  AppText.appText(
                                    "12:15 PM",
                                    textColor: Colors.black,
                                    fontSize: 7,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: AppText.appText(
                                  "Someone just reviewed",
                                  textColor: Color(0xff818283),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Container(
                                child: AppText.appText(
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In urna nam purus vulputate quis. Sed arcu laoreet maecenas condimentum porta quis sed praesent sed.",
                                    fontSize: 7,
                                    fontWeight: FontWeight.w500,
                                    textColor: Color(0xff9F9EAB)),
                              )
                            ],
                          ),
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
}
