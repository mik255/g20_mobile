import 'package:flutter_bloc/flutter_bloc.dart';
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
   }
  }
}
