import 'package:flutter/material.dart';
import 'package:g20newapp/shared/navegator/g20Navigator.dart';
import 'package:g20newapp/shared/theme/style.dart';
import 'package:g20newapp/shared/util/SharedFunctions.dart';
import 'package:g20newapp/shared/util/dateUtil.dart';
import 'package:g20newapp/shared/widgets/receipt/model/receipt.dart';
import 'package:g20newapp/shared/widgets/receipt/receiptPage.dart';



class Item extends StatefulWidget {
   Item({Key? key,required this.e,required this.isExcluded}) : super(key: key);
  Receipt e;
  bool isExcluded;
  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        G20Navigator.navigateTo(context, ReceiptPage(
          receipt: widget.e,
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
          child: Row(
            children: [
              if(widget.isExcluded)
              Checkbox(value: widget.e.isExcluded, onChanged: (value){
                setState(() {
                  widget.e.isExcluded = value!;
                });
              },activeColor: Colors.red,),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.e.categoryName??'',
                          style: TextStyle(
                            color: Color(0xff3C3C3C),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppDateUtil.dateToString(
                            DateTime.parse(
                              widget.e.date!,
                            ),
                          ),
                          style: TextStyle(
                              color: Color(0xff3C3C3C),
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          FormatMoney(widget.e.totalPrice!),
                          style: TextStyle(
                              color: Color(0xff3C3C3C), fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
