import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g20newapp/modules/categorias/models/story.dart';
import 'package:g20newapp/shared/Shopping/bloc/bloc.dart';
import 'package:g20newapp/shared/Shopping/bloc/events.dart';
import 'package:g20newapp/shared/Shopping/bloc/states.dart';
import 'package:g20newapp/shared/user/bloc/bloc.dart';
import 'package:g20newapp/shared/widgets/receipt/model/receipt.dart';
import 'package:g20newapp/shared/widgets/receipt/receiptPage.dart';

class PaymentTypePage extends StatelessWidget {
  PaymentTypePage({Key? key}) : super(key: key);

  List<Map<String, dynamic>> pagamentos = [
    {
      'nome': 'Pix',
      'img': 'https://psfonttk.com/wp-content/uploads/2021/08/logo-pix-png.png'
    },
    {
      'nome': 'Dinheiro',
      'img':
          'https://d168rbuicf8uyi.cloudfront.net/wp-content/uploads/2019/12/17155939/dinheiro-1024x682.jpg'
    },
    {
      'nome': 'Cartão',
      'img':
          'https://www.remessaonline.com.br/blog/wp-content/uploads/2022/01/shutterstock_1677488197-scaled.jpg.optimal.jpg'
    },
    {
      'nome': 'Lojista',
      'img':
          'https://www.megalojista.com.br/media/wysiwyg/New-Banners-Mega-Lojista---Porto-Theme-1.jpg'
    },
  ];

  @override
  Widget build(BuildContext context) {
    ShoppingBloc shoppingBloc = BlocProvider.of<ShoppingBloc>(context);
    UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: Text("Método de pagamento"),
      ),
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 2),
                  )
                ],
                color: Colors.white,
              ),
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 80,
                  ),
                  Expanded(
                    child: CustomScrollView(
                      primary: false,
                      slivers: <Widget>[
                        SliverPadding(
                          padding: const EdgeInsets.all(8),
                          sliver: SliverGrid.count(
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              crossAxisCount: 2,
                              children:
                                  List.generate(pagamentos.length, (index) {
                                return Stack(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                         shoppingBloc.paymentType = 'card';
                                        List<Store> stores = shoppingBloc
                                            .category.stores!
                                            .where((e) => (e.products!
                                                    .where((e) => e.count > 0)
                                                    .length >
                                                0))
                                            .toList();
                                        Receipt receipt = Receipt(
                                            userId: userBloc.user!.sId,
                                            categoryId:
                                                shoppingBloc.category.sId,
                                            paymentType:
                                                shoppingBloc.paymentType,
                                            stories: stores,
                                            totalPrice: shoppingBloc.total,
                                            totalPriceSquare:
                                                shoppingBloc.totalSquare);
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ReceiptPage(
                                                      receipt: receipt,
                                                      callback:
                                                          (Receipt receipt) async{
                                                        shoppingBloc.add(
                                                            SendReceiptEvent(
                                                                receipt:
                                                                    receipt));
                                                      },
                                                    )));
                                      },
                                      child: Container(
                                        height: 180,
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(25)),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.08),
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
                                              child: Image.network(
                                                pagamentos[index]['img'],
                                                fit: BoxFit.cover,
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
                                                          child: Text(
                                                        pagamentos[index]
                                                            ['nome'],
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18),
                                                      )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              })),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
