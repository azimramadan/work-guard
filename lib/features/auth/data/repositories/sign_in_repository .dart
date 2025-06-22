import 'package:firebase_auth/firebase_auth.dart';
import 'package:work_guard/core/data/models/user_local_model.dart';
import 'package:work_guard/core/data/models/user_model.dart';
import 'package:work_guard/core/helper/hive_helper.dart';
import 'package:work_guard/core/services/firebase_service.dart';

class SignInRepository {
  final FirebaseService firebaseService = FirebaseService();
  Future<UserModel?> signInUser({
    required String email,
    required String password,
  }) async {
    User? firebaseUser;

    firebaseUser = await firebaseService.loginUser(email, password);

    if (firebaseUser == null) return null;

    UserModel? userModel = await firebaseService.getUserData(firebaseUser.uid);
    if (userModel != null) {
      await HiveHelper.saveUser(
        UserLocalModel(
          uid: userModel.uid,
          name: userModel.name,
          email: userModel.email,
          phone: userModel.phone,
          address: userModel.address,
          position: userModel.position,
          token: userModel.token,
          basicSalary: userModel.basicSalary,
          bonus: userModel.bonus,
          deductions: userModel.deductions,
        ),
      );
    }

    return userModel;
  }
}
