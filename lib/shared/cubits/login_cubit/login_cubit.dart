import 'package:iot/shared/cubits/login_cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required bool isSignup}) : super(LoginState(isSignUp: isSignup));

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
}
