import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g20newapp/modules/categorias/categoria.provider.dart';
import 'package:g20newapp/modules/categorias/models/product.dart';
import 'package:g20newapp/modules/categorias/pages/categoriasPage.dart';
import 'package:g20newapp/modules/chartResults/chartResult.provider.dart';
import 'package:g20newapp/modules/home/bloc/homeBloc.dart';
import 'package:g20newapp/modules/home/bloc/homeEvent.dart';
import 'package:g20newapp/modules/home/bloc/states.dart';
import 'package:g20newapp/modules/home/page/cashier.page.dart';
import 'package:g20newapp/modules/receiptHistory/receiptHistoryProvider.dart';
import 'package:g20newapp/shared/Shopping/bloc/bloc.dart';
import 'package:g20newapp/shared/Shopping/bloc/events.dart';
import 'package:g20newapp/shared/Shopping/bloc/states.dart';
import 'package:g20newapp/shared/util/SharedFunctions.dart';
import 'package:g20newapp/shared/widgets/loadingWidget.dart';
import 'package:g20newapp/shared/widgets/showModel.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PersistentBottomSheetController? persistentBottomSheetController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    HomeBloc homebloc = BlocProvider.of<HomeBloc>(context);
    return SafeArea(
        child: WillPopScope(
            onWillPop: () async {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CategoryProvider()));
              return false;
            },
            child: BlocConsumer<HomeBloc, HomeState>(
                listener: (ctx, homeState) {},
                builder: (ctx, homeState) {
                  return Scaffold(
                      appBar: AppBar(
                        shadowColor: Colors.transparent,
                        centerTitle: true,
                        title: Text("Produtos"),
                      ),
                      drawer: Drawer(
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            const DrawerHeader(
                              decoration: BoxDecoration(
                                color: Colors.blue,
                              ),
                              child: Text('Menu'),
                            ),
                            ListTile(
                              title: const Text('Lucro com G20'),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        MeusRecibosProvider()));
                              },
                            ),
                            ListTile(
                              title: const Text('Meus Recibos'),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        ReceiptHistoryProvider()));
                              },
                            ),
                          ],
                        ),
                      ),
                      key: _scaffoldKey,
                      backgroundColor: Colors.blue,
                      body: BlocConsumer<ShoppingBloc, ShoppingState>(
                          listener: (ctx, state) {},
                          builder: (ctx, state) {
                            if (state is ShoppingMainState) {
                              WidgetsBinding.instance
                                  .addPostFrameCallback((timeStamp) {
                                showModelSheet(
                                    context, state.total, _scaffoldKey, 'Caixa',
                                    close: state.category.stores!.length == 0,
                                    onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => CashierPage()));
                                });
                              });
                              return Stack(
                                children: [
                                  Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25),
                                            topRight: Radius.circular(25),
                                          ),
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
                                        height:
                                            MediaQuery.of(context).size.height,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8.0, 16, 8, 0),
                                          child: SingleChildScrollView(
                                            child: Column(children: [
                                              searchComponet(),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.1,
                                                child: ListView(
                                                    physics:
                                                        BouncingScrollPhysics(),
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    children: List.generate(
                                                        state.category.stores!
                                                            .length,
                                                        (index) => Column(
                                                              children: [
                                                                InkWell(
                                                                  onTap: () {
                                                                    homebloc.add(SelectLojaEvent(
                                                                        store: state
                                                                            .category
                                                                            .stores![index]));
                                                                  },
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          50,
                                                                      width:
                                                                          100,
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
                                                                          color: homebloc.currentStore == state.category.stores![index] ? Colors.blue : Colors.white),
                                                                      child: Center(
                                                                          child: Text(
                                                                        state.category.stores!.toList()[index].name ??
                                                                            "null",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        maxLines:
                                                                            3,
                                                                        style: TextStyle(
                                                                            overflow: TextOverflow
                                                                                .ellipsis,
                                                                            color: homebloc.currentStore == state.category.stores![index]
                                                                                ? Colors.white
                                                                                : Colors.blue),
                                                                      )),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ))),
                                              ),
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.58,
                                                child: CustomScrollView(
                                                  primary: false,
                                                  slivers: <Widget>[
                                                    SliverPadding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      sliver: SliverGrid.count(
                                                          crossAxisSpacing: 10,
                                                          mainAxisSpacing: 10,
                                                          crossAxisCount: 2,
                                                          children: List.generate(
                                                              homebloc
                                                                  .currentStore
                                                                  .products!
                                                                  .length,
                                                              (index) {
                                                            Product product = homebloc.currentStore.products![index];
                                                            return Stack(
                                                              children: [
                                                                InkWell(
                                                                  onTap: () {
                                                                    homebloc
                                                                        .shoppingBloc
                                                                        .add(AddProductEvent(
                                                                            product:
                                                                                product));
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    height: 180,
                                                                    clipBehavior:
                                                                        Clip.hardEdge,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.all(Radius.circular(25)),
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                            color:
                                                                                Colors.black.withOpacity(0.08),
                                                                            spreadRadius:
                                                                                5,
                                                                            blurRadius:
                                                                                7,
                                                                            offset:
                                                                                Offset(0, 2),
                                                                          )
                                                                        ],
                                                                        color: Colors.white),
                                                                    child:
                                                                        Stack(
                                                                      children: [
                                                                        Container(
                                                                          height:
                                                                              180,
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
                                                                          alignment:
                                                                              Alignment.topLeft,
                                                                          child:
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(
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
                                                                            height:
                                                                                40,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Text(
                                                                                FormatMoney(homebloc.currentStore.products![index].price ?? 0.0),
                                                                                style: TextStyle(color: Colors.white, fontSize: 18),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Align(
                                                                          alignment:
                                                                              Alignment.bottomCenter,
                                                                          child:
                                                                              Row(
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
                                                                if (product
                                                                        .count! >
                                                                    0)
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topRight,
                                                                    child:
                                                                        CircleAvatar(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .red,
                                                                      radius:
                                                                          18,
                                                                      child:
                                                                          Text(
                                                                        product
                                                                            .count
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                    ),
                                                                  ),
                                                              ],
                                                            );
                                                          })),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ]),
                                          ),
                                        ),
                                      )),
                                ],
                                // ignore: missing_return, missing_return
                              );
                            }
                            return G20Loading();
                          }));
                })));
  }

  Widget searchComponet() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 2),
            )
          ],
          color: Colors.white),
      child: Row(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Procure por um produto na loja"),
            ),
          )),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Icon(Icons.search),
          )
        ],
      ),
    );
  }
}
