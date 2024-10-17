import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:caloriesgram/screens/sign_in/sign_in.dart';
import 'package:caloriesgram/services/responsive_sizer.dart';
import 'package:caloriesgram/values/app_colors.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../navigation/bottom_navigation/bottom_navigation.dart';

class FirebaseAuthService {
  static final FirebaseAuthService _singleton = FirebaseAuthService._internal();

  factory FirebaseAuthService() => _singleton;
  FirebaseAuthService._internal();

  final auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  onListenUser(void Function(User?)? doListen) {
    auth.authStateChanges().listen(doListen);
  }

  User? getCurrentUser() {
    return auth.currentUser;
  }

  Future<void> createUserDocument(UserCredential? userCredential, fullName,
      [String? selectedLanguage,
      String? sex,
      String? yearOfBirth,
      double? weight,
      double? height,
      bool? isNotificationsTurnedOn,
      bool? isOnline]) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({
        'email': userCredential.user!.email,
        'uid': userCredential.user!.uid,
        'fullName': fullName,
        'selectedLanguage': selectedLanguage,
        'sex': sex,
        'yearOfBirth': yearOfBirth,
        'weight': weight,
        'height': height,
        'isNotificationsTurnedOn': isNotificationsTurnedOn,
        'isOnline': isOnline
      });
    }
  }

  Future<void> signUp(
      {required String email,
      required String password,
      required String fullName,
      String selectedLanguage = 'English UK',
      String sex = 'Other',
      String yearOfBirth = '2000',
      double weight = 55.0,
      double height = 165.0,
      bool isNotificationsTurnedOn = false,
      bool isOnline = false,
      required BuildContext context}) async {
    try {
      UserCredential? userCredential = await auth
          .createUserWithEmailAndPassword(email: email, password: password);
      createUserDocument(userCredential, fullName, selectedLanguage, sex,
          yearOfBirth, weight, height, isNotificationsTurnedOn, isOnline);
      await Future.delayed(const Duration(seconds: 1));

      if (context.mounted) Navigator.pop(context);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const BottomNavBar()));
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists with that email.';
      }
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: AppColors.red,
        textColor: AppColors.white,
        fontSize: ResponsiveSizer.moderateScale(14),
      );
    } catch (e) {
      print(e);
    }
  }

  Future<bool> signIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);

      await Future.delayed(const Duration(seconds: 1));
      return true; 
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'invalid-email') {
        message = 'No user found for that email.';
      } else if (e.code == 'invalid-credential') {
        message = 'Wrong data provided for that user.';
      }
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: AppColors.black,
        textColor: AppColors.white,
        fontSize: ResponsiveSizer.moderateScale(14),
      );
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> signOut({required BuildContext context}) async {
    await auth.signOut();
    await _googleSignIn.signOut();
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => const SignInScreen()));
  }

  Future<void> signInWithGoogle({required BuildContext context}) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth?.idToken,
        accessToken: googleAuth?.accessToken,
      );

      UserCredential userCredential =
          await auth.signInWithCredential(credential);

      final userDoc = await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .get();

      if (!userDoc.exists) {
        await createUserDocument(
          userCredential,
          googleUser!.displayName,
          'English UK',
          'Other',
          '2000',
          55.0,
          165.0,
          false,
          false,
        );
      }

      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => const BottomNavBar()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
      } else {
        print(e);
      }
      await Future.delayed(const Duration(seconds: 1));
      await Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const BottomNavBar()));
    } catch (e) {
      print(e);
    }
}

}
