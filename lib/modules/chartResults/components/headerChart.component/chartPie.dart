



import 'package:flutter/material.dart';
import 'package:g20newapp/modules/chartResults/bloc/chartResultsState.dart';
import 'package:g20newapp/shared/theme/style.dart';
import 'package:g20newapp/shared/util/SharedFunctions.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ChartPie extends StatelessWidget {
   ChartPie({Key? key,required this.state}) : super(key: key);
  ChartResultsMainState state;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:
      const EdgeInsets.symmetric(vertical: 10.0),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: CircularPercentIndicator(
              radius: 80.0,
              lineWidth: 7.0,
              animation: true,
              backgroundColor: Color(0xff18A0FB),
              percent: state.chartResults.profitMargin!/100,
              center: Column(
                mainAxisAlignment:
                MainAxisAlignment.center,
                children: [
                  Text(
                    'Lucro com G20',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18.0,
                        color: Colors.white),
                  ),
                  Container(
                    width: 120,
                    child: FittedBox(
                      child: Text(
                        FormatMoney(state
                            .chartResults.grossProfit!),
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 25.0,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              footer: const Text(
                "",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0),
              ),
              circularStrokeCap:
              CircularStrokeCap.butt,
              progressColor: Colors.white,
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x3f000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                        ),
                      ],
                      color: Color(0xff00a862),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2, ),
                    child: SizedBox(
                      width: 92,
                      child: Text(
                        "${state.chartResults.profitMargin!
                            .toStringAsFixed(2) +
                            "%"} de lucro com G20",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xfff0f2f4),
                          fontSize: 14,
                          fontFamily: "Lato",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                  )

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
