import 'package:flutter/material.dart';
import 'package:h_r_m/Utils/resources/res/app_theme.dart';
import 'package:h_r_m/Utils/widgets/others/app_text.dart';

class RulesRegulationScreen extends StatefulWidget {
  const RulesRegulationScreen({super.key});

  @override
  State<RulesRegulationScreen> createState() => _RulesRegulationScreenState();
}

class _RulesRegulationScreenState extends State<RulesRegulationScreen> {
  final rulesHeading = [
    "Employment Status",
    "Work Hours",
    "Leave Policy",
    "Code of Conduct",
    "Compliance with Laws"
  ];
  final rulesList = [
    "All employees must maintain their employment status as defined in their employment contract.",
    "Regular work hours are [insert hours].",
    "All employees are entitled to [insert number] days of annual leave per year.",
    "Employees are expected to adhere to the company's code of conduct at all times.",
    "Employees are required to comply with all applicable laws and regulations in the performance of their duties.",
  ];
  final rules1List = [
    "Any changes in employment status must be communicated and documented by HR",
    "Overtime may be required based on business needs and must be approved by the supervisor.",
    "Sick leave and other types of leave must be requested in advance and approved by the supervisor.",
    "Any violations of the code of conduct will result in disciplinary action, up to and including termination.",
    "Failure to comply with laws may result in legal consequences for both the employee and the company.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppTheme.white),
        backgroundColor: AppTheme.appColor,
        title: AppText.appText(
          "Rules And Regulation",
          textColor: AppTheme.white,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/regulation.png",
                      height: 100,
                    )),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: rulesHeading.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                              AppText.appText(
                                "${rulesHeading[index]}",
                                textColor: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 5.0),
                                        child: Container(
                                          height: 5,
                                          width: 5,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.black),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                98,
                                        child: AppText.appText(
                                            "${rulesList[index]}",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            textColor: const Color(0xff3F3F3F)),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 5.0),
                                        child: Container(
                                          height: 5,
                                          width: 5,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.black),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                98,
                                        child: AppText.appText(
                                            "${rules1List[index]}",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            textColor: const Color(0xff3F3F3F)),
                                      ),
                                    ],
                                  ),
                                ],
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
