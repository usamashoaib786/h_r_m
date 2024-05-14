import 'package:flutter/material.dart';
import 'package:h_r_m/Utils/resources/res/app_theme.dart';
import 'package:h_r_m/View/HomePAge/home_screen.dart';
import 'package:h_r_m/View/Profile%20Screen/profile_screen.dart';

class BottomNavView extends StatefulWidget {
  const BottomNavView({super.key});

  @override
  State<BottomNavView> createState() => _BottomNavViewState();
}

class _BottomNavViewState extends State<BottomNavView> {
  var _currentIndex = 0;
  List screens = [
    const LandingScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 70,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                },
                child: Container(
                  height: 42,
                  width: 62,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: _currentIndex != 0
                        ? AppTheme.whiteColor
                        : AppTheme.appColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/images/home.png",
                      color: _currentIndex == 0
                          ? AppTheme.whiteColor
                          : AppTheme.appColor,
                      height: 24,
                    ),
                  ),
                ),
              ),
                GestureDetector(
                onTap: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
                child: Container(
                  height: 42,
                  width: 62,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: _currentIndex != 1
                        ? AppTheme.whiteColor
                        : AppTheme.appColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/images/profile.png",
                      color: _currentIndex == 1
                          ? AppTheme.whiteColor
                          : AppTheme.appColor,
                      height: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: screens[_currentIndex],
    );
  }
}
