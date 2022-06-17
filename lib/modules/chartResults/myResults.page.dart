import 'package:flutter/material.dart';

import 'bloc/chartResultsState.dart';
import 'components/headerChart.component/CardCharts.dart';
import 'components/headerChart.component/headerChart.dart';

class ResultsPage extends StatelessWidget {
  ResultsPage({Key? key,required this.state}) : super(key: key);
  ChartResultsMainState state;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: Color(0xff393D42),centerTitle: true,title: Text('Lucro Com G20'),),
          body: Container(
              child: Stack(children: <Widget>[
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: MediaQuery.of(context).size.height*0.40,
            color: Color(0xff393D42),
            child: HeaderChart(state: state,),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
            child: CardCharts(),
          ),
        ),
      ]))),
    );
  }
}
