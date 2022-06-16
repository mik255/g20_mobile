import 'package:flutter/material.dart';
import 'package:g20newapp/shared/navegator/g20Navigator.dart';
import 'package:g20newapp/shared/theme/style.dart';
import 'package:g20newapp/shared/util/SharedFunctions.dart';
import 'package:g20newapp/shared/util/dateUtil.dart';
import 'package:g20newapp/shared/widgets/receipt/model/receipt.dart';
import 'package:g20newapp/shared/widgets/receipt/receiptPage.dart';

Widget item(
  BuildContext context,
  Receipt e,
) {
  return InkWell(
    onTap: () {
      G20Navigator.navigateTo(context, ReceiptPage(
        receipt: e,
      ));
    },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [boxShadow()],
      ),
      height: 75,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  e.categoryName??'',
                  style: TextStyle(
                    color: Color(0xff3C3C3C),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  width: 75,
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.money,
                          color: Color(0xff3C3C3C),
                        ),
                      ),
                      Flexible(
                        child: Center(
                          child: Text(
                            e.paymentType ?? '',
                            style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: Color(0xff3C3C3C),
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppDateUtil.dateToString(
                    DateTime.parse(
                      e.date!,
                    ),
                  ),
                  style: TextStyle(
                      color: Color(0xff3C3C3C),
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  FormatMoney(e.totalPrice!),
                  style: TextStyle(
                      color: Color(0xff3C3C3C), fontWeight: FontWeight.w400),
                )
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
