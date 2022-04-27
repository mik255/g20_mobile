import 'package:g20newapp/modules/login/models/credentials.dart';

class LoginEvent {}

class AuthEvent extends LoginEvent {
  Credentials credentials;

  AuthEvent({required this.credentials});
}

class LoadingEvent extends LoginEvent {}
