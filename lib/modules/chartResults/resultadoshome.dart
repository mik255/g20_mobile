import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g20newapp/modules/chartResults/bloc/chartResultsBloc.dart';
import 'package:g20newapp/modules/chartResults/bloc/chartResultsState.dart';
import 'package:g20newapp/shared/util/SharedFunctions.dart';
import 'package:g20newapp/shared/widgets/loadingWidget.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ChartResultsPage extends StatelessWidget {
  ChartResultsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          centerTitle: true,
          title: Text("Resultados"),
        ),
        backgroundColor: Colors.blue,
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: BlocConsumer<ChartResultsBloc, ChartResultsState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is ChartResultsMainState) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 2),
                              )
                            ],
                            color: Colors.white,
                          ),
                          height: MediaQuery.of(context).size.height * 0.85,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: _iconActionRow(),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 40.0),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: CircularPercentIndicator(
                                        radius: 90.0,
                                        lineWidth: 7.0,
                                        animation: true,
                                        backgroundColor: Colors.red[200]!,
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
                                                  color: Colors.grey[700]),
                                            ),
                                            Text(
                                              FormatMoney(state
                                                  .chartResults.grossProfit!),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 25.0,
                                                  color: Colors.grey[700]),
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
                                        progressColor: Colors.blue[200]!,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        height: 90,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(0.15),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: Offset(0, 2),
                                            )
                                          ],
                                          color: Colors.white,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text("Margem de lucro"),
                                              Text(state.chartResults.profitMargin!
                                                      .toStringAsFixed(2) +
                                                  "%"),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  _customContainer(
                                      'Com G20',
                                      state.chartResults.totalPrice!,
                                      Colors.blue[200]!),
                                  _customContainer(
                                      'Preço da praça',
                                      state.chartResults.totalPriceSquare!,
                                      Colors.red[200]!),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    _customContainer2(
                                      'Total de Vendas',
                                      Colors.white,
                                      text: state.chartResults.salesAmount!.toString()
                                     , value: state.chartResults.salesAmount!.toDouble(),
                                    ),
                                    _customContainer2(
                                      'Ticket Médio',
                                      Colors.white,
                                      value:state.chartResults.averageTicket!,
                                      text: FormatMoney(state.chartResults.averageTicket!),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return G20Loading();
              }),
        ));
  }

  Widget _iconActionRow() {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 2),
          )
        ],
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {},
            ),
            Text('Esta Semana'),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }

  Widget _customContainer(String titulo, double value, Color color) {
    return Container(
      height: 100,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 3,
            blurRadius: 2,
            offset: Offset(0, 2),
          )
        ],
        color: color,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  titulo,
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            Flexible(
              child: Container(
                width: 150,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text(FormatMoney(value))),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _customContainer2(String titulo, Color color,
      {required String text, required double value}) {
    return Container(
      height: 70,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 2),
          )
        ],
        color: color,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Text(
                titulo,
                style: TextStyle(fontSize: 15),
              ),
            ),
            Expanded(
              child: Center(child: Text(text)),
            )
          ],
        ),
      ),
    );
  }
}
