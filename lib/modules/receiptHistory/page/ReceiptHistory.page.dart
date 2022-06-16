import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g20newapp/modules/receiptHistory/bloc/ReceiptHistoryState.dart';
import 'package:g20newapp/modules/receiptHistory/bloc/receiptHistoryBloc.dart';
import 'package:g20newapp/shared/userPrefereces/deviceSetings.dart';
import 'package:g20newapp/shared/widgets/loadingWidget.dart';
import 'package:g20newapp/shared/widgets/searchWidget.dart';
import 'package:g20newapp/shared/widgets/showModel.dart';
import '../components/header.dart';
import '../components/item.dart';

class ReceiptHistoryPage extends StatefulWidget {
  ReceiptHistoryPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ReceiptHistoryPage> createState() => _ReceiptHistoryPageState();
}

class _ReceiptHistoryPageState extends State<ReceiptHistoryPage> {
  bool isExcluded = false;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    ReceiptHistoryBloc receiptHistoryBloc =
        BlocProvider.of<ReceiptHistoryBloc>(context);
    double height = deviceHeight(context);


    return SafeArea(
        child: Scaffold(
          key: scaffoldKey,
            body: BlocConsumer<ReceiptHistoryBloc, ReceiptHistoryState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is ReceiptHistoryMainState) {
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      if (isExcluded) {
                        showModelSheet(
                            context, 10, scaffoldKey, 'Excluir',
                            close: false, onTap: () async {
                          isExcluded = false;
                          state.receiptList.forEach((element) {
                            element.isExcluded = false;
                          });
                          setState(() {});
                          Navigator.pop(context);
                        });
                      }
                    });
                    return Container(
                      height: height,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            header(
                              receiptHistoryBloc
                                  .receiptTotal(state.receiptList),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SearchWidget(
                                hintText: 'Procurar recibos',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Recibos',
                                        style: TextStyle(
                                            color: Color(0xff3C3C3C),
                                            fontSize: 24)),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        isExcluded = !isExcluded;
                                      });
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 30,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: Icon(
                                              Icons.delete_outline_outlined,
                                              color: isExcluded
                                                  ? Colors.red
                                                  : Colors.black38,
                                            ),
                                          ),
                                        ),
                                        Text('Deletar',
                                            style: TextStyle(
                                                color: isExcluded
                                                    ? Colors.red
                                                    : Colors.black38,
                                                fontSize: 12)),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView(
                                shrinkWrap: true,padding: EdgeInsets.only(bottom: 100),
                                physics: NeverScrollableScrollPhysics(),
                                children: state.receiptList.map((e) {
                                  return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6.0, horizontal: 2),
                                      child: Item(
                                        e: e,
                                        isExcluded: isExcluded,
                                      ));
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
