import 'dart:async';
import 'package:flutter/material.dart';
import 'package:g20newapp/shared/widgets/thankYouPage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g20newapp/modules/home/homeProvider.dart';
import 'package:g20newapp/shared/Shopping/bloc/bloc.dart';
import 'package:g20newapp/shared/Shopping/bloc/states.dart';
import 'package:g20newapp/shared/widgets/loadingWidget.dart';
import 'package:screenshot/screenshot.dart';
import 'components/receiptHystoryWidgetComponent.dart';
import 'model/receipt.dart';

class ReceiptPage extends StatefulWidget {
  ReceiptPage({
    Key? key,
    required this.receipt,
    this.callback,
  }) : super(key: key);
  Receipt receipt;
  Future<void> Function(Receipt receipt)? callback;

  @override
  _ReceiptPageState createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  ScreenshotController screenshotController = ScreenshotController();
  final scaffoldState = GlobalKey<ScaffoldState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShoppingBloc, ShoppingState>(listener: (c, state) {
      if (state is ShoppingFinishBidState) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => ThankYouPage(
                  title: 'Finalizado',
                  pageToBack: HomeProvider(),
                )));
      }
    }, builder: (context, state) {
      if (state is ShoppingLoading) {
        return G20Loading();
      }
      if (state is ShoppingMainState) {
        return Screenshot(
            controller: screenshotController,
            child: receiptHystoryWidgetComponent(
              context,
              widget.receipt,
              scaffoldState,
              screenshotController,
              widget.callback != null ? true : false,
              widget.callback != null ? widget.callback : null,
            ));
      }
      return Container(
        child: Center(
          child: Text('error'),
        ),
      );
    });
  }

}
