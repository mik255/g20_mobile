import 'package:flutter/material.dart';

class ModalSheet extends StatelessWidget {
   ModalSheet({Key? key,required this.value,required this.textButton,required this.onTap}) : super(key: key);
  String value;
  Function onTap;
  String textButton;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Arial',
            fontSize: 28,
            color: const Color(0xffffffff),
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,
        ),

        if(textButton!=null)
          InkWell(
          onTap: ()=>onTap.call(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 161.0,
              height: 66.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: const Color(0xffffffff),
              ),
              child: Center(
                child: Text(
                  textButton,
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 20,
                    color: const Color(0xff2f69af),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
