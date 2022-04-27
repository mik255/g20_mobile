import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g20newapp/modules/home/bloc/homeBloc.dart';
import 'package:g20newapp/shared/Shopping/bloc/bloc.dart';
import 'bloc/states.dart';
import 'page/HomePage.dart';

class HomeProvider extends StatelessWidget {
  HomeProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShoppingBloc shoppingBloc = BlocProvider.of<ShoppingBloc>(context);
    return MultiBlocProvider(providers: [
              BlocProvider<HomeBloc>(
                  create: (BuildContext context) => HomeBloc(HomeInitState(),shoppingBloc))
            ],
                child: HomePage());

        }
}
