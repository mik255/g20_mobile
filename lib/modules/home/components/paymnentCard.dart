


import 'package:flutter/material.dart';

paymnentCart(Map<String,dynamic> card) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color(0x3f000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
        color: card['color'],
      ),
      width: 351,
      height: 80,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 30, right: 11, top: 9, bottom: 4,),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 101,
                  child: Text(
                    card['cardName'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xff414141),
                      fontSize: 24,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  width: 40,
                  height: 30,
                  child: card['icon'],
                ),
              ],
            ),
          ),
          Container(
            height: 18,
            child: Text(
              "Faça pagamentos com dinheiro diretamente na loja",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff404040),
                fontSize: 13,
                fontFamily: "Inter",
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}