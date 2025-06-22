import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:work_guard/core/data/models/user_model.dart';
import 'package:work_guard/features/auth/data/repositories/sign_in_repository%20.dart';

part 'auth_sign_in_state.dart';

class AuthSignInCubit extends Cubit<AuthSignInState> {
  final SignInRepository signInRepository;
  UserModel? userModel;
  AuthSignInCubit(this.signInRepository) : super(AuthSignInInitial());
  void signInUser({required String email, required String password}) async {
    emit(AuthSignInLoading());
    try {
      userModel = await signInRepository.signInUser(
        email: email,
        password: password,
      );

      if (userModel == null) {
        throw Exception("Failed to fetch user data.");
      }

      emit(AuthSignInSuccess(userModel!));
    } catch (e) {
      emit(AuthSignInFailure(error: e.toString()));
    }
  }
}
