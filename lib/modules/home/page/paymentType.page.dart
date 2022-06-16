import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g20newapp/modules/categorias/models/story.dart';
import 'package:g20newapp/modules/home/components/paymnentCard.dart';
import 'package:g20newapp/shared/Shopping/bloc/bloc.dart';
import 'package:g20newapp/shared/Shopping/bloc/events.dart';
import 'package:g20newapp/shared/user/bloc/bloc.dart';
import 'package:g20newapp/shared/theme/style.dart';
import 'package:g20newapp/shared/util/SharedFunctions.dart';
import 'package:g20newapp/shared/widgets/receipt/model/receipt.dart';
import 'package:g20newapp/shared/widgets/receipt/model/receiptStories.dart';
import 'package:g20newapp/shared/widgets/receipt/receiptPage.dart';

import '../../../shared/widgets/button.dart';

class PaymentTypePage extends StatefulWidget {
  PaymentTypePage({Key? key, required this.total}) : super(key: key);
  double total;

  @override
  State<PaymentTypePage> createState() => _PaymentTypePageState();
}

class _PaymentTypePageState extends State<PaymentTypePage> {
  List<Map<String, dynamic>> pagamentos = [
    {
      'color': Color(0xff17fbb6),
      'cardName': 'Dinheiro',
      'nome': 'money',
      'icon': Icon(Icons.money)
    },
    {
      'cardName': 'Pix',
      'color': Color(0xff18A0FB),
      'nome': 'pix',
      'icon': Icon(Icons.receipt)
    },
    {
      'color': Color(0xff1873FB),
      'cardName': 'Lojista',
      'nome': 'logist',
      'icon': Icon(Icons.receipt)
    },
    {
      'color': Color(0xff6E18FB),
      'cardName': 'cartão',
      'nome': 'card',
      'icon': Icon(Icons.credit_card)
    },
  ];

  late ShoppingBloc shoppingBloc;
  late List<Store> stores;

  @override
  initState() {
    shoppingBloc = BlocProvider.of<ShoppingBloc>(context);
    stores = shoppingBloc.category.stores!
        .where((e) => (e.products!.where((e) => e.count! > 0).length > 0))
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Pagamento",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontFamily: "Inter",
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      backgroundColor: Colors.blue,
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: backgroundBoxDecoration(),
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Container(
                          width: 170,
                          height: 100,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 16,
                                    child: FittedBox(
                                      child: Text(
                                        "total",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w300,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4.50),
                              SizedBox(
                                height: 39,
                                child: FittedBox(
                                  child: Text(
                                    FormatMoney(widget.total),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 48,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w300,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.50),
                              SizedBox(
                                width: 227,
                                height: 12,
                                child: Text(
                                  "total de todos os produtos",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.white38,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                          height: 62,
                          child: Text(
                            "Escolha um método de pagamento para cada loja",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: stores.length,
                        itemBuilder: (context, index) => paymnentCart(stores[index]),
                      )),
                    ],
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Button(
                text: "Gerar Recibo",
                onPressed: () {
                  {
                    bool isAllSetPayment = true;
                    stores.forEach((element) {
                      if(element.paymentMethod == null) {
                        isAllSetPayment = false;
                        return;
                      }
                    });
                    if(!isAllSetPayment){
                      ScaffoldMessenger.of(context).showMaterialBanner(
                          MaterialBanner(
                            backgroundColor: Colors.black38,
                            content:
                            Text('Selecione todos os métodos de pagamentos',
                              style: TextStyle(color:Colors.white),),
                            leading: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(Icons.warning_amber_outlined,color: Colors.black38,)),
                            actions: [
                              FlatButton(
                                child: const Text('Fechar',style: TextStyle(color: Colors.white),),
                                onPressed: () { ScaffoldMessenger.of(context)
                                    .hideCurrentMaterialBanner();},
                              ),
                            ],
                          )
                      );
                      return;
                    }

                    List<ReceiptStories> receiptStories = [];
                    stores.forEach((element) {
                      receiptStories.add(ReceiptStories(
                          storeId: element,
                          products: element.products,
                          paymentType: element.paymentMethod));
                    });

                    Receipt receipt = Receipt(
                        userId: userBloc.user!.sId,
                        categoryName: shoppingBloc.category.name,
                        paymentType: 'card',
                        receiptStories: receiptStories,
                        totalPrice: shoppingBloc.total,
                        totalPriceSquare: shoppingBloc.totalSquare,
                        date: DateTime.now().toIso8601String());

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ReceiptPage(
                          receipt: receipt,
                          callback: (Receipt receipt) async {
                            shoppingBloc.add(SendReceiptEvent(
                                receipt: receipt));
                          },
                        )));
                  }
                },
                ),
          ),
        ],
      ),
    );
  }
}
