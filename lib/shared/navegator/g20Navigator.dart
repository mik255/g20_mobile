import 'package:flutter/material.dart';

class G20Navigator {

  static navigateTo(BuildContext context, Widget page) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
    });
  }
}
