import 'package:caloriesgram/services/firebase_auth_by_email_and_password.dart';
import 'package:flutter/material.dart';
import '../../services/responsive_sizer.dart';
import '../../values/app_colors.dart';
import '../../values/app_constants.dart';
import '../../values/app_strings.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({
    super.key,
  });

  @override
  ResetPasswordScreenState createState() => ResetPasswordScreenState();
}

class ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _authService = FirebaseAuthService();
  final _email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left,
              size: ResponsiveSizer.verticalScale(30)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: ResponsiveSizer.horizontalScale(32)),
        children: [
          SizedBox(height: ResponsiveSizer.verticalScale(13)),
          Text(
            'Please enter your email address to\nrequest a password reset',
            style: TextStyle(
                fontSize: ResponsiveSizer.moderateScale(15),
                fontWeight: FontWeight.w400,
                color: AppColors.black),
          ),
          SizedBox(height: ResponsiveSizer.verticalScale(27)),
          TextFormField(
            controller: _email,
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.email_outlined,
                color: AppColors.inputIconColor,
              ),
              labelText: "Email",
              fillColor: AppColors.defaultTextColor,
              focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(ResponsiveSizer.moderateScale(12)),
                borderSide: const BorderSide(
                  color: AppColors.primaryColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(ResponsiveSizer.moderateScale(12)),
                borderSide: BorderSide(
                  color: AppColors.borderColor,
                  width: ResponsiveSizer.horizontalScale(2),
                ),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return AppStrings.pleaseEnterEmailAddress;
              } else {
                if (AppConstants.emailRegex.hasMatch(value)) {
                  return null;
                } else {
                  return AppStrings.invalidEmailAddress;
                }
              }
            },
          ),
          SizedBox(height: ResponsiveSizer.verticalScale(40)),
          SizedBox(
            width: double.infinity,
            height: ResponsiveSizer.verticalScale(58),
            child: ElevatedButton(
              onPressed: () async {
                await _authService.resetPassword(_email.text);
                await ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "A message to reset your password has been sent to your email.",
                      style: TextStyle(color: AppColors.primaryColor),
                    ),
                  ),
                );
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(ResponsiveSizer.moderateScale(15)),
                ),
              ),
              child: Text('SEND',
                  style: TextStyle(
                      fontSize: ResponsiveSizer.moderateScale(16),
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
