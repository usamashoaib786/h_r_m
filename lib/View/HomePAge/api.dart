import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:h_r_m/Utils/utils.dart';
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
        showSnackBar(context, "${responseData["message"]}");

        isLoading = false;
        notifyListeners();
      } else if (response.statusCode == responseCode401) {
        showSnackBar(context, "${responseData["message"]}");

        isLoading = false;
        notifyListeners();
      } else if (response.statusCode == responseCode404) {
        showSnackBar(context, "${responseData["message"]}");

        isLoading = false;
        notifyListeners();
      } else if (response.statusCode == responseCode500) {
        showSnackBar(context, "${responseData["message"]}");

        isLoading = false;
        notifyListeners();
      } else if (response.statusCode == responseCode422) {
        isLoading = false;
        notifyListeners();
      } else if (response.statusCode == responseCode200) {
        if (responseData["status"] == false) {
          showSnackBar(context, "${responseData["message"]}");

          isLoading = false;
          notifyListeners();

          return;
        } else {
          isLoading = false;
          profileDetail = responseData["user_id"];
          print("mgflf,l$profileDetail");
          notifyListeners();
        }
      }
    } catch (e) {
      print("Something went Wrong ${e}");
      showSnackBar(context, "Something went Wrong.");

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
