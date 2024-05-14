import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:h_r_m/config/app_urls.dart';
import 'package:h_r_m/config/keys/pref_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeApiProvider extends ChangeNotifier {
  bool isLoading = false;
  var profileDetail;
  String? empDep;
  String? userType;
  String? empId;
  String? userName;
  String? userDes;
  String? userEmail;
  String? userPhone;

  void getUserProfile({
    required dio,
    required BuildContext context,
  }) async {
    isLoading = true;
    Response response;
    int responseCode200 = 200; // For successful request.
    int responseCode400 = 400; // For Bad Request.
    int responseCode401 = 401; // For Unauthorized access.
    int responseCode404 = 404; // For For data not found
    int responseCode422 = 422; // For For data not found

    int responseCode500 = 500; // Internal server error.

    try {
      response = await dio.get(
        path: AppUrls.getEmpProfile,
      );
      var responseData = response.data;
      if (response.statusCode == responseCode400) {
        Fluttertoast.showToast(msg: "${responseData["message"]}");

        isLoading = false;
        notifyListeners();
      } else if (response.statusCode == responseCode401) {
        Fluttertoast.showToast(msg: "${responseData["message"]}");

        isLoading = false;
        notifyListeners();
      } else if (response.statusCode == responseCode404) {
        Fluttertoast.showToast(msg: "${responseData["message"]}");

        isLoading = false;
        notifyListeners();
      } else if (response.statusCode == responseCode500) {
        Fluttertoast.showToast(msg: "${responseData["message"]}");

        isLoading = false;
        notifyListeners();
      } else if (response.statusCode == responseCode422) {
        isLoading = false;
        notifyListeners();
      } else if (response.statusCode == responseCode200) {
        if (responseData["status"] == false) {
          Fluttertoast.showToast(msg: "${responseData["message"]}");

          isLoading = false;
          notifyListeners();

          return;
        } else {
          isLoading = false;
          profileDetail = responseData["user_id"];
          notifyListeners();
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Something went Wrong.");

      isLoading = false;
      notifyListeners();
    }
  }

  getUserDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    empDep = prefs.getString(PrefKey.department);
    userType = prefs.getString(PrefKey.userType);
    empId = prefs.getString(PrefKey.id);
    userName = prefs.getString(PrefKey.userName);
    userPhone = prefs.getString(PrefKey.phone);
    userDes = prefs.getString(PrefKey.designation);
    userEmail = prefs.getString(PrefKey.email);

    notifyListeners();
  }
}
