import 'package:caloriesgram/screens/change_password/change_password.dart';
import 'package:caloriesgram/screens/home/home.dart';
import 'package:caloriesgram/screens/language/language.dart';
import 'package:caloriesgram/screens/profile/profile_screen.dart';
import 'package:caloriesgram/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../services/responsive_sizer.dart';


class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar> {
  int myCurrentIndex = 0;
  List pages = const [
    HomeScreen(),
    ChangePasswordScreen(),
    LanguageScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey.withOpacity(0.5),
              width: 1.0,
            ),
          ),
        ),
        margin: EdgeInsets.symmetric(
            horizontal: ResponsiveSizer.horizontalScale(20),
            vertical: ResponsiveSizer.verticalScale(10)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BottomNavigationBar(
            selectedItemColor: AppColors.primaryColor,
            unselectedItemColor: AppColors.tabIconColor,
            currentIndex: myCurrentIndex,
            onTap: (index) {
              setState(() {
                myCurrentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Column(
                  children: [
                    ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        myCurrentIndex == 0
                            ? AppColors.primaryColor
                            : AppColors.tabIconColor,
                        BlendMode.srcIn,
                      ),
                      child: SvgPicture.asset(
                        'assets/images/home.svg',
                        width: ResponsiveSizer.horizontalScale(20),
                        height: ResponsiveSizer.verticalScale(20),
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: ResponsiveSizer.verticalScale(7)),
                  ],
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Column(
                  children: [
                    ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        myCurrentIndex == 1
                            ? AppColors.primaryColor
                            : AppColors.tabIconColor,
                        BlendMode.srcIn,
                      ),
                      child: SvgPicture.asset(
                        'assets/images/saves.svg',
                        width: ResponsiveSizer.horizontalScale(20),
                        height: ResponsiveSizer.verticalScale(20),
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: ResponsiveSizer.verticalScale(7)),
                  ],
                ),
                label: "Saves",
              ),
              BottomNavigationBarItem(
                icon: Column(
                  children: [
                    ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        myCurrentIndex == 2
                            ? AppColors.primaryColor
                            : AppColors.tabIconColor,
                        BlendMode.srcIn,
                      ),
                      child: SvgPicture.asset(
                        'assets/images/camera.svg',
                        width: ResponsiveSizer.horizontalScale(20),
                        height: ResponsiveSizer.verticalScale(20),
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: ResponsiveSizer.verticalScale(7)),
                  ],
                ),
                label: "Camera",
              ),
              BottomNavigationBarItem(
                icon: Column(
                  children: [
                    ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        myCurrentIndex == 3
                            ? AppColors.primaryColor
                            : AppColors.tabIconColor,
                        BlendMode.srcIn,
                      ),
                      child: SvgPicture.asset(
                        'assets/images/profile.svg',
                        width: ResponsiveSizer.horizontalScale(20),
                        height: ResponsiveSizer.verticalScale(20),
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: ResponsiveSizer.verticalScale(7)),
                  ],
                ),
                label: "Profile",
              ),
            ],
            selectedLabelStyle: TextStyle(
                fontSize: ResponsiveSizer.moderateScale(12),
                fontWeight: FontWeight.bold),
            unselectedLabelStyle:
                TextStyle(fontSize: ResponsiveSizer.moderateScale(12)),
            showSelectedLabels: true,
            showUnselectedLabels: true,
          ),
        ),
      ),
      body: pages[myCurrentIndex],
    );
  }
}
