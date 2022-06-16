

import 'package:g20newapp/shared/user/model/user.dart';

class UserEvent{}

class AuthenticatedEvent extends UserEvent{
  User user;
  AuthenticatedEvent({required this.user});
}

class LogoutEvent extends UserEvent{}
class LoggedEvent extends UserEvent {}