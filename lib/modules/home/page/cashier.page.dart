import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g20newapp/MainStances.dart';
import 'package:g20newapp/modules/categorias/models/product.dart';
import 'package:g20newapp/modules/categorias/models/story.dart';
import 'package:g20newapp/modules/home/bloc/homeBloc.dart';
import 'package:g20newapp/modules/home/bloc/homeEvent.dart';
import 'package:g20newapp/modules/home/bloc/states.dart';
import 'package:g20newapp/modules/home/models/order.model.dart';
import 'package:g20newapp/modules/home/page/paymentType.page.dart';
import 'package:g20newapp/shared/Shopping/bloc/bloc.dart';
import 'package:g20newapp/shared/Shopping/bloc/events.dart';
import 'package:g20newapp/shared/Shopping/bloc/states.dart';
import 'package:g20newapp/shared/user/bloc/bloc.dart';
import 'package:g20newapp/shared/user/model/user.dart';
import 'package:g20newapp/shared/util/SharedFunctions.dart';
import 'package:g20newapp/shared/widgets/loadingWidget.dart';
import 'package:g20newapp/shared/widgets/receipt/model/receipt.dart';
import 'package:g20newapp/shared/widgets/receipt/receiptPage.dart';
import 'package:g20newapp/shared/widgets/showModel.dart';

import 'orderPage.dart';


class CashierPage extends StatefulWidget {
  CashierPage({
    Key? key,
  }) : super(key: key);
  @override
  _CashierPageState createState() => _CashierPageState();
}

class _CashierPageState extends State<CashierPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: BlocConsumer<ShoppingBloc, ShoppingState>(
            listener: (context, state) {

            },
            builder: (context, state) {
              if(state is ShoppingMainState)
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                showModelSheet(context,state.total,_scaffoldKey,'Pagamento',
                    close:state.total==0&&!MainStances.settingsMainStances.settings!.period,
                    onTap:(){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PaymentTypePage(total: state.total,)));
                    }
                );
              });
              if(state is ShoppingMainState){
                List<Store> stores = state.category.
                stores!.where((e) => (e.products!.where((e) => e.count!>0).length>0)).toList();
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [
                        0,
                        1,
                      ],
                      colors: [
                        Colors.blue[800]!,
                        Colors.blue[900]!,
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          children: [
                            InkWell(
                              onTap:(){
                              Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "Caixa",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            Spacer(),
                            Icon(
                              Icons.remove_shopping_cart_rounded,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      if (state.total==0&&!MainStances.settingsMainStances.settings!.period)
                        Container(
                          height: MediaQuery.of(context).size.height / 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.announcement_outlined,
                                color: Colors.white,
                                size: 100,
                              ),
                              Text(
                                "Vazio",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: ListView.builder(
                              itemCount: stores.length,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index0) {
                                Store store = stores[index0];
                                List<Product> products = store.products!.where(
                                        (element) => element.count! > 0).toList();
                                return Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                              Colors.black.withOpacity(0.1),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: Offset(0, 2),
                                            )
                                          ],
                                          color: Colors.white,
                                        ),
                                        height: 40,
                                        child: Center(
                                          child: Text(
                                            store.name!,
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      ListView.builder(
                                          physics: NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: products.length,
                                          itemBuilder: (context, index) {
                                            Product product = products[index];
                                            return Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 8.0),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.restore_from_trash,
                                                    color: Colors.white,
                                                    size: 30,
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        product.name!,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(
                                                        FormatMoney(
                                                            product.price!),
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                          FontWeight.w400,
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Spacer(
                                                    flex: 3,
                                                  ),
                                                  IconButton(
                                                    icon:
                                                    Icon(Icons.remove_circle),
                                                    color: Colors.white,
                                                    onPressed: () {
                                                      BlocProvider.of<ShoppingBloc>(context)
                                                          .add(RemoveProductEvent(
                                                        product: product,
                                                      ));
                                                    },
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                    product.count.toString(),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  IconButton(
                                                    icon: Icon(Icons
                                                        .add_circle_outlined),
                                                    color: Colors.white,
                                                    onPressed: () {
                                                      BlocProvider.of<ShoppingBloc>(context)
                                                          .add(AddProductEvent(
                                                        product: product,
                                                      ));
                                                    },
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                      // if(receipt.lojas.length-1==index0)
                                      //   SizedBox(height: MediaQuery.of(context).size.height*0.3,)
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ),

                    ],
                  ),
                );
              }
              return G20Loading();
            }),
      ),
    );
  }
}
