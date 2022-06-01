import 'package:flutter/material.dart';
import 'package:g20newapp/modules/home/bloc/homeBloc.dart';
import 'package:g20newapp/shared/Shopping/bloc/states.dart';

import '../bloc/homeEvent.dart';

class StoreCategoryComponent extends StatelessWidget {
  StoreCategoryComponent({
    Key? key,
    required this.homeBloc,
    required this.index,
    required this.state,
  }) : super(key: key);
  final HomeBloc homeBloc;
  final int index;
  final ShoppingMainState state;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        homeBloc.add(SelectLojaEvent(store: state.category.stores![index]));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 50,
          width: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 2),
                )
              ],
              color: homeBloc.currentStore == state.category.stores![index]
                  ? Colors.blue
                  : Colors.white),
          child: Center(
              child: Text(
            state.category.stores!.toList()[index].name ?? "null",
            textAlign: TextAlign.center,
            maxLines: 3,
            style: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: homeBloc.currentStore == state.category.stores![index]
                    ? Colors.white
                    : Colors.blue),
          )),
        ),
      ),
    );
  }
}
