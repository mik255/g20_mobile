import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g20newapp/core/data/localData.dart';
import 'package:g20newapp/shared/user/model/user.dart';

import 'events.dart';
import 'states.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(initialState) : super(initialState);

  User? user;
  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
   if(event is AuthenticatedEvent){
     user = event.user;
   }if(event is LogoutEvent){
     yield* logOut();
   }if(event is LoggedEvent){
     yield* logged();
   }
  }
  Stream<UserState> logOut()async*{
    await LocalData.deleteLocalCredentials();
    user =null;
    yield UnAuthenticated();
  }
  Stream<UserState> logged()async*{
    yield Authenticated();
  }
}
