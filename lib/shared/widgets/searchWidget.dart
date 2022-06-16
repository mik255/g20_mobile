

import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  SearchWidget({Key? key,required this.hintText}) : super(key: key);
  String hintText;
  @override
  Widget build(BuildContext context) {
      return Container(
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 2),
              )
            ],
            color: Colors.white),
        child: Row(
          children: [
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hintText),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(Icons.search),
            )
          ],
        ),
      );
  }
}
