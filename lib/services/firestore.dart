import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> updateNotificationPreference(bool isTurnedOn) async {
    if (user != null) {
      try {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(user!.email)
            .update({'isNotificationsTurnedOn': isTurnedOn});
      } catch (e) {
        print('ERROR: $e');
      }
    } else {
      print('User not found');
    }
  }

  Future<String?> getSelectedLanguage() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(user?.email)
          .get();
      if (doc.exists) {
        return doc['selectedLanguage'] as String?;
      }
    } catch (e) {
      print('Error fetching language: $e');
    }
    return null;
  }

  Future<void> updateSelectedLanguage(String language) async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user?.email)
          .update({'selectedLanguage': language});
    } catch (e) {
      print('Error saving language: $e');
    }
  }

  Future<Map<String, dynamic>?> getUserData() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(user?.email)
          .get();
      if (doc.exists) {
        return {
          'sex': doc['sex'] ?? 'Female',
          'yearOfBirth': doc['yearOfBirth'] ?? 2001,
          'weight': doc['weight']?.toDouble() ?? 55.0,
          'height': doc['height']?.toDouble() ?? 160.0,
        };
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
    return null;
  }

  Future<void> updateUserData(Map<String, dynamic> userData) async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user?.email)
          .update(userData);
    } catch (e) {
      print('Error updating user data: $e');
    }
  }

  Future<void> updateFullName(String fullName) async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user?.email)
          .update({'fullName': fullName});
    } catch (e) {
      print('Error saving language: $e');
    }
  }
}
