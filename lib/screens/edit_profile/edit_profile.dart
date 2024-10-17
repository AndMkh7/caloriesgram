import 'package:caloriesgram/services/firestore.dart';
import 'package:caloriesgram/values/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../services/responsive_sizer.dart';
import '../../values/app_constants.dart';
import '../../values/app_strings.dart';

class EditProfileScreen extends StatefulWidget {
  final String fullName;
  final String email;
  const EditProfileScreen(
      {super.key, required this.fullName, required this.email});

  @override
  State<EditProfileScreen> createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  Future<void> _updateFullName() async {
    await FirestoreService().updateFullName(_fullName);
  }

  @override
  void initState() {
    super.initState();
    _fullName = widget.fullName;
    _email = widget.email;
  }
  String _fullName = '';
  String _email = '';
  User? user = FirebaseAuth.instance.currentUser;
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
              _fullName,
              style: TextStyle(
                fontSize: ResponsiveSizer.moderateScale(24),
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: ResponsiveSizer.verticalScale(5)),
            Text(
              _email,
              style: TextStyle(
                fontSize: ResponsiveSizer.moderateScale(14),
                fontWeight: FontWeight.w400,
                color: AppColors.greyText,
              ),
            ),
            Padding(
                padding: EdgeInsets.only(
                    top: ResponsiveSizer.verticalScale(73),
                    left: ResponsiveSizer.horizontalScale(32),
                    right: ResponsiveSizer.horizontalScale(32)),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.person,
                          color: AppColors.inputIconColor,
                        ),
                        labelText: "Full name",
                        fillColor: AppColors.defaultTextColor,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              ResponsiveSizer.moderateScale(12)),
                          borderSide: const BorderSide(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              ResponsiveSizer.moderateScale(12)),
                          borderSide: BorderSide(
                            color: AppColors.borderColor,
                            width: ResponsiveSizer.horizontalScale(2),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please fill your full name';
                        } else if (value!.length > 35) {
                          return 'The maximum number of characters is 35.';
                        }
                        return null;
                      },
                      onSaved: (value) async {
                        setState(() {
                          _fullName = value!;
                        });
                      },
                    ),
                    SizedBox(height: ResponsiveSizer.verticalScale(20)),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          color: AppColors.inputIconColor,
                        ),
                        labelText: "Email",
                        fillColor: AppColors.defaultTextColor,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              ResponsiveSizer.moderateScale(12)),
                          borderSide: const BorderSide(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              ResponsiveSizer.moderateScale(12)),
                          borderSide: BorderSide(
                            color: AppColors.borderColor,
                            width: ResponsiveSizer.horizontalScale(2),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppStrings.pleaseEnterEmailAddress;
                        } else if (!AppConstants.emailRegex.hasMatch(value)) {
                          return AppStrings.invalidEmailAddress;
                        }
                        return null;
                      },
                      onSaved: (value) => _email = value ?? '',
                    ),
                    SizedBox(height: ResponsiveSizer.verticalScale(21)),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          await _updateFullName();

                          Navigator.pop(context, _fullName);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        minimumSize: Size(
                            double.infinity, ResponsiveSizer.verticalScale(58)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              ResponsiveSizer.moderateScale(15)),
                        ),
                      ),
                      child: Text(
                        'SUBMIT',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: ResponsiveSizer.moderateScale(16),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
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
  final VoidCallback onTap;
  final Widget? trailing;

  const ProfileListTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.trailing,
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
