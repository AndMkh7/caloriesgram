import 'package:email_otp/email_otp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/home/home.dart';
import 'services/responsive_sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  EmailOTP.config(
    appName: 'CaloriesGram',
    otpType: OTPType.numeric,
    emailTheme: EmailTheme.v1,
    otpLength: 4,
  );
  runApp(const CaloriesGramApp());
}

class CaloriesGramApp extends StatelessWidget {
  const CaloriesGramApp({super.key});

  @override

  Widget build(BuildContext context) {
    ResponsiveSizer.init(context);
    return MaterialApp(
        title: '',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.interTextTheme(),
        ),
        home: const HomeScreen());
  }
}
