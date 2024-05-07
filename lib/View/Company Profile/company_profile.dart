import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:h_r_m/Utils/resources/res/app_theme.dart';
import 'package:h_r_m/Utils/widgets/others/app_text.dart';

class CompanyProfileScreen extends StatefulWidget {
  const CompanyProfileScreen({super.key});

  @override
  State<CompanyProfileScreen> createState() => _CompanyProfileScreenState();
}

class _CompanyProfileScreenState extends State<CompanyProfileScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppTheme.white),
        backgroundColor: AppTheme.appColor,
        title: AppText.appText(
          "Company Profile",
          textColor: AppTheme.white,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: [
              firstPage(),
              aboutUsPage(),
              pageCEO(),
              departmentPage(),
              headPage(),
              servicePage(),
              rulesPage(),
              thanksPage(),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 40.0,
            child: Center(
              child: DotsIndicator(
                dotsCount:
                    8, // Change this count according to your number of pages
                position: _currentPage,
                decorator: DotsDecorator(
                  color: Colors.grey, // Inactive dot color
                  activeColor: AppTheme.appColor, // Active dot color
                  size: const Size.square(9.0),
                  activeSize: const Size.square(9.0),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget firstPage() {
    return Stack(
      children: [
        Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 70.0),
              child: Image.asset("assets/images/logo.png"),
            )),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 150.0),
            child: Container(
              height: 22,
              width: 170,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(10),
                  ),
                  color: AppTheme.appColor),
              child: Center(
                child: AppText.appText("COMPANY INTRODUCTION",
                    textColor: AppTheme.whiteColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget aboutUsPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Image.asset(
            "assets/images/aboutUs.png",
            width: MediaQuery.of(context).size.width * 0.7,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 100.0),
          child: Image.asset(
            "assets/images/aboutText.png",
            height: 153,
          ),
        )
      ],
    );
  }

  Widget pageCEO() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 50),
      child: Image.asset(
        "assets/images/ceo.png",
      ),
    );
  }

  Widget departmentPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 40),
      child: Image.asset(
        "assets/images/departments.png",
      ),
    );
  }

  Widget servicePage() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 40),
      child: Image.asset(
        "assets/images/service.png",
      ),
    );
  }

  Widget headPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Center(
        child: SizedBox(
          height: 300,
          child: Image.asset(
            "assets/images/hodImage.png",
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Widget thanksPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/than.png",
          ),
          const SizedBox(
            height: 20,
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: "Welcome aboard! ",
              style: TextStyle(
                color: AppTheme.appColor,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
              children: const <TextSpan>[
                TextSpan(
                  text:
                      "We're thrilled to have you as part of our team and look forward to a successful journey together.'",
                  style: TextStyle(
                      color: Colors.black, // Change this color as needed
                      fontWeight: FontWeight.w400,
                      fontSize: 12),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget rulesPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0, bottom: 20),
              child: AppText.appText("Company Rules and Regulations",
                  textColor: Colors.black, fontWeight: FontWeight.w700),
            ),
            customColumn(
                txt:
                    "Arrival after 11:15 am thrice in a month will count as one absence, resulting in a deduction of one day's salary.",
                img: "assets/images/clock 1.png"),
            divider(),
            customColumn(
                txt:
                    "Employees must mark their attendance using the Attendance app. ",
                img: "assets/images/attendance 1.png"),
            divider(),
            customColumn(
                txt:
                    "Company has its own Mailing system known as Webmail. In case of emergencies or work-from-home requests, the company's webmail must be utilized as the communication channel.",
                img: "assets/images/approve 1.png"),
            divider(),
            customColumn(
                txt:
                    "Failure to report to the office without prior notification will be considered as an absence, resulting in a deduction of one day's salary.",
                img: "assets/images/tax 1.png"),
            divider(),
            customColumn(
                txt:
                    "Leave requests must be made through the HRM system, requiring approval from the HOD followed by HR. ",
                img: "assets/images/enterprise.png"),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }

  Widget divider() {
    return Container(
      height: 1,
      width: MediaQuery.of(context).size.width,
      color: Color(0xffCACACA),
    );
  }

  Widget customColumn({txt, img}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/checked.png",
                width: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: AppText.appText("$txt",
                      fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          Image.asset(
            "$img",
            width: 40,
          ),
        ],
      ),
    );
  }
}
