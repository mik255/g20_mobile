import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g20newapp/modules/chartResults/chartResult.provider.dart';
import 'package:g20newapp/modules/login/loginProvider.dart';
import 'package:g20newapp/modules/receiptHistory/receiptHistoryProvider.dart';
import 'package:g20newapp/shared/theme/logo.dart';
import 'package:g20newapp/shared/theme/style.dart';
import 'package:g20newapp/shared/user/bloc/bloc.dart';
import 'package:g20newapp/shared/user/bloc/states.dart';
import '../../../shared/user/bloc/events.dart';

class DrawerComponent extends StatelessWidget {
  const DrawerComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
        listener: (BuildContext context, UserState state) {
      if (state is UnAuthenticated) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.blue,
          content: Text('Usuário Deslogado'),
        ));
      }
    }, builder: (context, state) {
      if (state is UnAuthenticated) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => LoginProvider()));
      }
      return Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(35),
            bottomRight: Radius.circular(35),
          ),
          color: Colors.transparent,
        ),
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: backgroundBoxDecoration(),
                child: Center(child: logo()),
              ),
              ListTile(
                leading: Icon(Icons.bar_chart),
                title: const Text('Lucro com G20'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MeusRecibosProvider()));
                },
              ),
              ListTile(
                leading: Icon(Icons.receipt),
                title: const Text('Meus Recibos'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ReceiptHistoryProvider()));
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: const Text('sair'),
                onTap: () {
                  BlocProvider.of<UserBloc>(context).add(LogoutEvent());
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
