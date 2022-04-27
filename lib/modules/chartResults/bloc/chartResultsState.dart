

import 'package:g20newapp/modules/chartResults/model/chartResults.dart';

class ChartResultsState{}

class ChartResultsMainState extends ChartResultsState{
  ChartResults chartResults;
  ChartResultsMainState({required this.chartResults});
}

class ChartResultsLoading extends ChartResultsState{}