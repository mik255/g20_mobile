import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g20newapp/modules/receiptHistory/bloc/ReceiptHistoryState.dart';
import 'package:g20newapp/modules/receiptHistory/bloc/receiptHistoryBloc.dart';
import 'package:g20newapp/shared/userPrefereces/deviceSetings.dart';
import 'package:g20newapp/shared/widgets/loadingWidget.dart';
import 'package:g20newapp/shared/widgets/searchWidget.dart';
import '../components/header.dart';
import '../components/item.dart';

class ReceiptHistoryPage extends StatelessWidget {
  ReceiptHistoryPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ReceiptHistoryBloc receiptHistoryBloc = BlocProvider.of<ReceiptHistoryBloc>(context);
    double height = deviceHeight(context);

    return SafeArea(
        child: Scaffold(
            body: BlocConsumer<ReceiptHistoryBloc, ReceiptHistoryState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is ReceiptHistoryMainState) {
                    return Container(
                      height: height,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            header(receiptHistoryBloc.receiptTotal(state.receiptList),),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SearchWidget(
                                hintText: 'Procurar recibos',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Recibos',
                                  style: TextStyle(
                                      color: Color(0xff3C3C3C), fontSize: 24)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                children: state.receiptList.map((e) {
                                  return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6.0, horizontal: 2),
                                      child: item(context, e));
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return G20Loading();
                })));
  }
}
