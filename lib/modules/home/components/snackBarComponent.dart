import 'package:flutter/material.dart';
import 'package:g20newapp/shared/Shopping/bloc/states.dart';
import 'package:g20newapp/shared/widgets/showModel.dart';

import '../page/cashier.page.dart';

void snackBarComponent(
  BuildContext context,
  GlobalKey<ScaffoldState> _scaffoldKey,
  ShoppingMainState state,
) {
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    showModelSheet(context, state.total, _scaffoldKey, 'Caixa',
        close: state.category.stores!.length == 0, onTap: () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => CashierPage()));
    });
  });
}
