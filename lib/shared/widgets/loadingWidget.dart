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
// return Scaffold(
// // body: Center(
// // child: Image.asset('assets/images/logif.gif',scale: 0.5,),
// // ));
// // }