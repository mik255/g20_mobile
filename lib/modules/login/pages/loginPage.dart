import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g20newapp/modules/login/bloc/loginBloc.dart';
import 'package:g20newapp/modules/login/bloc/states.dart';
import 'package:g20newapp/modules/login/models/credentials.dart';
import 'package:g20newapp/shared/theme/logo.dart';
import 'package:g20newapp/shared/userPrefereces/deviceSetings.dart';
import '../../../shared/util/masks.dart';
import '../components/EnterButton.dart';
import '../../../shared/theme/style.dart';
import '../components/customTextFormField.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, required this.state}) : super(key: key);
  LoginState state;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String cpfCnpj = '';
  String password = '';
  final formKey = new GlobalKey<FormState>();
  bool isKeepLogin = false;

  @override
  Widget build(BuildContext context) {
    LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              decoration: backgroundBoxDecoration(),
              height: deviceHeight(context),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Spacer(
                      flex: 2,
                    ),
                    logo(),
                    Spacer(
                      flex: 1,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        customTextFormField(
                          state: widget.state,
                          hintText: 'Digite o CNPJ',
                          labelText: 'CNPJ',
                          suffixIcon: Icons.person,
                          mask: maskCNPJ,
                          validator: (value) {
                            cpfCnpj = value!;
                            print(cpfCnpj);
                            if (cpfCnpj.isEmpty) {
                              return 'campo obrigatório!';
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        customTextFormField(
                          obscureText: true,
                          state: widget.state,
                          hintText: 'Digite a senha',
                          labelText: 'Senha',
                          suffixIcon: Icons.lock_outline,
                          validator: (value) {
                            password = value!;
                            if (password.isEmpty) {
                              return 'campo obrigatório!';
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Switch(
                          value: isKeepLogin,
                          onChanged: (value) {
                            setState(() {
                              isKeepLogin = value;
                            });
                          },
                        ),
                        Text(
                          'lembrar',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    EnterButton(
                      formKey: formKey,
                      state: widget.state,
                      credentials: Credentials(
                        cpfCnpj: cpfCnpj,
                        passWord: password,
                      ),
                      isKeepLogin: isKeepLogin,
                      loginBloc: loginBloc,
                    ),
                    Spacer(
                      flex: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
