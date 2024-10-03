import 'dart:async';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
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
        padding: const EdgeInsets.all(32.0),
        children: [
          const Text(
            'Verification',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 13),
          const Text(
            'We\'ve sent you the verification',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
          const Text(
            'code on your mail',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 27.0),
          OtpTextField(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            keyboardType: TextInputType.number,
            numberOfFields: 4,
            focusedBorderColor: AppColors.primaryColor,
            enabledBorderColor: AppColors.borderColor,
            borderRadius: BorderRadius.circular(15),
            showFieldAsBox: true,
            fieldWidth: 55,
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
                          child: const Text(
                            'OK',
                            style: TextStyle(
                                fontSize: 18,
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
                          child: const Text(
                            'OK',
                            style: TextStyle(
                                fontSize: 18,
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
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            height: 58,
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
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('CONTINUE',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Re-send code in ',
                    style: TextStyle(fontSize: 15, color: AppColors.black),
                  ),
                  TextSpan(
                    text: _formatTime(_secondsRemaining),
                    style: const TextStyle(
                        fontSize: 15, color: AppColors.primaryColor),
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
