import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import './screens/signIn/sign_in.dart'; // Убедитесь, что путь правильный
import './screens/signIn/sign_in.dart';

void main() {
  runApp(CaloriesGramApp());
}

class CaloriesGramApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Мое приложение',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,

        textTheme: GoogleFonts.interTextTheme(),
      ),
      home: SignInScreen(), // Здесь задаем SignInForm как начальную страницу
    );
  }
}
