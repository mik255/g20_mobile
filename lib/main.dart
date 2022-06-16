import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g20newapp/shared/user/bloc/bloc.dart';
import 'package:g20newapp/shared/user/bloc/states.dart';
import 'package:g20newapp/shared/widgets/loadingWidget.dart';
import 'MainStances.dart';
import 'modules/login/loginProvider.dart';
import 'shared/Shopping/bloc/bloc.dart';
import 'shared/Shopping/bloc/states.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool isStart = false;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (BuildContext context) => UserBloc(UnAuthenticated()),
        ),
        BlocProvider<ShoppingBloc>(
          create: (BuildContext context) => ShoppingBloc(ShoppingInitialState()),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder<Object>(
            future: MainStances.settingsMainStances.fetchSettings(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.done&&!isStart){
                isStart =true;
                return LoginProvider();
              }
              return G20Loading();
            }
        ),
      ),
    );
  }
}
