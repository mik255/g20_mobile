


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

BoxDecoration backgroundBoxDecoration (){
  return BoxDecoration(
    gradient: LinearGradient(
        colors: [Color(0xff18A0FB), Color(0xff2564DF)],
        begin: const FractionalOffset(0.0, 0.0),
        end: const FractionalOffset(0.0, 1.0),
        stops: [0.0, 1.0],
        tileMode: TileMode.clamp),
  );
}

BoxShadow boxShadow(){
  return BoxShadow(
    color: Colors.grey.withOpacity(0.5),
    spreadRadius: 1,
    blurRadius: 2,
    offset: Offset(0, 3), // changes position of shadow
  );
}