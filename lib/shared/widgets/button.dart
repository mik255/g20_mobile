



import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button({Key? key,required this.onPressed,required this.text,}) : super(key: key);
  String text;
  Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Color(0x26000000),
              blurRadius: 4,
              offset: Offset(0, -1),
            ),
          ],
          color: Color(0xff00C673),
        ),
        padding: const EdgeInsets.only(top: 16, bottom: 24, ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                Text(
                  text,
                  style: TextStyle(
                    color: Color(0xfff0f2f4),
                    fontSize: 16,
                    fontFamily: "Lato",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
