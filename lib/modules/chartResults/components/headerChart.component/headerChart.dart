import 'package:flutter/material.dart';
import 'package:g20newapp/modules/chartResults/bloc/chartResultsState.dart';

import 'chartPie.dart';
import 'filteredChartDate.dart';

class HeaderChart extends StatelessWidget {
  HeaderChart({Key? key,required this.state}) : super(key: key);
  ChartResultsMainState state;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FilteredTabChartDate(),
        ),
        ChartPie(state: state,)
      ],
    );
  }
}
