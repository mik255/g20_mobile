

import 'package:flutter/material.dart';

class SearchComponent extends StatelessWidget {
  const SearchComponent({Key? key}) : super(key: key);

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
                        hintText: "Procure por um produto na loja"),
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
