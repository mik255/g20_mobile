import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g20newapp/modules/login/bloc/loginBloc.dart';
import 'package:g20newapp/modules/login/bloc/states.dart';
import 'package:g20newapp/modules/login/pages/loginPage.dart';
import 'package:g20newapp/shared/user/bloc/bloc.dart';

import 'bloc/loginEvent.dart';
import 'login.builder.dart';

class LoginProvider extends StatefulWidget {
  const LoginProvider({Key? key}) : super(key: key);

  @override
  _LoginProviderState createState() => _LoginProviderState();
}

class _LoginProviderState extends State<LoginProvider> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(create: (BuildContext context) =>LoginBloc(
              LoginLoadingState(),BlocProvider.of<UserBloc>(context))..add(LoginInitEvent())),
        ],
        child: LoginBuilder());
  }
}
