import 'package:flutter/material.dart';
import 'package:h_r_m/Utils/resources/res/app_theme.dart';
import 'package:h_r_m/Utils/widgets/others/app_button.dart';
import 'package:h_r_m/Utils/widgets/others/app_text.dart';
import 'package:intl/intl.dart';

class RequestLeave extends StatefulWidget {
  const RequestLeave({super.key});

  @override
  State<RequestLeave> createState() => _RequestLeaveState();
}

class _RequestLeaveState extends State<RequestLeave> {
  String selectedRequestType = 'Annual Leave';
  DateTime? startDate;
  DateTime? endDate;
  TextEditingController _descController = TextEditingController();
  Color defaultColor =
      const Color(0xffFFFFFF); // Default color for all containers
  Color selectedColor = AppTheme.appColor; // Color for the selected container

  void setSelectedRequestType(String requestType) {
    setState(() {
      selectedRequestType = requestType;
    });
  }

  String selectedOption = 'half'; // Variable to store selected option

  void setSelectedOption(String option) {
    setState(() {
      selectedOption = option;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppTheme.white),
        backgroundColor: AppTheme.appColor,
        title: AppText.appText(
          "Add Leave Request",
          textColor: AppTheme.white,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          children: [
            Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/leavereq.png",
                  height: 128,
                )),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: Card(
              elevation: 5,
              color: AppTheme.whiteColor,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(70),
                topRight: Radius.circular(70),
              )),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration:  BoxDecoration(
                    color: AppTheme.whiteColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(70),
                      topRight: Radius.circular(70),
                    )),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 30.0,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        headText(txt: "Select Leave Type"),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              buildRequestTypeContainer('Annual Leave'),
                              buildRequestTypeContainer('Casual Leave'),
                              buildRequestTypeContainer('Sick Leave'),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              buildRequestTypeContainer('Maternity'),
                              buildRequestTypeContainer('Business Leave'),
                              buildRequestTypeContainer('Unpaid Leave'),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        customDivider(),
                        const SizedBox(
                          height: 20,
                        ),
                        headText(txt: "Select Date"),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _selectDate(context);
                                },
                                child: Container(
                                  width: 115,
                                  height: 40,
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          width: 1, color: Color(0xFFDDDDDD)),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.calendar_month,
                                          color: Colors.black,
                                          size: 18,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        AppText.appText(
                                            startDate == null
                                                ? "DD/MM/YYYY"
                                                : DateFormat('MM-dd-yyyy')
                                                    .format(startDate!),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            textColor: startDate == null
                                                ? Colors.black
                                                : Colors.black),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _selectDate1(context);
                                },
                                child: Container(
                                  width: 115,
                                  height: 40,
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          width: 1, color: Color(0xFFDDDDDD)),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.calendar_month,
                                          color: Colors.black,
                                          size: 18,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        AppText.appText(
                                            endDate == null
                                                ? "DD/MM/YYYY"
                                                : DateFormat('MM-dd-yyyy')
                                                    .format(endDate!),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            textColor: endDate == null
                                                ? Colors.black
                                                : Colors.black),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        customDivider(),
                        const SizedBox(
                          height: 10,
                        ),
                        headText(txt: "Select Day"),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            buildOptionContainer('Half-Day', 'half', 1),
                            buildOptionContainer('Full-Day', 'full', 2),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        customDivider(),
                        const SizedBox(
                          height: 10,
                        ),
                        headText(txt: "Write Reason"),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10),
                          child: CustomTextField(
                            controller: _descController,
                            lines: 3,
                            hintText: "",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10),
                          child: AppButton.appButton("SUBMIT",
                              backgroundColor: AppTheme.appColor,
                              textColor: AppTheme.whiteColor,
                              height: 45),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget headText({txt}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: AppText.appText("$txt",
          fontSize: 12,
          fontWeight: FontWeight.w500,
          textColor: const Color(0xff898989)),
    );
  }

  Widget buildRequestTypeContainer(String requestType) {
    return GestureDetector(
      onTap: () {
        setSelectedRequestType(requestType);
      },
      child: Container(
        height: 38,
        width: 80,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffE5E5E5), width: 1),
          color: requestType == selectedRequestType
              ? selectedColor
              : defaultColor, // Change color for selected container
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
        ),
        child: Center(
          child: Text(
            requestType,
            style: TextStyle(
                color: requestType == selectedRequestType
                    ? AppTheme.whiteColor
                    : Colors.black,
                fontSize: 10,
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }

  Widget customDivider() {
    return Container(
      height: 1,
      width: MediaQuery.of(context).size.width,
      color: const Color(0xffDADADA),
    );
  }

  Widget buildOptionContainer(String text, String option, int radius) {
    return GestureDetector(
      onTap: () {
        setSelectedOption(option);
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: 54,
        decoration: BoxDecoration(
            color: selectedOption == option
                ? AppTheme.appColor
                : const Color(0xffE5E5E5), //
            borderRadius: radius == 1
                ? const BorderRadius.only(
                    topLeft: Radius.circular(8), bottomLeft: Radius.circular(8))
                : const BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8))),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: selectedOption == option ? AppTheme.white : Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppTheme.appColor, // Change the primary color
            colorScheme: ColorScheme.light(
                primary: AppTheme.appColor), // Change overall color scheme
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != startDate) {
      setState(() {
        startDate = picked;
      });
    }
  }

  Future<void> _selectDate1(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppTheme.appColor, // Change the primary color
            colorScheme: ColorScheme.light(
                primary: AppTheme.appColor), // Change overall color scheme
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != endDate) {
      setState(() {
        endDate = picked;
      });
    }
  }
}

class CustomTextField extends StatefulWidget {
  final controller;
  final hintText;
  final lines;
  CustomTextField({Key? key, this.controller, this.hintText, this.lines})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      maxLines: widget.lines,
      decoration: InputDecoration(
        isDense: true,
        hintText: "${widget.hintText}",
        hintStyle: TextStyle(
            color: Color(0xFF666666),
            fontSize: 14,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            height: 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(width: 1, color: AppTheme.appColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(width: 1, color: AppTheme.appColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(width: 1, color: AppTheme.appColor),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(width: 1, color: AppTheme.appColor),
        ),
      ),
    );
  }
}
