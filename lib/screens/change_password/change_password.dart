import 'package:caloriesgram/values/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../services/responsive_sizer.dart';
import '../profile/profile_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => ChangePasswordScreenState();
}

class ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  String _currentPassword = '';
  String _password = '';
  String _confirmPassword = '';
  bool _isNewPasswordHidden = true;
  bool _isCurrentPasswordHidden = true;
  bool _isConfirmedPasswordHidden = true;

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
                    bottom: ResponsiveSizer.verticalScale(20),
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
                    bottom: ResponsiveSizer.verticalScale(25),
                    left: ResponsiveSizer.horizontalScale(0),
                    right: ResponsiveSizer.horizontalScale(0),
                    child: Center(
                        child: Text('Change Password',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: ResponsiveSizer.moderateScale(22),
                              fontWeight: FontWeight.w600,
                            ))),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: ResponsiveSizer.verticalScale(173),
                left: ResponsiveSizer.horizontalScale(32),
                right: ResponsiveSizer.horizontalScale(32),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                          color: AppColors.inputIconColor,
                        ),
                        labelText: "Current Password",
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
                            _isCurrentPasswordHidden
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _isCurrentPasswordHidden =
                                  !_isCurrentPasswordHidden;
                            });
                          },
                        ),
                      ),
                      obscureText: _isCurrentPasswordHidden,
                      onChanged: (value) {
                        setState(() {
                          _currentPassword = value;
                        });
                      },
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please fill your current password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: ResponsiveSizer.verticalScale(21)),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                          color: AppColors.inputIconColor,
                        ),
                        labelText: "New Password",
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
                            _isNewPasswordHidden
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _isNewPasswordHidden = !_isNewPasswordHidden;
                            });
                          },
                        ),
                      ),
                      obscureText: _isNewPasswordHidden,
                      onChanged: (value) {
                        setState(() {
                          _password = value;
                        });
                      },
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please fill your new password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: ResponsiveSizer.verticalScale(21)),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                          color: AppColors.inputIconColor,
                        ),
                        labelText: "Confirm New Password",
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
                          return 'Please confirm your new password';
                        }
                        if (value != _password) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: ResponsiveSizer.verticalScale(30)),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          _formKey.currentState?.save();

                          try {
                            User? user = FirebaseAuth.instance.currentUser;
                            if (user != null) {
                              final credential = EmailAuthProvider.credential(
                                email: user.email!,
                                password: _currentPassword,
                              );
                              await user
                                  .reauthenticateWithCredential(credential);

                              await user.updatePassword(_password);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text("Password changed successfully."),
                                ),
                              );
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProfileScreen()),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Failed to change password."),
                                ),
                              );
                            }
                          } catch (e) {
                            if (e is FirebaseAuthException &&
                                e.code == 'wrong-password') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "The current password is entered incorrectly."),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Error: $e"),
                                ),
                              );
                            }
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: AppColors.white,
                        minimumSize: Size(
                            double.infinity, ResponsiveSizer.verticalScale(58)),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              ResponsiveSizer.moderateScale(12)),
                        ),
                      ),
                      child: Text(
                        'SUBMIT',
                        style: TextStyle(
                          fontSize: ResponsiveSizer.moderateScale(18),
                          fontWeight: FontWeight.w600,
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
