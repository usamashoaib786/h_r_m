import 'package:flutter/material.dart';
import 'package:h_r_m/Utils/resources/res/app_theme.dart';
import 'package:h_r_m/Utils/widgets/others/app_text.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 170,
              width: MediaQuery.of(context).size.width,
              color: AppTheme.white,
              child: Stack(
                children: [
                  Container(
                    height: 110,
                    width: MediaQuery.of(context).size.width,
                    color: AppTheme.appColor,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      child: Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                            color: AppTheme.white, shape: BoxShape.circle),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Image.asset(
                            "assets/images/profileImg.png",
                            height: 66,
                            width: 66,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 30),
              child: Column(
                children: [
                  AppText.appText("Usama Shoaib",
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      textColor: Colors.black),
                  AppText.appText("Flutter Developer",
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      textColor: Color(0xff8C8C8C)),
                ],
              ),
            ),
            customRow(
                txt1: "E-mail",
                txt2: "usama.shoaib@digitalmandee.com",
                img: "assets/images/mail.png"),
            divider(),
            customRow(
                txt1: "Phone Number",
                txt2: "+923134598073",
                img: "assets/images/phone1.png"),
            divider(),
            customRow(
                txt1: "Designation",
                txt2: "Flutter Developer",
                img: "assets/images/designation1.png"),
            divider(),
            customRow(
                txt1: "Department",
                txt2: "Application Development",
                img: "assets/images/department1.png"),
            divider(),
            customRow(
                txt1: "Employee ID",
                txt2: "Employee ID.DTM-59",
                img: "assets/images/person.png"),
          ],
        ),
      ),
    );
  }

  Widget divider() {
    return Container(
      height: 1,
      width: MediaQuery.of(context).size.width,
      color: const Color(0xffB7B7B7),
    );
  }

  Widget customRow({img, txt1, txt2}) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image.asset(
            "$img",
            height: 18,
            color: AppTheme.appColor,
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.appText("$txt1",
                  fontSize: 16,
                  textColor: Color(0xff1A1A1A),
                  fontWeight: FontWeight.w500),
              AppText.appText("$txt2",
                  fontSize: 14,
                  textColor: Color(0xff515151),
                  fontWeight: FontWeight.w400),
            ],
          )
        ],
      ),
    );
  }
}
