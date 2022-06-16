import 'package:flutter/material.dart';
import 'package:g20newapp/modules/login/bloc/states.dart';
import 'package:g20newapp/shared/widgets/loadingWidget.dart';

import '../bloc/loginBloc.dart';
import '../bloc/loginEvent.dart';
import '../models/credentials.dart';

Widget EnterButton({
  required LoginState state,
  required Credentials credentials,
  required bool isKeepLogin,
  required GlobalKey<FormState> formKey,
  required LoginBloc loginBloc,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Expanded(
        child: ElevatedButton(
          onPressed: state is LoginLoadingState ? null : () async {
                  if (!formKey.currentState!.validate()) {
                    return null;
                  }
                  loginBloc.add(AuthEvent(
                      isKeepLogin: isKeepLogin, credentials: credentials));
                },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                state is LoginLoadingState
                    ? G20Loading()
                    : Text("Entrar"),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
