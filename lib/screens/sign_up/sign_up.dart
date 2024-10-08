import 'package:flutter/material.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter_svg/svg.dart';

import '../../services/google_auth_service.dart';
import '../../services/responsive_sizer.dart';
import '../../values/app_colors.dart';
import '../../values/app_constants.dart';
import '../../values/app_strings.dart';
import '../sign_in/sign_in.dart';
import '../verification/verification.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  SignUpFormState createState() => SignUpFormState();
}

class SignUpFormState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String _fullName = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  bool _isPasswordHidden = true;
  bool _isConfirmedPasswordHidden = true;

  Future<void> _sendOTPAndNavigate() async {
    bool isOTPSent = await EmailOTP.sendOTP(email: _email);
    if (!mounted) return;

    if (isOTPSent) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Verification(email: _email),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to send OTP. Please try again.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: ResponsiveSizer.horizontalScale(32)),
        child: Column(
          children: [
            const Spacer(),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: ResponsiveSizer.verticalScale(20)),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: ResponsiveSizer.moderateScale(24),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
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
                    onSaved: (value) => _fullName = value ?? '',
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
                  SizedBox(height: ResponsiveSizer.verticalScale(20)),
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: AppColors.inputIconColor,
                      ),
                      labelText: "Enter Password",
                      fillColor: Colors.white,
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
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordHidden
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordHidden = !_isPasswordHidden;
                          });
                        },
                      ),
                    ),
                    obscureText: _isPasswordHidden,
                    onChanged: (value) {
                      setState(() {
                        _password = value;
                      });
                    },
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please fill your password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: ResponsiveSizer.verticalScale(20)),
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: AppColors.inputIconColor,
                      ),
                      labelText: "Confirm password",
                      fillColor: Colors.white,
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
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isConfirmedPasswordHidden
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _isConfirmedPasswordHidden =
                                !_isConfirmedPasswordHidden;
                          });
                        },
                      ),
                    ),
                    obscureText: _isConfirmedPasswordHidden,
                    onChanged: (value) {
                      setState(() {
                        _confirmPassword = value;
                      });
                    },
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please confirm your password';
                      } else if (value != _password) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: ResponsiveSizer.verticalScale(36)),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        _formKey.currentState?.save();
                        await _sendOTPAndNavigate();
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
                      'SIGN UP',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: ResponsiveSizer.moderateScale(16),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: ResponsiveSizer.verticalScale(24)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: ResponsiveSizer.verticalScale(16)),
                    child: Text(
                      "OR",
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: ResponsiveSizer.moderateScale(16),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      GoogleAuthService().signInWithGoogle();
                          },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size(0, ResponsiveSizer.verticalScale(56)),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      backgroundColor: Colors.transparent,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/images/google.svg'),
                        Padding(
                          padding: EdgeInsets.only(
                              left: ResponsiveSizer.horizontalScale(19)),
                          child: Text(
                            "Log in with Google",
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: ResponsiveSizer.moderateScale(16),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    EdgeInsets.only(bottom: ResponsiveSizer.verticalScale(38)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                          fontSize: ResponsiveSizer.moderateScale(15),
                          fontWeight: FontWeight.w400,
                          color: AppColors.black),
                    ),
                    SizedBox(width: ResponsiveSizer.horizontalScale(4)),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignInScreen()));
                      },
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                            fontSize: ResponsiveSizer.moderateScale(15),
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryColor),
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
