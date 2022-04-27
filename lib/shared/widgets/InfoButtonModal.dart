

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

PersistentBottomSheetController infoButtonModal(BuildContext context,Widget sheetContent){
  return showBottomSheet(
    backgroundColor: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
      ),
      context: context,
      builder: (context) {
    return sheetContent;
  });
}