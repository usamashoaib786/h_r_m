import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:h_r_m/Constants/app_logger.dart';
import 'package:h_r_m/Utils/resources/res/app_theme.dart';
import 'package:h_r_m/Utils/widgets/others/app_text.dart';
import 'package:h_r_m/View/HomePAge/api.dart';
import 'package:h_r_m/config/app_urls.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:h_r_m/config/dio/app_dio.dart';
import 'package:h_r_m/config/keys/pref_keys.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _pickedFilePath;
  late AppDio dio;
  bool isLoading = false;
  AppLogger logger = AppLogger();
  var department;
  @override
  void initState() {
    dio = AppDio(context);
    logger.init();
    getUserDetail();
    super.initState();
  }

  getUserDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      department = prefs.getString(PrefKey.department);
      print("knf$department");
    });
  }

  pickImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _pickedFilePath = image.path;
        updateProfile();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final homeApi = Provider.of<HomeApiProvider>(context);
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
                    child: GestureDetector(
                      onTap: () {
                        pickImage();
                      },
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)),
                        child: Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                              color: AppTheme.white, shape: BoxShape.circle),
                          child: _pickedFilePath != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.file(
                                    File(_pickedFilePath!),
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.fill,
                                  ),
                                )
                              : homeApi.profileDetail == null
                                  ? null
                                  : homeApi.profileDetail["avatar"] == null
                                      ? Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Image.asset(
                                            "assets/images/profileImg.png",
                                            height: 66,
                                            width: 66,
                                          ),
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.network(
                                            "https://hr.digitalmandee.com/profile_picture/${homeApi.profileDetail["avatar"]}",
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            homeApi.profileDetail == null
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40.0),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppTheme.appColor,
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 30),
                    child: Column(
                      children: [
                        AppText.appText("${homeApi.profileDetail["name"]}",
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            textColor: Colors.black),
                        AppText.appText(
                            "${homeApi.profileDetail["designation"]["designation"]}",
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            textColor: const Color(0xff8C8C8C)),
                        const SizedBox(
                          height: 20,
                        ),
                        customRow(
                            txt1: "E-mail",
                            txt2: "${homeApi.profileDetail["email"]}",
                            img: "assets/images/mail.png"),
                        customRow(
                            txt1: "Phone Number",
                            txt2: "${homeApi.profileDetail["contact_no_one"]}",
                            img: "assets/images/phone1.png"),
                        customRow(
                            txt1: "Designation",
                            txt2:
                                "${homeApi.profileDetail["designation"]["designation"]}",
                            img: "assets/images/designation1.png"),
                        customRow(
                            txt1: "Department",
                            txt2: "$department",
                            img: "assets/images/department1.png"),
                        customRow(
                            txt1: "Employee ID",
                            txt2:
                                "Employee ID.DTM-${homeApi.profileDetail["id"]}",
                            img: "assets/images/person.png"),
                      ],
                    ),
                  ),
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
    return Column(
      children: [
        Padding(
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
                      textColor: const Color(0xff1A1A1A),
                      fontWeight: FontWeight.w500),
                  AppText.appText("$txt2",
                      fontSize: 14,
                      textColor: const Color(0xff515151),
                      fontWeight: FontWeight.w400),
                ],
              )
            ],
          ),
        ),
        divider(),
      ],
    );
  }

  void updateProfile() async {
    final homeApi = Provider.of<HomeApiProvider>(context, listen: false);

    setState(() {
      isLoading = true;
    });
    Response response;
    int responseCode200 = 200; // For successful request.
    int responseCode400 = 400; // For Bad Request.
    int responseCode401 = 401; // For Unauthorized access.
    int responseCode404 = 404; // For For data not found
    int responseCode422 = 422; // For For data not found
    int responseCode500 = 500; // Internal server error.
    var name = homeApi.profileDetail["name"].replaceAll('"', '');
    var contact = homeApi.profileDetail["contact_no_one"].replaceAll('"', '');
    var gender = homeApi.profileDetail["gender"].replaceAll('"', '');
    var web = homeApi.profileDetail["web"]?.replaceAll('"', '');
    var dob = homeApi.profileDetail["date_of_birth"].replaceAll('"', '');
    var pADD = homeApi.profileDetail["present_address"].replaceAll('"', '');
    var perADD = homeApi.profileDetail["permanent_address"].replaceAll('"', '');

    File profilePhoto = File(_pickedFilePath!);
    var formData = FormData.fromMap({
      "name": name,
      "contact_no_one": contact,
      "gender": gender,
      "web": web,
      "avatar": await MultipartFile.fromFile(profilePhoto.path),
      "date_of_birth": dob,
      "present_address": pADD,
      "permanent_address": perADD,
    });

    // print("name$name");
    // Map<String, dynamic> params = {
    //   "name": name,
    //   "contact_no_one": contact,
    //   "gender": gender,
    //   "web": web,
    //   "avatar": await MultipartFile.fromFile(profilePhoto.path),
    //   "date_of_birth": "2001-05-01",
    //   "present_address": pADD,
    //   "permanent_address": perADD,
    // };
    try {
      response = await dio.post(path: AppUrls.updateProfile, data: formData);
      var responseData = response.data;
      if (response.statusCode == responseCode400) {
        Fluttertoast.showToast(msg: "${responseData["message"]}");
        setState(() {
          isLoading = false;
        });
      } else if (response.statusCode == responseCode401) {
        Fluttertoast.showToast(msg: "${responseData["message"]}");
        setState(() {
          isLoading = false;
        });
      } else if (response.statusCode == responseCode404) {
        Fluttertoast.showToast(msg: "${responseData["message"]}");
        setState(() {
          isLoading = false;
        });
      } else if (response.statusCode == responseCode500) {
        Fluttertoast.showToast(msg: "${responseData["message"]}");
        setState(() {
          isLoading = false;
        });
      } else if (response.statusCode == responseCode422) {
        setState(() {
          isLoading = false;
        });
      } else if (response.statusCode == responseCode200) {
        if (responseData["status"] == false) {
          Fluttertoast.showToast(msg: "${responseData["message"]}");
          setState(() {
            isLoading = false;
          });

          return;
        } else {
          Fluttertoast.showToast(msg: "Profile Update Successfully");
          setState(() {
            isLoading = false;
          });
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Something went Wrong.");
      setState(() {
        isLoading = false;
      });
    }
  }
}
