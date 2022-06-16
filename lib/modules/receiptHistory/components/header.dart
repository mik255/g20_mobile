



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:g20newapp/shared/util/SharedFunctions.dart';

Widget header(double total){
return Container(
  color: Color(0xff3C3C3C),
  height: 150,
  child: Center(
    child: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Total acumulado:',
              style: TextStyle(
                  color: Colors.white, fontSize: 12),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            width: 170,
            height: 60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  child: Text(
                      FormatMoney(
                          total),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 32)),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);
}