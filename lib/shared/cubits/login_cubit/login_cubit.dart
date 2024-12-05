import 'package:firebase_auth/firebase_auth.dart';
import 'package:iot/shared/cubits/login_cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  final FirebaseAuth _firebaseAuth;
  LoginCubit({required bool isSignup, required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth,
        super(LoginState(isSignUp: isSignup));

  void emailChanged(String email) {
    emit(state.copyWith(
      email: email,
    ));
  }

  void passwordChanged(String password) {
    emit(state.copyWith(
      password: password,
    ));
  }

  void userNameChanged(String userName) {
    emit(state.copyWith(
      userName: userName,
    ));
  }

  void rePassChanged(String rePass) {
    emit(state.copyWith(
      rePass: rePass,
    ));
  }

  void setSignUpMode(bool isSignUp) {
    emit(state.copyWith(
      isSignUp: isSignUp,
    ));
  }

  Future<void> login() async {
    emit(state.copyWith( loginSuccess: false));
    try {
      await _firebaseAuth.signInWithEmailAndPassword(

        email: state.email,
        password: state.password,
      );
      emit(state.copyWith(loginSuccess: true));
    } catch (e) {
      print("Login failed: $e");
    }
    ;
  }
}
