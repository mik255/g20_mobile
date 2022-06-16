import 'package:flutter/material.dart';
import 'package:g20newapp/modules/home/components/dropDownPayment.dart';

import '../../categorias/models/story.dart';

paymnentCart(Store store) {
  return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 0,
              right: 11,
              top: 9,
              bottom: 4,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: SizedBox(
                    width: 250,
                    child: Text(
                      store.name!,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                DropDownPayment(store:store)
              ],
            ),
          ),
          Divider(
            color: Colors.white38,
          )
        ],
      )
      );
}
