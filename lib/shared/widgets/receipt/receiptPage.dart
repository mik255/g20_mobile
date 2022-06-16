import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:g20newapp/shared/theme/logo.dart';
import 'package:g20newapp/shared/userPrefereces/deviceSetings.dart';
import 'package:g20newapp/shared/util/dateUtil.dart';
import 'package:g20newapp/shared/util/screamShot.dart';
import 'package:g20newapp/shared/widgets/thankYouPage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:g20newapp/modules/home/homeProvider.dart';
import 'package:g20newapp/modules/home/models/order.model.dart';
import 'package:g20newapp/shared/Shopping/bloc/bloc.dart';
import 'package:g20newapp/shared/Shopping/bloc/states.dart';
import 'package:g20newapp/shared/user/bloc/bloc.dart';
import 'package:g20newapp/shared/user/model/user.dart';
import 'package:g20newapp/shared/util/SharedFunctions.dart';
import 'package:g20newapp/shared/widgets/loadingWidget.dart';
import 'package:g20newapp/shared/widgets/showModel.dart';
import 'package:screenshot/screenshot.dart';
import 'components/receiptHystoryWidgetComponent.dart';
import 'model/receipt.dart';
import 'dart:io';

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
              paymentMethod(),
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

  String paymentMethod() {
    switch (widget.receipt.paymentType) {
      case 'card':
        return 'Cartão';
      case 'pix':
        return 'Pix';
      case 'logist':
        return 'Boleto';
      case 'money':
        return 'Dinheiro';
    }
    return 'null';
  }
}
