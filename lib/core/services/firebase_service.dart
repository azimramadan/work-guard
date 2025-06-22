import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:work_guard/core/data/models/user_model.dart';

class FirebaseService {
  // Singleton Pattern
  static final FirebaseService _instance = FirebaseService._internal();
  factory FirebaseService() => _instance;
  FirebaseService._internal();

  // Firebase Instances
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<UserModel?> getUserData(String uid) async {
    try {
      final userDoc =
          await FirebaseFirestore.instance
              .collection('employees')
              .doc(uid)
              .get();

      if (!userDoc.exists) return null;

      final userData = userDoc.data()!;
      final attendanceSnapshot =
          await FirebaseFirestore.instance
              .collection('employees')
              .doc(uid)
              .collection('attendance')
              .get();

      final attendanceList =
          attendanceSnapshot.docs.map((doc) {
            return AttendanceDay.fromJson(doc.id, doc.data());
          }).toList();

      return UserModel.fromJson(uid, userData, attendanceList);
    } catch (e) {
      throw Exception('Error fetching user data: $e');
    }
  }

  Future<User?> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage =
              "No account found with this email. Please check and try again.";
          break;
        case 'wrong-password':
          errorMessage = "Incorrect password. Please try again.";
          break;
        case 'invalid-email':
          errorMessage = "Invalid email format. Please enter a valid email.";
          break;
        case 'user-disabled':
          errorMessage =
              "This account has been disabled. Please contact support.";
          break;
        default:
          errorMessage =
              "An error occurred while logging in. Please try again later.";
      }
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception("An unexpected error occurred. Please try again.");
    }
  }

  bool isUserLoggedIn() {
    return auth.currentUser != null;
  }

  Future<void> logout() async {
    await auth.signOut();
  }

  Future<void> changePassword(String newPassword) async {
    try {
      final user = auth.currentUser;

      if (user != null) {
        await user.updatePassword(newPassword);
      } else {
        throw Exception("No user is currently signed in.");
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'weak-password':
          errorMessage =
              'The password is too weak. Please use a stronger password.';
          break;
        case 'requires-recent-login':
          errorMessage = 'Please re-authenticate and try again.';
          break;
        default:
          errorMessage = 'An error occurred while changing the password.';
      }
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }
}
