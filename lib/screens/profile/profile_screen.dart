import 'package:caloriesgram/screens/body_measurements/body_measurement.dart';
import 'package:caloriesgram/screens/change_password/change_password.dart';
import 'package:caloriesgram/screens/edit_profile/edit_profile.dart';
import 'package:caloriesgram/screens/language/language.dart';
import 'package:caloriesgram/screens/privacy_policy/privacy_policy.dart';
import 'package:caloriesgram/values/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../services/firestore.dart';
import '../../services/responsive_sizer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  String fullName = '';
  String email = '';
  bool? isNotificationsTurnedOn;
  String selectedLanguage = '';

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    if (user != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('Users')
            .doc(user!.email)
            .get();

        if (userDoc.exists) {
          print('Document exists: ${userDoc.data()}');
          setState(() {
            fullName = userDoc.get('fullName') ?? 'No Name';
            email = userDoc.get('email') ?? user!.email!;
            isNotificationsTurnedOn = userDoc.get('isNotificationsTurnedOn');
            selectedLanguage = userDoc.get('selectedLanguage');
          });
        } else {
          print('Document does not exist');
        }
      } catch (e) {
        print('Error fetching user data: $e');
      }
    } else {
      print('User is null');
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.primaryColor,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: ResponsiveSizer.verticalScale(130),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft:
                      Radius.circular(ResponsiveSizer.moderateScale(30)),
                  bottomRight:
                      Radius.circular(ResponsiveSizer.moderateScale(30)),
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: ResponsiveSizer.verticalScale(48),
                    left: ResponsiveSizer.horizontalScale(10),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.keyboard_arrow_left,
                          color: AppColors.white,
                          size: ResponsiveSizer.moderateScale(30)),
                    ),
                  ),
                  Positioned(
                    top: ResponsiveSizer.verticalScale(60),
                    left: ResponsiveSizer.horizontalScale(0),
                    right: ResponsiveSizer.horizontalScale(0),
                    child: Center(
                      child: CircleAvatar(
                        radius: ResponsiveSizer.moderateScale(60),
                        backgroundImage: const NetworkImage(
                            'https://image.tmdb.org/t/p/original/tyZ2r0tiPtTkE2udDEVbNXnMV4v.jpg'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: ResponsiveSizer.verticalScale(55)),
     
            Text(
              fullName,
              style: TextStyle(
                fontSize: ResponsiveSizer.moderateScale(24),
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: ResponsiveSizer.verticalScale(5)),
            Text(
              email,
              style: TextStyle(
                fontSize: ResponsiveSizer.moderateScale(14),
                fontWeight: FontWeight.w400,
                color: AppColors.greyText,
              ),
            ),
            SizedBox(height: ResponsiveSizer.verticalScale(30)),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: ResponsiveSizer.horizontalScale(20)),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: ResponsiveSizer.moderateScale(2),
                    blurRadius: ResponsiveSizer.moderateScale(5),
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  ProfileListTile(
                    icon: Container(
                      height: ResponsiveSizer.verticalScale(20),
                      width: ResponsiveSizer.horizontalScale(20),
                      alignment: Alignment.center,
                      child: SvgPicture.asset('assets/images/edit-profile.svg',
                          width: ResponsiveSizer.horizontalScale(14),
                          height: ResponsiveSizer.verticalScale(14)),
                    ),
                    title: Text(
                      'Edit profile information',
                      style: TextStyle(
                          fontSize: ResponsiveSizer.moderateScale(14),
                          fontWeight: FontWeight.w400,
                          color: AppColors.black),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProfileScreen(
                                fullName: fullName, email: email)),
                      ).then((updatedFullName) {
                        if (updatedFullName != null) {
                          setState(() {
                            fullName =
                                updatedFullName; 
                          });
                        }
                      });
                    },
                  ),
                  ProfileListTile(
                    icon: Container(
                      height: ResponsiveSizer.verticalScale(20),
                      width: ResponsiveSizer.horizontalScale(20),
                      alignment: Alignment.center,
                      child: SvgPicture.asset('assets/images/body.svg',
                          width: ResponsiveSizer.horizontalScale(14),
                          height: ResponsiveSizer.verticalScale(14)),
                    ),
                    title: Text(
                      'Body measurements',
                      style: TextStyle(
                          fontSize: ResponsiveSizer.moderateScale(14),
                          fontWeight: FontWeight.w400,
                          color: AppColors.black),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BodyMeasurementsScreen(),
                        ),
                      );
                    },
                  ),
                  ProfileListTile(
                    icon: Container(
                      height: ResponsiveSizer.verticalScale(20),
                      width: ResponsiveSizer.horizontalScale(20),
                      alignment: Alignment.center,
                      child: SvgPicture.asset('assets/images/lock.svg',
                          width: ResponsiveSizer.horizontalScale(14),
                          height: ResponsiveSizer.verticalScale(14)),
                    ),
                    title: Text(
                      'Change Password',
                      style: TextStyle(
                          fontSize: ResponsiveSizer.moderateScale(14),
                          fontWeight: FontWeight.w400,
                          color: AppColors.black),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChangePasswordScreen(),
                        ),
                      );
                    },
                  ),
                  SwitchListTile(
                    activeColor: AppColors.white,
                    activeTrackColor: AppColors.primaryColor,
                    secondary: Container(
                      height: ResponsiveSizer.verticalScale(20),
                      width: ResponsiveSizer.horizontalScale(20),
                      alignment: Alignment.center,
                      child: SvgPicture.asset('assets/images/notification.svg',
                          width: ResponsiveSizer.horizontalScale(14),
                          height: ResponsiveSizer.verticalScale(14)),
                    ),
                    title: Text(
                      'Notifications',
                      style: TextStyle(
                          fontSize: ResponsiveSizer.moderateScale(14),
                          fontWeight: FontWeight.w400,
                          color: AppColors.black),
                    ),

                    value: isNotificationsTurnedOn ?? false,
                    onChanged: (value) async {
                      setState(() {
                        isNotificationsTurnedOn = value;
                      });

                      await FirestoreService()
                          .updateNotificationPreference(value);
                    },

                  ),
                  ProfileListTile(
                    icon: Container(
                      height: ResponsiveSizer.verticalScale(20),
                      width: ResponsiveSizer.horizontalScale(20),
                      alignment: Alignment.center,
                      child: SvgPicture.asset('assets/images/language.svg',
                          width: ResponsiveSizer.horizontalScale(14),
                          height: ResponsiveSizer.verticalScale(14)),
                    ),
                    title: Text(
                      'Language',
                      style: TextStyle(
                          fontSize: ResponsiveSizer.moderateScale(14),
                          fontWeight: FontWeight.w400,
                          color: AppColors.black),
                    ),
                    trailing: Text(
                      selectedLanguage,
                      style: TextStyle(
                          fontSize: ResponsiveSizer.moderateScale(14),
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryColor),
                    ),
                    onTap: () async {
                      final language = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LanguageScreen(),
                        ),
                      );
                      if (language != null) {
                        setState(() {
                          selectedLanguage = language;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: ResponsiveSizer.verticalScale(16)),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: ResponsiveSizer.verticalScale(20)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: ResponsiveSizer.moderateScale(2),
                    blurRadius: ResponsiveSizer.moderateScale(5),
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  ProfileListTile(
                    icon: Container(
                      height: ResponsiveSizer.verticalScale(20),
                      width: ResponsiveSizer.horizontalScale(20),
                      alignment: Alignment.center,
                      child: SvgPicture.asset('assets/images/support.svg',
                          width: ResponsiveSizer.horizontalScale(14),
                          height: ResponsiveSizer.verticalScale(14)),
                    ),
                    title: Text(
                      'Contact us',
                      style: TextStyle(
                          fontSize: ResponsiveSizer.moderateScale(14),
                          fontWeight: FontWeight.w400,
                          color: AppColors.black),
                    ),
                    onTap: () {},
                  ),
                  ProfileListTile(
                    icon: Container(
                      height: ResponsiveSizer.verticalScale(20),
                      width: ResponsiveSizer.horizontalScale(20),
                      alignment: Alignment.center,
                      child: SvgPicture.asset('assets/images/privacy.svg',
                          width: ResponsiveSizer.horizontalScale(14),
                          height: ResponsiveSizer.verticalScale(14)),
                    ),
                    title: Text(
                      'Privacy policy',
                      style: TextStyle(
                          fontSize: ResponsiveSizer.moderateScale(14),
                          fontWeight: FontWeight.w400,
                          color: AppColors.black),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PrivacyPolicyScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileListTile extends StatelessWidget {
  final Widget icon;
  final Widget title;
  final Widget? trailing;
  final VoidCallback? onTap;

  const ProfileListTile({
    super.key, 
    required this.icon,
    required this.title,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: title,
      trailing: trailing,
      onTap: onTap,
    );
  }
}
