



import 'package:flutter/material.dart';

Widget iconActionRow() {
  return Container(
    height: 80,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(35),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 2),
        )
      ],
      color: Colors.white,
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {},
          ),
          Text('Esta Semana'),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: () {},
          )
        ],
      ),
    ),
  );
}