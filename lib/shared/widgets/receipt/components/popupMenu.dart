

import 'package:flutter/material.dart';

// This is the type used by the popup menu below.
enum Menu { itemOne, itemTwo, itemThree, itemFour }

class ReceiptChangePaymentent extends StatefulWidget {
  ReceiptChangePaymentent({Key? key,required this.callback}) : super(key: key);
  Function(String value) callback;
  @override
  State<ReceiptChangePaymentent> createState() => _ReceiptChangePaymententState();
}

class _ReceiptChangePaymententState extends State<ReceiptChangePaymentent> {
  String _selectedMenu = '';

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Menu>(
      icon: Icon(Icons.swap_vert,color: Colors.white70),
        onSelected: (Menu item) {
          setState(() {
            _selectedMenu = item.name;
            widget.callback(_selectedMenu);
          });
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
          const PopupMenuItem<Menu>(
            value: Menu.itemOne,
            child: Text('Dinheiro'),
          ),
          const PopupMenuItem<Menu>(
            value: Menu.itemTwo,
            child: Text('Pix'),
          ),
          const PopupMenuItem<Menu>(
            value: Menu.itemThree,
            child: Text('Boleto'),
          ),
          const PopupMenuItem<Menu>(
            value: Menu.itemFour,
            child: Text('Cartão'),
          ),
        ]);
  }
}
