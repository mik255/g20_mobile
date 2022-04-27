class LoginState {}

class LoginInitialState extends LoginState {}

class LoginSucessState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginErroState extends LoginState {
  String erro;

  LoginErroState({required this.erro});
}
