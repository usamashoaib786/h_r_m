import 'package:flutter/material.dart';
import 'package:h_r_m/Utils/resources/res/app_theme.dart';
import 'package:h_r_m/Utils/widgets/others/app_button.dart';
import 'package:h_r_m/Utils/widgets/others/app_text.dart';

class CustomPopUp extends StatefulWidget {
  const CustomPopUp({
    super.key,
  });

  @override
  State<CustomPopUp> createState() => _CustomPopUpState();
}

class _CustomPopUpState extends State<CustomPopUp> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        titlePadding: const EdgeInsets.all(0),
        shadowColor: Colors.blue,
        title: Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.appText('Logout',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    textColor: Colors.black),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:20.0),
                  child: AppText.appText('Are you sure you want to logout?',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      textColor: Colors.black),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AppButton.appButton("Cancel", onTap: () {
                      Navigator.pop(context);
                    },
                        height: 30,
                        border: false,
                        width: 89,
                        backgroundColor: Color(0xffBCACAC),
                        textColor: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                    AppButton.appButton("Logout", onTap: () {
                      Navigator.pop(context);
                    },
                        height: 30,
                        width: 89,
                        border: false,
                        backgroundColor: AppTheme.appColor,
                        textColor: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
