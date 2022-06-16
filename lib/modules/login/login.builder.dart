import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g20newapp/modules/categorias/categoria.provider.dart';
import 'package:g20newapp/modules/login/pages/loginPage.dart';
import 'package:g20newapp/shared/navegator/g20Navigator.dart';
import 'package:g20newapp/shared/user/bloc/bloc.dart';
import 'package:g20newapp/shared/user/bloc/states.dart';
import 'package:g20newapp/shared/widgets/loadingWidget.dart';

import 'bloc/loginBloc.dart';
import 'bloc/states.dart';

class LoginBuilder extends StatelessWidget {
  const LoginBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    return BlocConsumer<LoginBloc, LoginState>(
        listener: (BuildContext context, LoginState state) {
      if (state is LoginErroState) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(state.erro),
        ));
      }
    }, builder: (context, state) {
      if (state is LoginLoadingState) {
        return G20Loading();
      }

      if (state is LoginSucessState && !(userBloc.state is UnAuthenticated)) {
        G20Navigator.navigateTo(context, CategoryProvider());
      }
      return LoginPage(state: state);
    });
  }
}
