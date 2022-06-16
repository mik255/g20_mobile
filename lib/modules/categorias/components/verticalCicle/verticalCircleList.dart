import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g20newapp/modules/categorias/bloc/categoriasState.dart';
import 'package:g20newapp/modules/home/homeProvider.dart';
import 'package:g20newapp/shared/Shopping/bloc/bloc.dart';
import 'package:g20newapp/shared/Shopping/bloc/events.dart';
import 'package:g20newapp/shared/userPrefereces/deviceSetings.dart';

import 'data.dart';

class VerticalCircularCategoryList extends StatefulWidget {
  VerticalCircularCategoryList({required this.state});

  final CategoriasInitialState state;

  @override
  _VerticalCircularCategoryListState createState() =>
      _VerticalCircularCategoryListState();
}

class _VerticalCircularCategoryListState
    extends State<VerticalCircularCategoryList> {
  @override
  Widget build(BuildContext context) {
    final List<String> titles =
        widget.state.categoryList.map((e) => e.name!).toList();

    return ListView.builder(
        itemCount: titles.length,
        itemBuilder: (ctx, index) {
          return InkWell(
              onTap: () {
                BlocProvider.of<ShoppingBloc>(context).add(SetCategoryEvent(
                    category: widget.state.categoryList[index]));
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HomeProvider()));
              },
              child: Center(
                  child: Column(
                    children: [
                      Text(
                titles[index],
                style:
                        TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 32),
              ),
                      SizedBox(height: 10),
                      Divider(color: Colors.grey,)
                    ],
                  )));
        });
  }
}
