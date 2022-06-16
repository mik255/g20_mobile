import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g20newapp/modules/categorias/categoria.provider.dart';
import 'package:g20newapp/modules/categorias/models/product.dart';
import 'package:g20newapp/modules/home/bloc/homeBloc.dart';
import 'package:g20newapp/modules/home/bloc/states.dart';
import 'package:g20newapp/modules/home/components/snackBarComponent.dart';
import 'package:g20newapp/shared/Shopping/bloc/bloc.dart';
import 'package:g20newapp/shared/Shopping/bloc/states.dart';
import 'package:g20newapp/shared/widgets/loadingWidget.dart';
import 'package:g20newapp/shared/widgets/searchWidget.dart';
import '../components/drawerComponent.dart';
import '../components/productComponent.dart';
import '../components/storeCategoryComponent.dart';

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
                        title: Text(homebloc.shoppingBloc.category.name!),
                      ),
                      drawer: DrawerComponent(),
                      key: _scaffoldKey,
                      backgroundColor: Colors.blue,
                      body: BlocConsumer<ShoppingBloc, ShoppingState>(
                          listener: (ctx, state) {},
                          builder: (ctx, state) {
                            if (state is ShoppingMainState) {
                              snackBarComponent(context, _scaffoldKey, state);
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
                                              SearchWidget(hintText: 'Procurar por um produto na loja',),
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
                                                                StoreCategoryComponent(
                                                                  homeBloc:
                                                                      homebloc,
                                                                  index: index,
                                                                  state: state,
                                                                )
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
                                                            Product product =
                                                                homebloc
                                                                    .currentStore
                                                                    .products![index];
                                                            return ProductComponent(
                                                              index: index,
                                                              product: product,
                                                              homeBloc:
                                                                  homebloc,
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
}
