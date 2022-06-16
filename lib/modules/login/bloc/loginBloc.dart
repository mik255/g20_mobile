import 'package:g20newapp/core/data/localData.dart';
import 'package:g20newapp/core/http-client/http_client.dart';
import 'package:g20newapp/modules/login/bloc/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g20newapp/modules/login/models/credentials.dart';
import 'package:g20newapp/modules/login/repository/repository.dart';
import 'package:g20newapp/shared/user/bloc/bloc.dart';
import 'package:g20newapp/shared/user/bloc/events.dart';
import 'package:g20newapp/shared/user/bloc/states.dart';
import 'package:g20newapp/shared/user/model/user.dart';
import 'loginEvent.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(LoginState initialState, this.userBloc) : super(initialState);
  UserBloc userBloc;

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginInitEvent) {

      yield* isKeepLogin();
    }
    if (event is AuthEvent) {
      yield* authentication(event);
    }
    if (event is LogOutEvent) {
      yield LoginInitialState();
    }
  }
  Stream<LoginState> isKeepLogin() async* {
    print('isKeepLogin');
    print(userBloc.state);
    yield LoginLoadingState();
    try{
      Credentials credentials = await LocalData.getLocalCredentials();
      yield* login(credentials,);
    }catch(e){
      userBloc.add(LogoutEvent());
      yield LoginInitialState();
    }
  }
  Stream<LoginState> authentication(AuthEvent event) async* {
    yield LoginLoadingState();

    if (event.credentials.passWord == '' && event.credentials.passWord == '') {
      yield LoginErroState(erro: 'Preencha todos os campos');
    }
    yield* login(event.credentials,isKeepLogin:event.isKeepLogin);
  }

  Stream<LoginState> login(Credentials credentials,{bool? isKeepLogin}) async*{
    credentials = Credentials(cpfCnpj: credentials.cpfCnpj, passWord: credentials.passWord);
    G20Response g20response = await Repository().login(credentials);

    if (g20response is G20Sucess) {
      User user = User.fromJson(
          g20response.response.data['data'] as Map<String, dynamic>);

      userBloc.add(AuthenticatedEvent(user: user));
      if(isKeepLogin??false){
        await LocalData.saveLocalCredentials(credentials);
      }
      userBloc.add(LoggedEvent());
      yield LoginSucessState();
    } else if (g20response is G20Exception) {
      yield LoginErroState(erro: g20response.message ?? 'Generic error');
    }
  }
}
