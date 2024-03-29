import 'package:flutter/material.dart';
import 'package:h_r_m/Constants/app_logger.dart';
import 'package:h_r_m/Utils/resources/res/app_theme.dart';
import 'package:h_r_m/Utils/utils.dart';
import 'package:h_r_m/Utils/widgets/others/app_button.dart';
import 'package:h_r_m/Utils/widgets/others/app_text.dart';
import 'package:h_r_m/config/app_urls.dart';
import 'package:h_r_m/config/dio/app_dio.dart';
import 'package:intl/intl.dart';

class RequestLeave extends StatefulWidget {
  final userId;
  const RequestLeave({super.key, this.userId});

  @override
  State<RequestLeave> createState() => _RequestLeaveState();
}

class _RequestLeaveState extends State<RequestLeave> {
  String selectedRequestType = 'Annual Leave';
  DateTime? startDate;
  DateTime? endDate;
  var leaveTypes;
  var leaveTypeId = "3";
  var leavedayType;

  TextEditingController _descController = TextEditingController();
  Color defaultColor =
      const Color(0xffFFFFFF); // Default color for all containers
  Color selectedColor = AppTheme.appColor; // Color for the selected container

  void setSelectedRequestType({String? requestType, id}) {
    setState(() {
      selectedRequestType = requestType!;
      leaveTypeId = id;
    });
  }

  String selectedOption = 'half'; // Variable to store selected option

  void setSelectedOption({String? option, type}) {
    setState(() {
      selectedOption = option!;
      leavedayType = type;
    });
  }

  bool _isLoading = false;
  late AppDio dio;
  AppLogger logger = AppLogger();
  @override
  void initState() {
    dio = AppDio(context);
    logger.init();
    getleaveTypes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("object$leaveTypeId");
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
                decoration: BoxDecoration(
                    color: AppTheme.whiteColor,
                    borderRadius: const BorderRadius.only(
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
                          child: GridView.builder(
                            shrinkWrap: true,
                            itemCount: leaveTypes.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 20,
                              childAspectRatio: 2.5,
                              crossAxisCount: 3,
                            ),
                            itemBuilder: (context, index) {
                              print("id${leaveTypes[index]["id"]}");
                              return buildRequestTypeContainer(
                                requestType:
                                    "${leaveTypes[index]["leave_category"]}",
                                id: "${leaveTypes[index]["id"]}",
                              );
                            },
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
                            buildOptionContainer(
                                text: 'Half-Day',
                                option: 'half',
                                radius: 1,
                                type: 1),
                            buildOptionContainer(
                                text: 'Full-Day',
                                option: 'full',
                                radius: 2,
                                type: 2),
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
                          child: AppButton.appButton("SUBMIT", onTap: () {
                            leaveRequest();
                          },
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

  Widget buildRequestTypeContainer({String? requestType, id}) {
    return GestureDetector(
      onTap: () {
        setSelectedRequestType(requestType: requestType, id: id);
      },
      child: Container(
        height: 38,
        width: 80,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffE5E5E5), width: 1),
          color: requestType == selectedRequestType
              ? selectedColor
              : defaultColor, // Change color for selected container
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
        ),
        child: Center(
          child: Text(
            requestType!,
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

  Widget buildOptionContainer(
      {String? text, String? option, int? radius, type}) {
    return GestureDetector(
      onTap: () {
        setSelectedOption(option: option, type: type);
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
            text!,
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

  void getleaveTypes() async {
    setState(() {
      _isLoading = true;
    });
    var response;
    int responseCode200 = 200; // For successful request.
    int responseCode400 = 400; // For Bad Request.
    int responseCode401 = 401; // For Unauthorized access.
    int responseCode404 = 404; // For For data not found
    int responseCode422 = 422; // For For data not found

    int responseCode500 = 500; // Internal server error.

    try {
      response = await dio.get(path: AppUrls.getLeaveTypes);
      var responseData = response.data;
      if (response.statusCode == responseCode400) {
        showSnackBar(context, "${responseData["message"]}");
        setState(() {
          _isLoading = false;
        });
      } else if (response.statusCode == responseCode401) {
        showSnackBar(context, "${responseData["message"]}");
        setState(() {
          _isLoading = false;
        });
      } else if (response.statusCode == responseCode404) {
        showSnackBar(context, "${responseData["message"]}");
        setState(() {
          _isLoading = false;
        });
      } else if (response.statusCode == responseCode500) {
        showSnackBar(context, "${responseData["message"]}");
        setState(() {
          _isLoading = false;
        });
      } else if (response.statusCode == responseCode422) {
        setState(() {
          _isLoading = false;
        });
      } else if (response.statusCode == responseCode200) {
        if (responseData["status"] == false) {
          showSnackBar(context, "${responseData["message"]}");
          setState(() {
            _isLoading = false;
          });

          return;
        } else {
          setState(() {
            _isLoading = false;
            leaveTypes = responseData["leave_categories"];
          });
        }
      }
    } catch (e) {
      print("Something went Wrong ${e}");
      showSnackBar(context, "Something went Wrong.");
      setState(() {
        _isLoading = false;
      });
    }
  }

  void leaveRequest() async {
    setState(() {
      _isLoading = true;
    });
    var response;
    int responseCode200 = 200; // For successful request.
    int responseCode400 = 400; // For Bad Request.
    int responseCode401 = 401; // For Unauthorized access.
    int responseCode404 = 404; // For For data not found
    int responseCode422 = 422; // For For data not found

    int responseCode500 = 500; // Internal server error.
    Map<String, dynamic> params = {
      "created_by": widget.userId,
      "leave_category_id": leaveTypeId,
      "start_date": startDate,
      "end_date": endDate,
      "leave_type": leavedayType,
      "reason": _descController.text,
    };
    try {
      response = await dio.post(path: AppUrls.requestLeave, data: params);
      var responseData = response.data;
      if (response.statusCode == responseCode400) {
        showSnackBar(context, "${responseData["message"]}");
        setState(() {
          _isLoading = false;
        });
      } else if (response.statusCode == responseCode401) {
        showSnackBar(context, "${responseData["message"]}");
        setState(() {
          _isLoading = false;
        });
      } else if (response.statusCode == responseCode404) {
        showSnackBar(context, "${responseData["message"]}");
        setState(() {
          _isLoading = false;
        });
      } else if (response.statusCode == responseCode500) {
        showSnackBar(context, "${responseData["message"]}");
        setState(() {
          _isLoading = false;
        });
      } else if (response.statusCode == responseCode422) {
        setState(() {
          _isLoading = false;
        });
      } else if (response.statusCode == responseCode200) {
        if (responseData["status"] == false) {
          showSnackBar(context, "${responseData["message"]}");
          setState(() {
            _isLoading = false;
          });

          return;
        } else {
          showSnackBar(context, "${responseData["message"]}");
          setState(() {
            startDate = null;
            endDate = null;
            _descController.clear();
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      print("Something went Wrong ${e}");
      showSnackBar(context, "Something went Wrong.");
      setState(() {
        _isLoading = false;
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
        hintStyle: const TextStyle(
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
