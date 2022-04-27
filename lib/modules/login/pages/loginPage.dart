import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g20newapp/modules/categorias/categoria.provider.dart';
import 'package:g20newapp/modules/login/bloc/loginBloc.dart';
import 'package:g20newapp/modules/login/bloc/loginEvent.dart';
import 'package:g20newapp/modules/login/bloc/states.dart';
import 'package:g20newapp/modules/login/models/credentials.dart';
import 'package:g20newapp/shared/widgets/loadingWidget.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String cpfCnpj = '';
  String password = '';
  final formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);
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
      if (state is LoginSucessState) {
        print('rodou');
        WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CategoryProvider()));
        });

      }
      return SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      Spacer(
                        flex: 2,
                      ),
                      Image.asset('assets/images/g20.png'),
                      Spacer(
                        flex: 1,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextFormField(
                              enabled: !(state is LoginLoadingState),
                              initialValue: 'digite seu cpf ou  cnpj',
                              decoration: InputDecoration(
                                labelText: 'cpf ou  cnpj',
                                border: OutlineInputBorder(),
                                suffixIcon: (state is LoginErroState)
                                    ? Icon(
                                        Icons.error,
                                        color: Colors.red,
                                      )
                                    : Icon(Icons.person),
                              ),
                              // ignore: missing_return
                              validator: (value) {
                                cpfCnpj = value!;
                                if (cpfCnpj.isEmpty) {
                                  return 'campo obrigatório!';
                                }
                              }),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                              enabled: !(state is LoginLoadingState),
                              initialValue: 'Digite a sua senha',
                              decoration: InputDecoration(
                                labelText: 'Senha',
                                border: OutlineInputBorder(),
                                suffixIcon: (state is LoginErroState)
                                    ? Icon(
                                        Icons.error,
                                        color: Colors.red,
                                      )
                                    : Icon(Icons.lock),
                              ),
                              // ignore: missing_return
                              validator: (value) {
                                password = value!;
                                if (password.isEmpty) {
                                  return 'campo obrigatório!';
                                }
                              }),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: state is LoginLoadingState
                                  ? null
                                  : () {
                                      if (!formKey.currentState!.validate()) {
                                        return null;
                                      }
                                      loginBloc.add(AuthEvent(
                                          credentials: Credentials(
                                              passWord: password,
                                              cpfCnpj: cpfCnpj)));
                                    },
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    state is LoginLoadingState
                                        ? Container(
                                            height: 20,
                                            width: 20,
                                            child: Center(
                                                child: CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                                Color>(
                                                            Colors.white))),
                                          )
                                        : Text("Login"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
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
    });
  }
}
