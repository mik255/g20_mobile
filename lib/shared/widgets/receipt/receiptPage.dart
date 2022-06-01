import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:g20newapp/shared/util/dateUtil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:g20newapp/modules/home/homeProvider.dart';
import 'package:g20newapp/modules/home/models/order.model.dart';
import 'package:g20newapp/shared/Shopping/bloc/bloc.dart';
import 'package:g20newapp/shared/Shopping/bloc/states.dart';
import 'package:g20newapp/shared/user/bloc/bloc.dart';
import 'package:g20newapp/shared/user/model/user.dart';
import 'package:g20newapp/shared/util/SharedFunctions.dart';
import 'package:g20newapp/shared/widgets/loadingWidget.dart';
import 'package:g20newapp/shared/widgets/showModel.dart';
import 'package:screenshot/screenshot.dart';
import 'model/receipt.dart';
import 'dart:io';

class ReceiptPage extends StatefulWidget {
  ReceiptPage({
    Key? key,
    required this.receipt,
    required this.callback,
  }) : super(key: key);
  Receipt receipt;
  Future<void> Function(Receipt receipt) callback;

  @override
  _ReceiptPageState createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  ScreenshotController screenshotController = ScreenshotController();
  final scaffoldState = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  late File? _imageFile;

  _takeScreenshotandShare() async {
    _imageFile = null;
    screenshotController
        .capture(delay: Duration(milliseconds: 10), pixelRatio: 2.0)
        .then((File image) async {
      setState(() {
        _imageFile = image;
      });
      final directory = (await getApplicationDocumentsDirectory()).path;
      Uint8List pngBytes = _imageFile!.readAsBytesSync();
      File imgFile = new File('$directory/screenshot.png');
      imgFile.writeAsBytes(pngBytes);
      print("File Saved to Gallery");
      await Share.file('Anupam', 'screenshot.png', pngBytes, 'image/png');
    }).catchError((onError) {
      print(onError);
    });
  }

  String paymentMethod() {
    switch (widget.receipt.paymentType) {
      case 'card':
        return 'Cartão';
      case 'pix':
        return 'Pix';
      case 'logist':
        return 'Boleto';
      case 'money':
        return 'Dinheiro';
    }
    return 'null';
  }

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
      return Screenshot(
          controller: screenshotController, child: _page(context));
    });
  }

  Widget _page(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showModelSheet(context, widget.receipt.totalPrice!, scaffoldState,'Finalizar',
          close: false, onTap: () async {
        isLoading = true;
        setState(() {});
        String message = 'sucess';
        try {
          await widget.callback.call(widget.receipt);
        } catch (e, _) {
          print(e);
          print(_);
          message = e.toString();
        }
        isLoading = false;
        setState(() {});
        return message;
      });
    });
    User? user = BlocProvider.of<UserBloc>(context).user;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 64.0),
          child: FloatingActionButton(
            highlightElevation: 50,
            elevation: 8,
            backgroundColor: Colors.blue,
              child: Icon(Icons.share),
              onPressed: () async {
                await _takeScreenshotandShare();
              }),
        ),
        key: scaffoldState,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
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
                    itemCount: widget.receipt.receiptStories==null?0:widget.receipt.receiptStories?.length,
                    itemBuilder: (context, i) => SingleChildScrollView(
                      child: Container(
                        height: height,
                        width: width,
                        decoration: BoxDecoration(color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
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
                                        child: Icon(
                                          Icons.person,
                                          size: 80,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 24,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            user!.name!,
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          Text(
                                              '${UtilBrasilFields.obterCnpj(user.indentify?.cnpj ?? '')}'),
                                          Text(
                                              '${AppDateUtil.dateToString(DateTime.parse(widget.receipt.date!))}'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(),
                                Text(
                                  '${widget.receipt.receiptStories![i].storeId!.name}',
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: widget
                                        .receipt.receiptStories![i].products!.length,
                                    itemBuilder: (context, index) {
                                      var item = widget
                                          .receipt.receiptStories![i].products![index];
                                      return Column(
                                        children: [
                                          item.count != 0
                                              ? Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(10)),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.4),
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
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8.0),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          '${item.count}x ${item.name}',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black54,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              fontSize: 18),
                                                        ),
                                                        Spacer(),
                                                        Text(
                                                          FormatMoney(
                                                              item.price!),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black54,
                                                              fontWeight:
                                                                  FontWeight.bold,
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
                                          if (index ==
                                              widget.receipt.receiptStories![i].products!
                                                      .length -
                                                  1)
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.4),
                                                    spreadRadius: 2,
                                                    blurRadius: 3,
                                                    offset: Offset(0, 2),
                                                  )
                                                ],
                                                color: Colors.black45,
                                              ),
                                              height: 50,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Total deste recibo',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18),
                                                    ),
                                                    Spacer(),
                                                    Text(
                                                      FormatMoney(widget
                                                          .receipt.totalPrice!),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          if (index ==
                                              widget.receipt.receiptStories![i].products!
                                                      .length -
                                                  1)
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.4),
                                                    spreadRadius: 2,
                                                    blurRadius: 3,
                                                    offset: Offset(0, 2),
                                                  )
                                                ],
                                                color: Colors.green,
                                              ),
                                              height: 50,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Pagamento',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18),
                                                    ),
                                                    Spacer(),
                                                    Text(
                                                      '${paymentMethod()} / Lojista',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
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
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextField(
                                            maxLines: 10,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Observação',
                                            ),
                                          ))),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  AppDateUtil.dateToString(DateTime.parse(widget.receipt.date!)),
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () async {
                    await _takeScreenshotandShare();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
  _takeScreenshotandShare() async {
    _imageFile = null;
    screenshotController
        .capture(delay: Duration(milliseconds: 10), pixelRatio: 2.0)
        .then((File image) async {
      setState(() {
        _imageFile = image;
      });
      final directory = (await getApplicationDocumentsDirectory()).path;
      Uint8List pngBytes = _imageFile!.readAsBytesSync();
      File imgFile = new File('$directory/screenshot.png');
      imgFile.writeAsBytes(pngBytes);
      print("File Saved to Gallery");
      await Share.file('Anupam', 'screenshot.png', pngBytes, 'image/png');
    }).catchError((onError) {
      print(onError);
    });
  }
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
      showModelSheet(context, 0, scaffoldState,'Compartilhar', close: false, onTap: () async {
        await _takeScreenshotandShare();
      });
    });
    User? user = BlocProvider.of<UserBloc>(context).user;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
            itemBuilder: (context, i) => SingleChildScrollView(
              child: Container(
                height: height,
                width: width,
                decoration: BoxDecoration(color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
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
                                child: Icon(
                                  Icons.person,
                                  size: 80,
                                  color: Colors.white,
                                ),
                              ),
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
                                        fontWeight: FontWeight.bold,
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
                              fontWeight: FontWeight.bold,
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
                                                color: Colors.black
                                                    .withOpacity(0.4),
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                                Spacer(),
                                                Text(
                                                  FormatMoney(item.price!),
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                  if (index ==
                                      widget.order.products!.length - 1)
                                    Container(
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
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                            Spacer(),
                                            Text(
                                              FormatMoney(total),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  if (index ==
                                      widget.order.products!.length - 1)
                                    Container(
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
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                            Spacer(),
                                            Text(
                                              user.name ?? 'sem nome',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
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
                                  fontWeight: FontWeight.bold,
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
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
