

import 'package:flutter/material.dart';

import '../../categorias/models/story.dart';

class DropDownPayment extends StatefulWidget {
  DropDownPayment({Key? key,required this.store}) : super(key: key);
  Store store;
  @override
  State<DropDownPayment> createState() => _DropDownPaymentState();
}

class _DropDownPaymentState extends State<DropDownPayment> {
  String selectedValue = 'selecionar';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      dropdownColor: Color(0xff2a5f9c),isDense: true,
      underline: Container(),icon: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: Color(0xff2a5f9c),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2, ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:[
          Text(
            selectedValue,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xfff0f2f4),
              fontSize: 14,
              fontFamily: "Lato",
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    ),
      items: <String>['Dinheiro', 'Pix', 'Cartão', 'Lojista'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child:  Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              Text(
                value,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xfff0f2f4),
                  fontSize: 14,
                  fontFamily: "Lato",
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          )
        );
      }).toList(),onChanged: (value) {
        setState(() {
          selectedValue = value!;
          widget.store.setPayment(value);
        });
      },
    );
  }
}
