import 'package:g20newapp/modules/login/models/credentials.dart';

class LoginEvent {}
class LoginInitEvent extends LoginEvent{}
class AuthEvent extends LoginEvent {
  Credentials credentials;
  bool isKeepLogin;
  AuthEvent({required this.credentials,this.isKeepLogin =false});
}

class LoadingEvent extends LoginEvent {}
class LogOutEvent extends LoginEvent {}

