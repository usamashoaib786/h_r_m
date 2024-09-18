import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_r_m/Utils/widgets/others/app_text.dart';

class PieChartSample2 extends StatefulWidget {
  final attData; // Ensure the data structure is known and consistent.

  const PieChartSample2({super.key, this.attData}); // Require attData.

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<PieChartSample2> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 80,
            width: 80,
            child: PieChart(
              PieChartData(sections: showingSections()),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                children: [
                  custom(
                      color: AppColors.present,
                      txt: "Total Presents",
                      txt2: widget.attData["total_present"].toString()),
                  custom(
                      color: AppColors.leaves,
                      txt: "Total Leaves",
                      txt2: widget.attData["total_leaves"].toString()),
                ],
              ),
              Row(
                children: [
                  custom(
                      color: AppColors.absent,
                      txt: "Total Absents",
                      txt2: widget.attData["total_absents"].toString()),
                  custom(
                      color: AppColors.late,
                      txt: "Total Lates",
                      txt2: widget.attData["total_late"].toString()),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

 List<PieChartSectionData> showingSections() {
    // Extract values from attData
    final double presentValue = widget.attData["total_present"].toDouble();
    final double absentValue = widget.attData["total_absents"].toDouble();
    final double leavesValue = widget.attData["total_leaves"].toDouble();
    final double lateValue = widget.attData["total_late"].toDouble();

    // Check if all values are zero
    if (presentValue == 0 && absentValue == 0 && leavesValue == 0 && lateValue == 0) {
      // If all values are zero, return a single grey section
      return [
        PieChartSectionData(
          color: Colors.grey,
          radius: 40,
          value: 1, // Show full grey circle
        ),
      ];
    }

    // Otherwise, return the usual sections
    return [
      PieChartSectionData(
        color: AppColors.present,
        radius: 40,
        value: presentValue,
      ),
      PieChartSectionData(
        color: AppColors.absent,
        radius: 40,
        value: absentValue,
      ),
      PieChartSectionData(
        color: AppColors.leaves,
        radius: 40,
        value: leavesValue,
      ),
      PieChartSectionData(
        color: AppColors.late,
        radius: 40,
        value: lateValue,
      ),
    ];
  }

  Widget custom(
      {required Color color, required String txt, required String txt2}) {
    return SizedBox(
      height: 12,
      width: 110,
      child: Row(
        children: [
          Container(
            height: 12,
            width: 10,
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(10)),
          ),
          const SizedBox(width: 5),
          AppText.appText(txt, fontSize: 10, fontWeight: FontWeight.w400),
          const SizedBox(width: 5),
          AppText.appText(txt2, fontSize: 10, fontWeight: FontWeight.w700),
        ],
      ),
    );
  }
}

class AppColors {
  static const Color present = Color(0xFF3DD598);
  static const Color absent = Color(0xFFFFC542);
  static const Color leaves = Color(0xFFE0623C);
  static const Color late = Color(0xFFEF3E5C);
}
