import 'package:flutter/material.dart';
import 'package:g20newapp/modules/home/bloc/homeBloc.dart';
import 'package:g20newapp/shared/Shopping/bloc/events.dart';
import 'package:g20newapp/shared/util/SharedFunctions.dart';

import '../../categorias/models/product.dart';

class ProductComponent extends StatelessWidget {
  ProductComponent({
    Key? key,
    required this.product,
    required this.homeBloc,
    required this.index,
  }) : super(key: key);
  HomeBloc homeBloc;
  Product product;
  int index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            homeBloc.shoppingBloc.add(AddProductEvent(product: product));
          },
          child: Container(
            height: 180,
            clipBehavior: Clip.hardEdge,
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
                color: Colors.white),
            child: Stack(
              children: [
                Container(
                  height: 180,
                  child: product.img != null
                      ? Image.network(
                          product.img!,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          child: Icon(Icons.category),
                        ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 2),
                        ),
                      ],
                      color: Colors.blue,
                    ),
                    height: 40,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        FormatMoney(
                            homeBloc.currentStore.products![index].price ??
                                0.0),
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          color: Colors.black45,
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: FittedBox(
                              child: Text(
                                product.name ?? 'null',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        if (product.count! > 0)
          Align(
            alignment: Alignment.topRight,
            child: CircleAvatar(
              backgroundColor: Colors.red,
              radius: 18,
              child: Text(
                product.count.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }
}
