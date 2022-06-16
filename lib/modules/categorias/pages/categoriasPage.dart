import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g20newapp/modules/categorias/bloc/categoriasBloc.dart';
import 'package:g20newapp/modules/categorias/bloc/categoriasState.dart';
import 'package:g20newapp/shared/widgets/loadingWidget.dart';

import '../components/verticalCicle/verticalCircleList.dart';

class CategoriaPage extends StatelessWidget {
  const CategoriaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriaBloc, CategoriasState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is CategoriaStateLoading) {
            return G20Loading();
          }
          if (state is CategoriasInitialState) {
            return SafeArea(
              child: Scaffold(
                body: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/categorybackground.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        color: Colors.black38,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [

                          Container(
                              height: 350,
                              child: VerticalCircularCategoryList(
                                state: state,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return Container();
        });
  }
}
