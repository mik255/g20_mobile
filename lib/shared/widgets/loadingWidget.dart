import 'package:flutter/material.dart';

class G20Loading extends StatelessWidget {
  const G20Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: CircularProgressIndicator(),
    ));
  }
}
