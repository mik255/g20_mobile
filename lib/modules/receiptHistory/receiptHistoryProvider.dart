import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g20newapp/modules/receiptHistory/bloc/ReceiptHistoryState.dart';
import 'package:g20newapp/shared/user/bloc/bloc.dart';
import 'bloc/ReceiptHistoryEvent.dart';
import 'bloc/receiptHistoryBloc.dart';
import 'page/ReceiptHistory.page.dart';

class ReceiptHistoryProvider extends StatelessWidget {
  ReceiptHistoryProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
        providers: [
          BlocProvider<ReceiptHistoryBloc>(create: (BuildContext context) =>ReceiptHistoryBloc(
              ReceiptHistoryLoading(),BlocProvider.of<UserBloc>(context))..add(ReceiptHistoryInitEvent()))
        ],
        child: ReceiptHistoryPage());
  }
}