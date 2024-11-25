class LoginState {
  final String email;
  final String password;
  final String userName;
  final String rePass;
  final bool isSignUp;

  LoginState(
      {this.email = '',
      this.password = '',
      this.userName = '',
      this.rePass = '',
      this.isSignUp = false});

  LoginState copyWith({
    String? email,
    String? password,
    String? userName,
    String? rePass,
    bool? isSignUp,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      userName: userName ?? this.userName,
      rePass: rePass ?? this.rePass,
      isSignUp: isSignUp ?? this.isSignUp,
    );
  }

  bool get valid {
    if (isSignUp) {
      // Logic kiểm tra cho đăng ký
      return email.isNotEmpty &&
          password.isNotEmpty &&
          rePass.isNotEmpty &&
          userName.isNotEmpty;
    }
    // Logic kiểm tra cho đăng nhập
    return email.isNotEmpty && password.isNotEmpty;
  }
}
