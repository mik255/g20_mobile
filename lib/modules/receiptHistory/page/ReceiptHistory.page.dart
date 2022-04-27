import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:g20newapp/modules/receiptHistory/bloc/ReceiptHistoryState.dart';
import 'package:g20newapp/modules/receiptHistory/bloc/receiptHistoryBloc.dart';

import 'package:g20newapp/shared/widgets/loadingWidget.dart';
import 'package:g20newapp/shared/widgets/receipt/model/receipt.dart';
import 'package:g20newapp/shared/widgets/receipt/receiptPage.dart';

class ReceiptHistoryPage extends StatelessWidget {
  ReceiptHistoryPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: BlocConsumer<ReceiptHistoryBloc, ReceiptHistoryState>(
                listener: (context, state) {},
                builder: (context, state) {

                  if (state is ReceiptHistoryMainState) {
                    return ListView(
                      children: state.receiptList
                          .map((e) => ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ReceiptPage(receipt: e,
                                        callback: (Receipt receipt) async{

                                        },)));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(e.totalPrice.toString()),
                                ),
                              )).toList(),
                    );
                  }
                  return G20Loading();
                })));
  }
}
