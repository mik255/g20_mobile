import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g20newapp/core/http-client/http_client.dart';
import 'package:g20newapp/modules/chartResults/model/chartResults.dart';
import 'package:g20newapp/modules/chartResults/repository/repository.dart';
import 'package:g20newapp/shared/widgets/receipt/model/receipt.dart';
import 'chartResultsState.dart';
import 'chartResultEvent.dart';


class ChartResultsBloc extends Bloc<ChartResultEvent, ChartResultsState> {
  ChartResultsBloc(ChartResultsState initialState) : super(initialState);

  @override
  Stream<ChartResultsState> mapEventToState(ChartResultEvent event) async* {
    if (event is ChartResultFetch) {
      yield* initialEvent(event.userId);
    }
  }

  Stream<ChartResultsState> initialEvent(String userId) async* {
    yield ChartResultsLoading();
    G20Response g20response = await Repository().getUserChartResults(userId:userId);
    if (g20response is G20Sucess) {
       ChartResults chartResults = ChartResults.fromJson(g20response.response.data);
      yield ChartResultsMainState(chartResults: chartResults);
    }else{
      throw g20response;
    }
  }
}
