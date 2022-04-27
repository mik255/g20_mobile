import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g20newapp/modules/categorias/bloc/categoriasBloc.dart';
import 'package:g20newapp/modules/categorias/bloc/categoriasState.dart';
import 'package:g20newapp/modules/home/homeProvider.dart';
import 'package:g20newapp/shared/Shopping/bloc/bloc.dart';
import 'package:g20newapp/shared/Shopping/bloc/events.dart';
import 'package:g20newapp/shared/widgets/loadingWidget.dart';

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
            return Scaffold(
              body: Column(
                children: [
                  Spacer(flex: 5,),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.categoryList.length,
                    itemBuilder: (ctx, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  BlocProvider.of<ShoppingBloc>(context).
                                  add(SetCategoryEvent(category: state.categoryList[index]));
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => HomeProvider()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      Container(height: 20, child: Text(state.categoryList[index].name??'')),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Spacer(),
                ],
              ),
            );
          }
          return Container();
        });
  }
}
