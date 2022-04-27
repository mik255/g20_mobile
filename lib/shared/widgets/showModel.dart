import 'package:flutter/material.dart';
import 'package:g20newapp/shared/util/SharedFunctions.dart';

import 'modalSheet.dart';

PersistentBottomSheetController? persistentBottomSheetController;

showModelSheet(
    BuildContext context, double total, GlobalKey<ScaffoldState> scaffoldState,
    {bool close = false, required Function onTap}) {
  try {
    persistentBottomSheetController?.close();
  } catch (e) {}
  if (close) {
    return;
  }

  ModalSheet modalSheet = ModalSheet(
      value: FormatMoney(total), textButton: 'Pagamento', onTap: onTap);
  persistentBottomSheetController = scaffoldState.currentState?.showBottomSheet(
    (context) => modalSheet,
    backgroundColor: Colors.blue,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(10),
        topLeft: Radius.circular(10),
      ),
    ),
  );
}
