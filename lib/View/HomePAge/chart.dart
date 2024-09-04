import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_r_m/Utils/resources/res/app_theme.dart';
import 'package:h_r_m/Utils/widgets/others/app_text.dart';

class PieChartSample2 extends StatefulWidget {
  const PieChartSample2({super.key});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
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
                  custom(color: AppColors.present, txt: "Total Presents", txt2: "18"),
                  custom(color: AppColors.leaves, txt: "Total Leaves", txt2: "2"),
                ],
              ),
              Row(
                children: [
                  custom(color: AppColors.absent, txt: "Total Absents", txt2: "2"),
                  custom(color: AppColors.late, txt: "Total Lates", txt2: "00"),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: AppColors.present,
            radius: 40,
            value: 18
          );
        case 1:
          return PieChartSectionData(
            color: AppColors.absent,
            radius: 40,
            value: 2

          );
        case 2:
          return PieChartSectionData(
            color: AppColors.leaves,
            radius: 40,
            value: 2

          );
        case 3:
          return PieChartSectionData(
            color: AppColors.late,
            radius: 40,
            value: 0

          );
        default:
          throw Error();
      }
    });
  }

  Widget custom({color, txt, txt2}) {
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
          const SizedBox(
            width: 5,
          ),
          AppText.appText("$txt", fontSize: 10, fontWeight: FontWeight.w400),
          const SizedBox(
            width: 5,
          ),
          AppText.appText("$txt2", fontSize: 10, fontWeight: FontWeight.w700)
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
  // static const Color contentColorCyan = Color(0xFF50E4FF);
}
