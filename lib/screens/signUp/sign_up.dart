import 'package:caloriesgram/screens/signIn/sign_in.dart';
import 'package:flutter/material.dart';
import '../../values/app_colors.dart';
import '../../values/app_constants.dart';
import '../../values/app_strings.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  SignUpFormState createState() => SignUpFormState();
}

class SignUpFormState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  String _confirmPassword = '';
  bool _isPasswordHidden = true;
  bool _isConfirmedPasswordHidden = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            const Spacer(),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 24,
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
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(
                          color: AppColors.borderColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please fill your full name';
                      }
                      return null;
                    },
                    //TODO: In future we can add full name validation like email validation
                    onSaved: (value) => _username = value ?? '',
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                        color: AppColors.inputIconColor,
                      ),
                      labelText: "Email",
                      fillColor: AppColors.defaultTextColor,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(
                          color: AppColors.borderColor,
                          width: 2.0,
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
                    //TODO: In future we can add email validation like email validation
                    onSaved: (value) => _username = value ?? '',
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: AppColors.inputIconColor,
                      ),
                      labelText: "Enter Password",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(
                          color: AppColors.borderColor,
                          width: 2.0,
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
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: AppColors.inputIconColor,
                      ),
                      labelText: "Confirm password",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(
                          color: AppColors.borderColor,
                          width: 2.0,
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
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please confirm your password';
                      } else if (value != _password) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    // TODO: In future we can add password validation like email validation
                    onSaved: (value) => _confirmPassword = value ?? '',
                  ),
                  const SizedBox(height: 36),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          _formKey.currentState?.save();
                          print('Username: $_username, Password: $_password');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        minimumSize: const Size(double.infinity, 58),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'SIGN UP',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                      bottom: 4.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "OR",
                          style: TextStyle(
                            color: AppColors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextButton(
                          onPressed: () {
                            // Need to add action
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(0, 56),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            backgroundColor: Colors.transparent,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/google.png'),
                              const Padding(
                                padding: EdgeInsets.only(left: 19.0),
                                child: Text(
                                  "Log in with Google",
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 16,
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
                padding: const EdgeInsets.only(bottom: 38),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black),
                    ),
                    const SizedBox(width: 4),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignInScreen()));
                      },
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                            fontSize: 15.0,
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
