import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../services/google_auth_service.dart';
import '../../services/responsive_sizer.dart';
import '../../values/app_colors.dart';
import '../../values/app_constants.dart';
import '../../values/app_strings.dart';
import '../sign_up/sign_up.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  SignInFormState createState() => SignInFormState();
}

class SignInFormState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  bool _isPasswordHidden = true;
  bool _isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        'Sign in',
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
                      } else {
                        if (AppConstants.emailRegex.hasMatch(value)) {
                          return null;
                        } else {
                          return AppStrings.invalidEmailAddress;
                        }
                      }
                    },
                    onSaved: (value) => _username = value ?? '',
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
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please fill your password';
                      }
                      return null;
                    },

                    // TODO: In future we can add password validation like email validation
                    onSaved: (value) => _password = value ?? '',
                  ),
                  SizedBox(height: ResponsiveSizer.verticalScale(20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Switch(
                            value: _isSwitched,
                            activeColor: AppColors.primaryColor,
                            onChanged: (bool value) {
                              setState(() {
                                _isSwitched = value;
                              });
                            },
                          ),
                          SizedBox(width: ResponsiveSizer.horizontalScale(8)),
                          Text(
                            "Remember Me",
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: ResponsiveSizer.moderateScale(14),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor: AppColors.black,
                            textStyle: TextStyle(
                              fontSize: ResponsiveSizer.moderateScale(14),
                              fontWeight: FontWeight.w400,
                            )),
                        onPressed: () => {},
                        child: const Text('Forgot password?'),
                      ),
                    ],
                  ),
                  SizedBox(height: ResponsiveSizer.verticalScale(36)),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          _formKey.currentState?.save();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        minimumSize: Size(double.infinity,
                            ResponsiveSizer.horizontalScale(58)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              ResponsiveSizer.moderateScale(12)),
                        ),
                      ),
                      child: Text(
                        'SIGN IN',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: ResponsiveSizer.moderateScale(16),
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                  SizedBox(height: ResponsiveSizer.verticalScale(24)),
                  Padding(
                    padding: EdgeInsets.only(
                      top: ResponsiveSizer.verticalScale(8),
                      bottom: ResponsiveSizer.verticalScale(4),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "OR",
                          style: TextStyle(
                            color: AppColors.grey,
                            fontSize: ResponsiveSizer.moderateScale(16),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: ResponsiveSizer.verticalScale(16)),
                        TextButton(
                          onPressed: () {
                            GoogleAuthService().signInWithGoogle();
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize:
                                Size(0, ResponsiveSizer.verticalScale(8)),
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
                      "Don’t have an account?",
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
                                builder: (context) => const SignUpScreen()));
                      },
                      child: Text(
                        'Sign up',
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
