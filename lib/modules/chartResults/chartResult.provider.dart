import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g20newapp/modules/chartResults/bloc/chartResultsState.dart';
import 'package:g20newapp/shared/user/bloc/bloc.dart';
import 'bloc/chartResultEvent.dart';
import 'bloc/chartResultsBloc.dart';
import 'components/headerChart.component/shimmerLoading.dart';
import 'myResults.page.dart';
import 'resultadoshome.dart';

class MeusRecibosProvider extends StatelessWidget {
  MeusRecibosProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<ChartResultsBloc>(
              create: (BuildContext context) =>
                  ChartResultsBloc(ChartResultsLoading())
                    ..add(ChartResultFetch(
                        BlocProvider.of<UserBloc>(context).user!.sId!)))
        ],
        child: BlocConsumer<ChartResultsBloc, ChartResultsState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is ChartResultsMainState) {
                return ResultsPage(state: state);
              } else if (state is ChartResultsLoading) {
                return Center(child: ShimmerLoading());
              }
              return Scaffold(
                body: Center(
                  child: Text('Erro'),
                ),
              );
            }));
  }
}
