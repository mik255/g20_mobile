import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:g20newapp/modules/home/homeProvider.dart';
import 'package:g20newapp/modules/home/models/order.model.dart';
import 'package:g20newapp/shared/Shopping/bloc/bloc.dart';
import 'package:g20newapp/shared/Shopping/bloc/states.dart';
import 'package:g20newapp/shared/theme/logo.dart';
import 'package:g20newapp/shared/user/bloc/bloc.dart';
import 'package:g20newapp/shared/user/model/user.dart';
import 'package:g20newapp/shared/userPrefereces/deviceSetings.dart';
import 'package:g20newapp/shared/util/SharedFunctions.dart';
import 'package:g20newapp/shared/util/screamShot.dart';
import 'package:g20newapp/shared/widgets/loadingWidget.dart';
import 'package:g20newapp/shared/widgets/showModel.dart';
import 'package:screenshot/screenshot.dart';

class OrderPage extends StatefulWidget {
  OrderPage({
    Key? key,
    required this.order,
    required this.callback,
  }) : super(key: key);
  Order order;
  Future<void> Function(Order order) callback;

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final scaffoldState = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  late File? _imageFile;
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShoppingBloc, ShoppingState>(listener: (c, state) {
      if (state is ShoppingFinishBidState) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeProvider()));
      }
    }, builder: (context, state) {
      if (state is ShoppingLoading) {
        return G20Loading();
      }
      return _page(context);
    });
  }

  _page(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showModelSheet(context, 0, scaffoldState, 'Compartilhar', close: false,
          onTap: () async {
            await widget.callback.call(widget.order);
      });
    });
    User? user = BlocProvider.of<UserBloc>(context).user;
    double width = deviceWidth(context);
    double height = deviceHeight(context);
    double total = 0;
    widget.order.products!.forEach((element) {
      total += (element.price! * element.count!);
    });
    return Scaffold(
      key: scaffoldState,
      body: Container(
          height: height,
          color: Colors.blue,
          child: Swiper(
            loop: false,
            pagination: new SwiperPagination(
              alignment: Alignment.bottomLeft,
              builder: new FractionPaginationBuilder(
                  color: Colors.grey, activeColor: Color(0xff226edc)),
            ),
            control: new SwiperControl(
              color: Colors.transparent,
            ),
            itemCount: 1,
            itemBuilder: (context, i) => Container(
              height: height,
              width: width,
              decoration: BoxDecoration(color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    Container(
                      height: height * 0.03,
                      width: width * 0.3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(18),
                            bottomRight: Radius.circular(18),
                          ),
                          color: Colors.black45),
                      child: Center(
                          child: Text(
                        'Recibo',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )),
                    ),
                    Container(
                      child: Row(
                        children: [
                          CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.black54,
                              child: logo()),
                          SizedBox(
                            width: 24,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'nome: ${user!.name}',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18),
                              ),
                              Text(
                                  'cnpj/cpf: ${user.indentify?.cnpj ?? user.indentify?.cpf}'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    Text(
                      'Pedido',
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w400,
                          fontSize: 18),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: widget.order.products!.length,
                        itemBuilder: (context, index) {
                          var item = widget.order.products![index];
                          return Column(
                            children: [
                              item.count != 0
                                  ? Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.4),
                                            spreadRadius: 2,
                                            blurRadius: 3,
                                            offset: Offset(0, 2),
                                          )
                                        ],
                                        color: index % 2 == 0
                                            ? Color(0xffE0E0E0)
                                            : Colors.white,
                                      ),
                                      height: 50,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              '${item.count}x ${item.name}',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 18),
                                            ),
                                            Spacer(),
                                            Text(
                                              FormatMoney(item.price!),
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 18),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container(),
                              item.count != 0
                                  ? Container(
                                      height: 8,
                                    )
                                  : Container(),
                              if (index == widget.order.products!.length - 1)
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.4),
                                        spreadRadius: 2,
                                        blurRadius: 3,
                                        offset: Offset(0, 2),
                                      )
                                    ],
                                    color: Colors.black45,
                                  ),
                                  height: 50,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Total deste receiptHistory',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18),
                                        ),
                                        Spacer(),
                                        Text(
                                          FormatMoney(total),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              if (index == widget.order.products!.length - 1)
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.4),
                                        spreadRadius: 2,
                                        blurRadius: 3,
                                        offset: Offset(0, 2),
                                      )
                                    ],
                                    color: Colors.green,
                                  ),
                                  height: 50,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'logista',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18),
                                        ),
                                        Spacer(),
                                        Text(
                                          user.name ?? 'sem nome',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          );
                        }),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 2),
                            )
                          ],
                          color: Colors.white),
                      child: Center(
                        child: Text(
                          'Observação',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w400,
                              fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      '11 de janeiro de 2022',
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w400,
                          fontSize: 18),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
