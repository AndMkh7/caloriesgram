import 'dart:async';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import '../../services/responsive_sizer.dart';
import '../../values/app_colors.dart';
import '../sign_in/sign_in.dart';

class Verification extends StatefulWidget {
  final String email;
  const Verification({super.key, required this.email});

  @override
  VerificationState createState() => VerificationState();
}

class VerificationState extends State<Verification> {
  int _secondsRemaining = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _timer?.cancel();
        _resendOTP();
      }
    });
  }

  void _resendOTP() async {
    bool isOTPSent = await EmailOTP.sendOTP(email: widget.email);
    if (isOTPSent) {
      setState(() {
        _secondsRemaining = 60;
      });
      _startTimer();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("New OTP has been sent to your email.")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Failed to resend OTP. Please try again.")),
      );
    }
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    seconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      body: ListView(
        padding: EdgeInsets.all(ResponsiveSizer.verticalScale(32)),
        children: [
          Text(
            'Verification',
            style: TextStyle(
                fontSize: ResponsiveSizer.moderateScale(24),
                fontWeight: FontWeight.w500),
          ),
          SizedBox(height: ResponsiveSizer.verticalScale(13)),
          Text(
            'We\'ve sent you the verification',
            style: TextStyle(
                fontSize: ResponsiveSizer.moderateScale(15),
                fontWeight: FontWeight.w400),
          ),
          Text(
            'code on your mail',
            style: TextStyle(
                fontSize: ResponsiveSizer.moderateScale(15),
                fontWeight: FontWeight.w400),
          ),
          SizedBox(height: ResponsiveSizer.verticalScale(27)),
          OtpTextField(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            keyboardType: TextInputType.number,
            numberOfFields: 4,
            focusedBorderColor: AppColors.primaryColor,
            enabledBorderColor: AppColors.borderColor,
            borderRadius:
                BorderRadius.circular(ResponsiveSizer.moderateScale(15)),
            showFieldAsBox: true,
            fieldWidth: ResponsiveSizer.horizontalScale(55),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            onSubmit: (String verificationCode) async {
              bool isVerified = EmailOTP.verifyOTP(otp: verificationCode);
              if (!mounted) return;
              if (isVerified) {
                _timer?.cancel();
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Verification Code"),
                      content: const Text('OTP was correct.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'OK',
                            style: TextStyle(
                                fontSize: ResponsiveSizer.moderateScale(18),
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor),
                          ),
                        ),
                      ],
                    );
                  },
                );
              } else {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Verification Code"),
                      content: Text(
                          'Code entered is $verificationCode, but it is incorrect'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'OK',
                            style: TextStyle(
                                fontSize: ResponsiveSizer.moderateScale(18),
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            },
          ),
          SizedBox(height: ResponsiveSizer.verticalScale(40)),
          SizedBox(
            width: double.infinity,
            height: ResponsiveSizer.verticalScale(58),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignInScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(ResponsiveSizer.moderateScale(15)),
                ),
              ),
              child: Text('CONTINUE',
                  style: TextStyle(
                      fontSize: ResponsiveSizer.moderateScale(16),
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
          ),
          SizedBox(height: ResponsiveSizer.verticalScale(24)),
          Center(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Re-send code in ',
                    style: TextStyle(
                        fontSize: ResponsiveSizer.moderateScale(15),
                        color: AppColors.black),
                  ),
                  TextSpan(
                    text: _formatTime(_secondsRemaining),
                    style: TextStyle(
                        fontSize: ResponsiveSizer.moderateScale(15),
                        color: AppColors.primaryColor),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
